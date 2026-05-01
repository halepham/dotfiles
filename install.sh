#!/usr/bin/env bash

set -euo pipefail

# ----------------------------------------------------------------------------
# Globals
# ----------------------------------------------------------------------------
DOTFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="${DOTFILE_DIR}/backup"
SKIP_GITCONFIG=false
WARNINGS=()
FAILED_TOOLS=()

# Detect OS
IS_WINDOWS=false
case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*) IS_WINDOWS=true ;;
    *)                    IS_WINDOWS=false ;;
esac

# Dry-run mode: print commands instead of executing them
DRY_RUN=false

# Neovim config path
if $IS_WINDOWS; then
    _localappdata_unix="$(echo "$LOCALAPPDATA" | sed 's|\\|/|g' | sed 's|^\([A-Za-z]\):|/\L\1|')"
    NVIM_CONFIG_DIR="${_localappdata_unix}/nvim"
else
    NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/nvim"
fi

# PowerShell profile path (Windows only)
POWERSHELL_PROFILE=""
if $IS_WINDOWS; then
    _ps_profile="$(powershell.exe -NoProfile -Command 'Write-Output $PROFILE' 2>/dev/null | tr -d '\r')"
    POWERSHELL_PROFILE="$(echo "$_ps_profile" | sed 's|\\|/|g' | sed 's|^\([A-Za-z]\):|/\L\1|')"
fi

# ----------------------------------------------------------------------------
# Colors
# ----------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ----------------------------------------------------------------------------
# Logging helpers
# ----------------------------------------------------------------------------
log_info()    { echo -e "${BLUE}[INFO]${NC}  $*"; }
log_success() { echo -e "${GREEN}[OK]${NC}    $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${NC}  $*"; }
log_error()   { echo -e "${RED}[ERROR]${NC} $*"; }
log_section() {
    echo -e "\n${CYAN}======================================${NC}"
    echo -e "${CYAN}  $*${NC}"
    echo -e "${CYAN}======================================${NC}"
}

# ----------------------------------------------------------------------------
# Command runner
# ----------------------------------------------------------------------------
run() {
    if $DRY_RUN; then
        echo -e "${BLUE}[DRY-RUN]${NC} $*"
    else
        eval "$@"
    fi
}

has() { command -v "$1" &>/dev/null; }

# ----------------------------------------------------------------------------
# Convert Unix path to Windows path
# ----------------------------------------------------------------------------
to_win_path() {
    if $IS_WINDOWS; then
        echo "$1" | sed 's|^/\([a-zA-Z]\)/|\1:/|'
    else
        echo "$1"
    fi
}

# ----------------------------------------------------------------------------
# Resolve variable placeholders in a path string.
# Supports: ${HOME}, ${NVIM_CONFIG_DIR}, ${POWERSHELL_PROFILE}
# ----------------------------------------------------------------------------
resolve_path() {
    local path="$1"
    path="${path//\$\{HOME\}/${HOME}}"
    path="${path//\$\{NVIM_CONFIG_DIR\}/${NVIM_CONFIG_DIR}}"
    path="${path//\$\{POWERSHELL_PROFILE\}/${POWERSHELL_PROFILE}}"
    echo "$path"
}

# ----------------------------------------------------------------------------
# Backup an existing file or folder into BACKUP_DIR
# ----------------------------------------------------------------------------
backup_if_exists() {
    local target="$1"
    if [[ -e "$target" || -L "$target" ]]; then
        local basename timestamp backup_path
        basename="$(basename "$target")"
        timestamp="$(date +%Y%m%d%H%M%S)"
        backup_path="${BACKUP_DIR}/${basename}.${timestamp}"
        log_warn "Backing up: $target -> $backup_path"
        run "mkdir -p '${BACKUP_DIR}'"
        run "mv '$target' '$backup_path'"
    fi
}

# ----------------------------------------------------------------------------
# Create a symbolic link.
# On Linux  : ln -sf
# On Windows: PowerShell New-Item Junction for folders, copy for files.
# Skips if already linked to the same target.
# ----------------------------------------------------------------------------
make_link() {
    local src="$1"
    local dst="$2"

    local src_abs
    src_abs="$(cd "$(dirname "$src")" && pwd)/$(basename "$src")"

    # Skip if already linked to the same target
    if [[ -L "$dst" ]]; then
        local current_target
        current_target="$(readlink -f "$dst" 2>/dev/null || true)"
        if [[ "$current_target" == "$src_abs" ]]; then
            log_info "Already linked, skip: $dst"
            return
        fi
    fi

    # Skip if src and dst resolve to the same real path
    if [[ -e "$dst" && ! -L "$dst" ]]; then
        local src_real dst_real
        src_real="$(readlink -f "$src"  2>/dev/null || echo "$src")"
        dst_real="$(readlink -f "$dst" 2>/dev/null || echo "$dst")"
        if [[ "$src_real" == "$dst_real" ]]; then
            log_info "Same location, skip: $dst"
            return
        fi
    fi

    backup_if_exists "$dst"
    run "mkdir -p '$(dirname "$dst")'"

    if $IS_WINDOWS; then
        local ps_src ps_dst
        ps_src="$(to_win_path "$src_abs")"
        ps_dst="$(to_win_path "$dst")"

        if [[ -d "$src" ]]; then
            run "powershell -Command \"New-Item -ItemType Junction -Path '$ps_dst' -Target '$ps_src'\""
        else
            run "powershell -Command \"New-Item -ItemType SymbolicLink -Path '$ps_dst' -Target '$ps_src'\""
        fi
    else
        run "ln -sf '$src_abs' '$dst'"
    fi

    log_success "Linked: $src -> $dst"
}

# ----------------------------------------------------------------------------
# Copy a file with optional override control.
# If override=false and destination already exists, skip and warn.
# ----------------------------------------------------------------------------
make_copy() {
    local src="$1"
    local dst="$2"
    local override="${3:-true}"

    local src_abs
    src_abs="$(cd "$(dirname "$src")" && pwd)/$(basename "$src")"

    if [[ -e "$dst" ]]; then
        if [[ "$override" == "false" ]]; then
            log_warn "File already exists, skip (override=false): $dst"
            return
        fi
        backup_if_exists "$dst"
    fi

    run "mkdir -p '$(dirname "$dst")'"
    run "cp '$src_abs' '$dst'"
    log_success "Copied: $src -> $dst"
}

# ----------------------------------------------------------------------------
# Append file content to a target if a marker line is not already present.
# ----------------------------------------------------------------------------
make_append() {
    local src="$1"
    local dst="$2"
    local marker="$3"

    # Strip carriage return (\r) to handle Windows line endings
    marker="${marker//$'\r'/}"

    if [[ -f "$dst" ]] && grep -qF "$marker" "$dst"; then
        log_info "Marker already found in $dst, skipping append..."
        return
    fi

    log_info "Appending $src -> $dst"
    run "echo '' >> '$dst'"
    run "cat '$src' >> '$dst'"
    log_success "Appended: $src -> $dst"
}

# ----------------------------------------------------------------------------
# Parse package.json [3] and run install actions
# ----------------------------------------------------------------------------
install_tools() {
    log_section "Install Tools"

    local json_file="${DOTFILE_DIR}/package.json"
    if [[ ! -f "$json_file" ]]; then
        log_warn "package.json not found, skipping tool installation."
        return
    fi

    local platform
    $IS_WINDOWS && platform="windows" || platform="linux"

    local json_file_py
    json_file_py="$(to_win_path "$json_file")"

    local tools
    tools="$(python3 - "$json_file_py" "$platform" <<'EOF'
import json, sys

json_path = sys.argv[1]
platform  = sys.argv[2]

with open(json_path) as f:
    data = json.load(f)

def clean(s):
    return str(s).replace('\r', '').replace('\n', ' ').strip()

SEP = "\x1F"

tools = data.get("tools", [])

for tool in tools:
    name   = tool.get("name", "")
    config = tool.get(platform) or tool.get("any")
    if not config:
        continue

    t      = config.get("type", "")
    pkg    = config.get("package", "")
    url    = config.get("url", "")
    bucket = config.get("bucket", "")
    cmds   = config.get("command", [])

    print(f"{clean(name)}|{clean(t)}|{clean(pkg)}|{clean(url)}|{clean(bucket)}|{SEP.join(clean(c) for c in cmds)}")
EOF
)"

    while IFS='|' read -r name type pkg url bucket cmds; do
        [[ -z "$name" ]] && continue
        log_info "Installing ${name}"
        _install_tool "$name" "$type" "$pkg" "$url" "$bucket" "$cmds"
    done <<< "$tools"
}

_install_tool() {
    local name="$1"
    local type="$2"
    local pkg="$3"
    local url="$4"
    local bucket="$5"
    local cmds="$6"

    # Skip if already installed
    if has "$name"; then
        log_info "${name} already installed, skipping."
        return
    fi

    # Special case: lazydocker requires docker to be present
    if [[ "$name" == "lazydocker" ]] && ! has docker; then
        log_info "Docker not found, skipping lazydocker."
        return
    fi

    case "$type" in
        scoop)
            # Skip if scoop itself failed
            if _is_failed "scoop"; then
                log_warn "${name}: skipping -- scoop failed to install."
                WARNINGS+=("${name}: scoop installation failed.")
                return
            fi

            if ! has scoop; then
                log_info "scoop not found, installing scoop..."
                run "powershell -Command \"Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser\""
                run "powershell -Command \"Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression\""

                # Reload PATH after scoop install
                if ! $DRY_RUN; then
                    export PATH="${HOME}/scoop/shims:${PATH}"
                    if ! has scoop; then
                        log_error "scoop installation failed."
                        WARNINGS+=("${name}: scoop installation failed. Please install manually: https://scoop.sh")
                        FAILED_TOOLS+=("scoop")
                        return
                    fi
                fi
            fi

            # Update scoop before installing
            run "scoop update"

            # Add bucket if specified and not already added
            if [[ -n "$bucket" ]]; then
                if ! scoop bucket list | grep -qF "$bucket"; then
                    run "scoop bucket add '${bucket}'"
                fi
            fi

            run "scoop install '${pkg}'"
            ;;
        apt)
            # Check if sudo is available before running apt
            if ! sudo -n true 2>/dev/null; then
                log_warn "${name}: sudo privileges required for apt. Skipping."
                WARNINGS+=("${name}: skipped -- sudo privileges not available.")
                return
            else
                run "apt-get install -y '${pkg}'" || {
                    log_error "${name}: apt install failed."
                    WARNINGS+=("${name}: installation failed.")
                    return
                }
            fi
            ;;
        cargo)
            # Skip if cargo itself previously failed
            if _is_failed "rust"; then
                log_warn "${name}: skipping -- Rust installation previously failed."
                WARNINGS+=("${name}: skipped -- Rust installation failed.")
                return
            fi

            if ! has cargo; then
                log_info "Installing Rust (required for ${name})..."
                run "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"

                # Reload cargo env after install
                if ! $DRY_RUN; then
                    # shellcheck source=/dev/null
                    if [[ -f "${HOME}/.cargo/env" ]]; then
                        source "${HOME}/.cargo/env"
                    fi

                    # If cargo still not available after install, skip
                    if ! has cargo; then
                        log_warn "${name}: Rust installation failed, skipping."
                        WARNINGS+=("${name}: skipped -- Rust installation failed.")
                        FAILED_TOOLS+=("rust")
                        return
                    fi
                fi
            fi
            run "cargo install '${pkg}'"
            ;;
        git|archive)
            IFS=$'\x1F' read -ra cmd_list <<< "$cmds"
            for cmd in "${cmd_list[@]}"; do
                [[ -z "$cmd" ]] && continue
                cmd="${cmd//\$\{url\}/$url}"
                cmd="${cmd//\$\{HOME\}/$HOME}"
                run "$cmd"
            done
            ;;
        *)
            log_warn "Unknown install type '${type}' for tool '${name}', skipping."
            ;;
    esac

    log_success "${name} installed"
}

# ----------------------------------------------------------------------------
# Check if a tool is in the FAILED_TOOLS list
# ----------------------------------------------------------------------------
_is_failed() {
    local name="$1"
    for failed in "${FAILED_TOOLS[@]}"; do
        [[ "$failed" == "$name" ]] && return 0
    done
    return 1
}

# ----------------------------------------------------------------------------
# Parse package.json [3] and run setup (link/copy/append) actions
# ----------------------------------------------------------------------------
setup_dotfiles() {
    log_section "Setup Dotfiles"

    local json_file="${DOTFILE_DIR}/package.json"
    if [[ ! -f "$json_file" ]]; then
        log_warn "package.json not found, skipping dotfile setup."
        return
    fi

    local platform
    $IS_WINDOWS && platform="windows" || platform="linux"

    local json_file_py
    json_file_py="$(to_win_path "$json_file")"

    local setups
    setups="$(python3 - "$json_file_py" "$platform" <<'EOF'
import json, sys

json_path = sys.argv[1]
platform  = sys.argv[2]

with open(json_path) as f:
    data = json.load(f)

def clean(s):
    return str(s).replace('\r', '').replace('\n', ' ').strip()

setups = data.get("setup", [])

for setup in setups:
    name    = setup.get("name", "")
    actions = setup.get(platform) or setup.get("any") or []

    for action in actions:
        t        = action.get("type", "")
        source   = action.get("source", "")
        target   = action.get("target", "")
        override = str(action.get("override", True)).lower()
        marker   = action.get("marker", "")
        print(f"{clean(name)}|{clean(t)}|{clean(source)}|{clean(target)}|{clean(override)}|{clean(marker)}")
EOF
)"

    local current_name=""
    while IFS='|' read -r name type source target override marker; do
        [[ -z "$name" ]] && continue

        # Print info header once per setup group
        if [[ "$name" != "$current_name" ]]; then
            log_info "Setting up ${name}"
            current_name="$name"
        fi

        local src dst
        src="${DOTFILE_DIR}/${source}"
        dst="$(resolve_path "$target")"

        # Special handling for gitconfig: skip if real file exists, warn at end
        if [[ "$name" == "gitconfig" && "$override" == "false" ]]; then
            if [[ -f "$dst" && ! -L "$dst" ]]; then
                log_warn ".gitconfig already exists, skipping..."
                SKIP_GITCONFIG=true
                continue
            fi
        fi

        case "$type" in
            link)
                make_link "$src" "$dst"
                ;;
            copy)
                make_copy "$src" "$dst" "$override"
                ;;
            append)
                make_append "$src" "$dst" "$marker"
                ;;
            *)
                log_warn "Unknown setup type '${type}' for '${name}', skipping."
                ;;
        esac
    done <<< "$setups"
}

# ----------------------------------------------------------------------------
# Print summary at the end
# ----------------------------------------------------------------------------
print_summary() {
    log_section "Summary"

    if $SKIP_GITCONFIG; then
        WARNINGS+=("~/.gitconfig already exists -- skipped. Please merge manually if needed.")
    fi

    if $DRY_RUN; then
        echo -e "${BLUE}[DRY-RUN] Dry-run mode is ON. No commands were actually executed.${NC}"
        echo -e "${BLUE}[DRY-RUN] Set DRY_RUN=false in the script to apply changes.${NC}"
    fi

    if [[ ${#WARNINGS[@]} -gt 0 ]]; then
        echo -e "\n${YELLOW}Warnings:${NC}"
        for w in "${WARNINGS[@]}"; do
            echo -e "  [!] $w"
        done
    else
        log_success "All done with no warnings!"
    fi

    echo ""
    log_info "Backup folder : ${BACKUP_DIR}"
    if $IS_WINDOWS; then
        log_info "Reload shell  : restart Git Bash / PowerShell"
    else
        log_info "Reload shell  : source ~/.bashrc"
    fi
}

# ----------------------------------------------------------------------------
# Main
# ----------------------------------------------------------------------------
main() {
    if $IS_WINDOWS; then
        log_section "Dotfile Installer (Windows / Git Bash)"
    else
        log_section "Dotfile Installer (Linux)"
        log_info "Updating apt cache..."
        run "sudo apt-get update -qq"
    fi

    log_info "Dotfile dir : ${DOTFILE_DIR}"
    log_info "Backup dir  : ${BACKUP_DIR}"
    log_info "OS          : $(uname -s)"
    log_info "Dry-run     : ${DRY_RUN}"

    install_tools
    setup_dotfiles
    print_summary
}

main "$@"
