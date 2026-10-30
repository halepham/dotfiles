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
INSTALLED_TOOLS=()
UPDATED_TOOLS=()
SKIPPED_TOOLS=()

# Update mode: upgrade tools that are already installed instead of skipping them
UPDATE_MODE=false

# Which phases to run
RUN_TOOLS=true
RUN_SETUP=true

# Restrict work to these tool names (empty = all tools)
ONLY_TOOLS=()

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
PURPLE='\033[0;35m'
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
# Usage / argument parsing
# ----------------------------------------------------------------------------
usage() {
    cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") [options]

Options:
  -u, --update        Update tools that are already installed (default: skip them)
  -n, --dry-run       Print commands instead of executing them
  -t, --tools-only    Only install/update tools, skip dotfile setup
  -s, --setup-only    Only run dotfile setup, skip tools
  -o, --only NAME     Limit to the given tool (repeatable, e.g. -o nvim -o tmux)
  -h, --help          Show this help and exit

Examples:
  ./install.sh                  # install missing tools + link dotfiles
  ./install.sh --update         # also upgrade tools already installed
  ./install.sh -u -o nvim       # upgrade only nvim
  ./install.sh -u -n            # preview what an update would do
EOF
}

parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -u|--update)     UPDATE_MODE=true ;;
            -n|--dry-run)    DRY_RUN=true ;;
            -t|--tools-only) RUN_SETUP=false ;;
            -s|--setup-only) RUN_TOOLS=false ;;
            -o|--only)
                if [[ -z "${2:-}" ]]; then
                    log_error "--only requires a tool name"
                    exit 1
                fi
                ONLY_TOOLS+=("$2")
                shift
                ;;
            -h|--help)       usage; exit 0 ;;
            *)
                log_error "Unknown option: $1"
                usage
                exit 1
                ;;
        esac
        shift
    done
}

# ----------------------------------------------------------------------------
# Command runner
# ----------------------------------------------------------------------------
run() {
    if $DRY_RUN; then
        echo -e "${PURPLE}[DRY-RUN]${NC} $*"
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
    if $UPDATE_MODE; then
        log_section "Install / Update Tools"
    else
        log_section "Install Tools"
    fi

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

# List items (command / update) are separated by \x1e (record separator)
SEP = "\x1e"

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
    upds   = config.get("update", [])

    # Fields are separated by \x1f (unit separator) because commands may contain '|'
    fields = [name, t, pkg, url, bucket, SEP.join(clean(c) for c in cmds), SEP.join(clean(c) for c in upds)]
    print("\x1f".join(clean(f) for f in fields))
EOF
)"

    # Read the list on fd 3 so that commands which read stdin (fzf install,
    # powershell, scoop, ...) cannot consume the remaining entries.
    while IFS=$'\x1f' read -r -u 3 name type pkg url bucket cmds update_cmds; do
        [[ -z "$name" ]] && continue
        if ! _is_selected "$name"; then
            continue
        fi
        _install_tool "$name" "$type" "$pkg" "$url" "$bucket" "$cmds" "$update_cmds"
    done 3<<< "$tools"
}

_install_tool() {
    local name="$1"
    local type="$2"
    local pkg="$3"
    local url="$4"
    local bucket="$5"
    local cmds="$6"
    local update_cmds="${7:-}"

    local installed=false
    has "$name" && installed=true

    # Already installed and we are not in update mode -> nothing to do
    if $installed && ! $UPDATE_MODE; then
        log_info "${name} already installed, skipping."
        SKIPPED_TOOLS+=("$name")
        return
    fi

    # Special case: lazydocker requires docker to be present
    if [[ "$name" == "lazydocker" ]] && ! has docker; then
        log_info "Docker not found, skipping lazydocker."
        SKIPPED_TOOLS+=("$name")
        return
    fi

    # install = not present yet, update = present and UPDATE_MODE is on
    local action="install"
    $installed && action="update"

    if [[ "$action" == "update" ]]; then
        log_info "Updating ${name}"
    else
        log_info "Installing ${name}"
    fi

    case "$type" in
        scoop)
            _ensure_scoop "$name" || return

            # Refresh scoop and its buckets before install/update
            run "scoop update"

            # Add bucket if specified and not already added
            if [[ -n "$bucket" ]]; then
                if ! scoop bucket list | grep -qF "$bucket"; then
                    run "scoop bucket add '${bucket}'"
                fi
            fi

            if [[ "$action" == "update" ]]; then
                run "scoop update '${pkg}'" || {
                    log_error "${name}: scoop update failed."
                    WARNINGS+=("${name}: update failed.")
                    return
                }
            else
                run "scoop install '${pkg}'" || {
                    log_error "${name}: scoop install failed."
                    WARNINGS+=("${name}: installation failed.")
                    return
                }
            fi
            ;;
        apt)
            # Check if sudo is available before running apt
            if ! sudo -n true 2>/dev/null; then
                log_warn "${name}: sudo privileges required for apt. Skipping."
                WARNINGS+=("${name}: skipped -- sudo privileges not available.")
                return
            fi

            run "sudo apt-get update -qq"

            local apt_flags="-y"
            [[ "$action" == "update" ]] && apt_flags="-y --only-upgrade"

            run "sudo apt-get install ${apt_flags} '${pkg}'" || {
                log_error "${name}: apt ${action} failed."
                WARNINGS+=("${name}: ${action} failed.")
                return
            }
            ;;
        cargo)
            _ensure_cargo "$name" || return

            # cargo install refuses to overwrite an existing binary without --force
            local cargo_flags=""
            [[ "$action" == "update" ]] && cargo_flags="--force"

            run "cargo install ${cargo_flags} '${pkg}'" || {
                log_error "${name}: cargo ${action} failed."
                WARNINGS+=("${name}: ${action} failed.")
                return
            }
            ;;
        git|archive)
            # Use the "update" commands when updating, if provided; otherwise re-run "command"
            local steps="$cmds"
            if [[ "$action" == "update" && -n "$update_cmds" ]]; then
                steps="$update_cmds"
            fi

            local step_list=()
            IFS=$'\x1e' read -r -a step_list <<< "$steps"

            if ! _run_steps "$name" "$url" "${step_list[@]}"; then
                WARNINGS+=("${name}: ${action} failed.")
                return
            fi
            ;;
        *)
            log_warn "Unknown install type '${type}' for tool '${name}', skipping."
            SKIPPED_TOOLS+=("$name")
            return
            ;;
    esac

    if [[ "$action" == "update" ]]; then
        UPDATED_TOOLS+=("$name")
        log_success "${name} updated"
    else
        INSTALLED_TOOLS+=("$name")
        log_success "${name} installed"
    fi
}

# ----------------------------------------------------------------------------
# Run the commands of a git/archive tool one by one and stop at the first
# failure. All commands of a tool run in the same subshell, so a variable
# assigned by one command is available to the next commands, but does not
# leak into this script.
# ----------------------------------------------------------------------------
_run_steps() {
    local name="$1"
    local url="$2"
    shift 2

    (
        set +e
        local step rc
        for step in "$@"; do
            [[ -z "$step" ]] && continue
            step="${step//\$\{url\}/$url}"
            step="${step//\$\{HOME\}/$HOME}"

            if $DRY_RUN; then
                run "$step"
                continue
            fi

            log_info "$step"
            eval "$step"
            rc=$?
            if [[ $rc -ne 0 ]]; then
                log_error "${name}: command failed (exit code ${rc}): $step"
                exit "$rc"
            fi
        done
    )
}

# ----------------------------------------------------------------------------
# Make sure scoop is available (Windows package manager).
# Returns non-zero if it cannot be used.
# ----------------------------------------------------------------------------
_ensure_scoop() {
    local name="$1"

    # Skip if scoop itself failed earlier in this run
    if _is_failed "scoop"; then
        log_warn "${name}: skipping -- scoop failed to install."
        WARNINGS+=("${name}: scoop installation failed.")
        return 1
    fi

    if has scoop; then
        return 0
    fi

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
            return 1
        fi
    fi
    return 0
}

# ----------------------------------------------------------------------------
# Make sure cargo is available (installs Rust via rustup if needed).
# Returns non-zero if it cannot be used.
# ----------------------------------------------------------------------------
_ensure_cargo() {
    local name="$1"

    # Skip if cargo itself previously failed
    if _is_failed "rust"; then
        log_warn "${name}: skipping -- Rust installation previously failed."
        WARNINGS+=("${name}: skipped -- Rust installation failed.")
        return 1
    fi

    if has cargo; then
        return 0
    fi

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
            return 1
        fi
    fi
    return 0
}

# ----------------------------------------------------------------------------
# Check whether a tool was selected with --only (no --only = everything)
# ----------------------------------------------------------------------------
_is_selected() {
    local name="$1"
    [[ ${#ONLY_TOOLS[@]} -eq 0 ]] && return 0
    local want
    for want in "${ONLY_TOOLS[@]}"; do
        [[ "$want" == "$name" ]] && return 0
    done
    return 1
}

# ----------------------------------------------------------------------------
# Check if a tool is in the FAILED_TOOLS list
# ----------------------------------------------------------------------------
_is_failed() {
    local name="$1"
    [[ ${#FAILED_TOOLS[@]} -eq 0 ]] && return 1
    local failed
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
    # Read the list on fd 3 so that commands which read stdin (powershell, ...)
    # cannot consume the remaining entries.
    while IFS='|' read -r -u 3 name type source target override marker; do
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
    done 3<<< "$setups"
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
        echo -e "${PURPLE}[DRY-RUN] Dry-run mode is ON. No commands were actually executed.${NC}"
        echo -e "${PURPLE}[DRY-RUN] Re-run without --dry-run to apply changes.${NC}"
    fi

    if [[ ${#INSTALLED_TOOLS[@]} -gt 0 ]]; then
        echo -e "\n${GREEN}Installed (${#INSTALLED_TOOLS[@]}):${NC} ${INSTALLED_TOOLS[*]}"
    fi
    if [[ ${#UPDATED_TOOLS[@]} -gt 0 ]]; then
        echo -e "${GREEN}Updated (${#UPDATED_TOOLS[@]}):${NC} ${UPDATED_TOOLS[*]}"
    fi
    if [[ ${#SKIPPED_TOOLS[@]} -gt 0 ]]; then
        echo -e "${BLUE}Skipped (${#SKIPPED_TOOLS[@]}):${NC} ${SKIPPED_TOOLS[*]}"
        if ! $UPDATE_MODE; then
            echo -e "${BLUE}Hint:${NC} re-run with --update to upgrade the tools above."
        fi
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
    parse_args "$@"

    log_section "Dotfile Installer"

    log_info "Dotfile dir : ${DOTFILE_DIR}"
    log_info "Backup dir  : ${BACKUP_DIR}"
    log_info "OS          : $(uname -s)"
    log_info "Dry-run     : ${DRY_RUN}"
    if $UPDATE_MODE; then
        log_info "Mode        : install + update"
    else
        log_info "Mode        : install only (use --update to upgrade existing tools)"
    fi
    if [[ ${#ONLY_TOOLS[@]} -gt 0 ]]; then
        log_info "Only        : ${ONLY_TOOLS[*]}"
    fi

    if $RUN_TOOLS; then
        install_tools
    fi
    if $RUN_SETUP; then
        setup_dotfiles
    fi
    print_summary
}

main "$@"
