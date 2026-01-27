-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- These create newlines like o and O but stay in normal mode
vim.keymap.set("n", "zj", "o<Esc>k", { desc = "Add a Newline Above", silent = true })
vim.keymap.set("n", "zk", "O<Esc>j", { desc = "Add a Newline Below", silent = true })

-- hop.nvim
local hop = require("hop")
local directions = require("hop.hint").HintDirection
local position = require("hop.hint").HintPosition
local yank = require("hop-yank")

vim.keymap.set({ "n", "x" }, "f", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR })
end, { desc = "Move to next char", remap = true })
vim.keymap.set({ "n", "x" }, "F", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR })
end, { desc = "Move to prev char", remap = true })
vim.keymap.set({ "n", "x" }, "t", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
end, { desc = "Move before next char", remap = true })
vim.keymap.set({ "n", "x" }, "T", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
end, { desc = "Move before prev char", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>hf", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR })
end, { desc = "Move to next char", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>hF", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR })
end, { desc = "Move to prev char", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>ht", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, hint_offset = -1 })
end, { desc = "Move before next char", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>hT", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, hint_offset = 1 })
end, { desc = "Move before prev char", remap = true })

vim.keymap.set({ "n", "x" }, "<leader>h/", function()
  hop.hint_patterns({ direction = directions.AFTER_CURSOR })
end, { desc = "Hop Forward Search", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>h?", function()
  hop.hint_patterns({ direction = directions.BEFORE_CURSOR })
end, { desc = "Hop Backward Search", remap = true })

vim.keymap.set({ "n", "x" }, "W", function()
  hop.hint_camel_case({ direction = directions.AFTER_CURSOR })
end, { desc = "Next word", remap = true })
vim.keymap.set({ "n", "x" }, "B", function()
  hop.hint_camel_case({ direction = directions.BEFORE_CURSOR })
end, { desc = "Prev word", remap = true })
vim.keymap.set({ "n", "x" }, "E", function()
  hop.hint_camel_case({ direction = directions.AFTER_CURSOR, hint_position = position.END })
end, { desc = "Next end of word", remap = true })
vim.keymap.set({ "n", "x" }, "gE", function()
  hop.hint_camel_case({ direction = directions.BEFORE_CURSOR, hint_position = position.END })
end, { desc = "Prev end of word", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>hw", function()
  hop.hint_camel_case({ direction = directions.AFTER_CURSOR })
end, { desc = "Next word", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>hb", function()
  hop.hint_camel_case({ direction = directions.BEFORE_CURSOR })
end, { desc = "Prev word", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>he", function()
  hop.hint_camel_case({ direction = directions.AFTER_CURSOR, hint_position = position.END })
end, { desc = "Next end of word", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>hge", function()
  hop.hint_camel_case({ direction = directions.BEFORE_CURSOR, hint_position = position.END })
end, { desc = "Prev end of word", remap = true })

vim.keymap.set({ "n", "x" }, "<leader>jj", function()
  hop.hint_vertical({ direction = directions.AFTER_CURSOR })
end, { desc = "Move Vertical Below", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>kk", function()
  hop.hint_vertical({ direction = directions.BEFORE_CURSOR })
end, { desc = "Move Vertical Above", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>hj", function()
  hop.hint_vertical({ direction = directions.AFTER_CURSOR })
end, { desc = "Move Vertical Below", remap = true })
vim.keymap.set({ "n", "x" }, "<leader>hk", function()
  hop.hint_vertical({ direction = directions.BEFORE_CURSOR })
end, { desc = "Move Vertical Above", remap = true })

vim.keymap.set("n", "<leader>yy", function()
  yank.yank_char1({ direction = nil, multi_windows = true, hint_offset = -1 })
end, { desc = "Yank", remap = true })
vim.keymap.set("n", "<leader>yp", function()
  yank.paste_char1({ direction = nil, multi_windows = true, hint_offset = -1 })
end, { desc = "Paste", remap = true })

-- keymaps for vscode only
if vim.g.vscode then
  local vscode = require("vscode")

  local whichKey = {
    show = function()
      vscode.call("whichkey.show")
    end,
  }

  local cursorMove = {
    n_gj = function()
      local moveBy = vim.v.count == 0 and "wrappedLine" or "line"
      vscode.call("cursorMove", {
        args = { to = "down", by = moveBy, value = vim.v.count },
      })
    end,
    n_gk = function()
      local moveBy = vim.v.count == 0 and "wrappedLine" or "line"
      vscode.call("cursorMove", {
        args = { to = "up", by = moveBy, value = vim.v.count },
      })
    end,

    x_gj = function()
      vscode.call("cursorMove", {
        args = { to = "down", by = "wrappedLine", select = true, value = vim.v.count },
      })
    end,
    x_gk = function()
      vscode.call("cursorMove", {
        args = { to = "up", by = "wrappedLine", select = true, value = vim.v.count },
      })
    end,
  }

  local scrollHalfPage = function(to)
    vscode.eval(string.format(
      [[
class EditorViewportState {
  #textEditor;
  #visibleRanges;
  #lineCount;
  #outdated;

  constructor(textEditor) {
    this.#textEditor = textEditor;
    this.#outdated = false;
    this.#visibleRanges = this.#textEditor.visibleRanges.slice();
    this.#lineCount = this.#textEditor.document.lineCount;
    this.cursorPosition = this.#textEditor.selection.active;
    this.cursorOffset = this.offsetFromPosition(this.cursorPosition);
    this.viewportStart = this.#visibleRanges[0]?.start ?? null;
    this.viewportEnd = this.#visibleRanges.at(-1)?.end ?? null;
    if (this.viewportStart !== null) {
      this.isDocumentStartVisible = this.viewportStart.line === 0;
    } else {
      this.isDocumentStartVisible = true;
    }
    if (this.viewportEnd !== null) {
      this.viewportHeightApprox = this.offsetFromPosition(this.viewportEnd) + 1;
      this.viewportHeightApproxHalf = Math.floor(this.viewportHeightApprox / 2);
      this.isDocumentEndVisible = this.viewportEnd.line === this.#lineCount - 1;
    } else {
      this.viewportHeightApprox = 0;
      this.viewportHeightApproxHalf = 0;
      this.isDocumentEndVisible = true;
    }
  }

  static capture() {
    const activeEditor = vscode.window.activeTextEditor;
    if (!activeEditor) {
      throw new Error("No active editor found.");
    }
    return new EditorViewportState(activeEditor);
  }

  offsetFromPosition(position) {
    const ranges = this.#visibleRanges.slice();
    if (ranges.every((range) => !range.contains(position))) {
      return -1;
    }

    // Remove ranges that occur after given position
    const excludeAfter = ranges.findIndex((range) => range.start.line > position.line);
    if (excludeAfter !== -1) {
      ranges.splice(excludeAfter);
    }

    // Update the end position of the last range to the cursor position.
    if (ranges.length > 0) {
      const lastRange = ranges[ranges.length - 1];
      ranges[ranges.length - 1] = lastRange.with({ end: position });
    }

    // Sum of the number of lines for each range
    return ranges
      .map((range) => range.end.line - range.start.line + 1)
      .reduce((acc, cur) => acc + cur, -1);
  }

  // Calculate the position based on the offset from the viewport top.
  positionFromOffset(offset) {
    let acc = 0;
    for (const range of this.#visibleRanges) {
      const rangeLines = range.end.line - range.start.line + 1;
      if (acc + rangeLines > offset) {
        return range.start.with({
          line: range.start.line + (offset - acc)
        });
      }
      acc += rangeLines;
    }
    return null;
  }

  async scroll(direction) {
    if (this.#outdated) {
      throw "Attempt to use an outdated capture"
    }
    this.#outdated = true;

    const scrollHalfPage = async (direction) =>
      vscode.commands.executeCommand('editorScroll', {
        to: direction,
        by: 'halfPage',
        revealCursor: false
      });

    const scrollLines = async (direction, linesToScroll) =>
      vscode.commands.executeCommand('editorScroll', {
        to: direction,
        by: 'line',
        value: linesToScroll,
        revealCursor: false
      });

    let updatedCapture;
    if (direction === 'up') {
      await scrollHalfPage(direction);
      updatedCapture = EditorViewportState.capture();
    } else if (direction === 'down') {
      // Do not scroll down if the end of the document is reached.
      if (this.isDocumentEndVisible) {
        this.#outdated = false;
        return this;
      }

      // Scroll down by half a page, attempting to prevent over-scrolling.
      const viewportBottomMargin = this.#lineCount - (this.viewportEnd.line + 1);
      if (viewportBottomMargin < this.viewportHeightApproxHalf - 1) {
        const linesToScroll = viewportBottomMargin + 1;
        await scrollLines(direction, linesToScroll);
      } else {
        await scrollHalfPage(direction);
      }
      updatedCapture = EditorViewportState.capture();

      // Check if over-scrolling occurred due to undetected folds.
      // Subtract '1' because vscode has scrollOff of minimum 1 for bottom line.
      if (updatedCapture.viewportHeightApprox < this.viewportHeightApprox - 1) {
        const linesToScrollUp = this.viewportHeightApprox - updatedCapture.viewportHeightApprox - 1;
        await scrollLines('up', linesToScrollUp);
        updatedCapture = EditorViewportState.capture();
      }
    } else {
      throw "Invalid argument provided for 'direction'"
    }
    return updatedCapture;
  }

  async moveCursorTo(position) {
    if (this.#outdated) {
      throw "Attempt to use an outdated capture"
    }
    this.#outdated = true;

    let motion;
    let linesToMove = position.line - this.cursorPosition.line;
    if (linesToMove > 0) {
      motion = 'j';
    } else if (linesToMove < 0) {
      linesToMove = -linesToMove;
      motion = 'k';
    } else {
      this.#outdated = false;
      return this;
    }

    // Let Neovim handle the cursor movement, as it preserves the cursor's column position.
    await vscode.commands.executeCommand('vscode-neovim.send', `${linesToMove}${motion}`);
    return EditorViewportState.capture();
  }
}

const scrollDirection = "%s";
if (scrollDirection !== "up" && scrollDirection !== "down") {
  throw "Invalid scrollDirection: must be either 'up' or 'down'";
}

// Scroll the editor
const preScrollCapture = EditorViewportState.capture();
const postScrollCapture = await preScrollCapture.scroll(scrollDirection);
let scrollDelta;
if (scrollDirection === "up") {
  scrollDelta =
    postScrollCapture.offsetFromPosition(preScrollCapture.viewportStart) -
    postScrollCapture.offsetFromPosition(postScrollCapture.viewportStart)
} else if (scrollDirection === "down") {
  scrollDelta =
    preScrollCapture.offsetFromPosition(postScrollCapture.viewportStart) -
    preScrollCapture.offsetFromPosition(preScrollCapture.viewportStart)
}

// Approximate viewport height
let viewportHeightApproxHalf;
if (scrollDirection === "up" && postScrollCapture.isDocumentStartVisible) {
  viewportHeightApproxHalf = postScrollCapture.viewportHeightApproxHalf;
} else if (scrollDirection === "down" && postScrollCapture.isDocumentEndVisible) {
  viewportHeightApproxHalf = preScrollCapture.viewportHeightApproxHalf;
} else {
  viewportHeightApproxHalf = scrollDelta;
}

// Calculate the cursor position to update
const offsetDelta = viewportHeightApproxHalf - scrollDelta;
const preScrollCursorOffset = preScrollCapture.cursorOffset;
let postScrollCursorOffset;
if (scrollDirection === "up") {
  postScrollCursorOffset = Math.max(0, preScrollCursorOffset - offsetDelta);
} else if (scrollDirection === "down") {
  postScrollCursorOffset = Math.min(
    postScrollCapture.viewportHeightApprox - 1,
    preScrollCursorOffset + offsetDelta
  );
}

// Move cursor
const postScrollCursorPosition = postScrollCapture.positionFromOffset(postScrollCursorOffset);
if (postScrollCursorPosition !== null) {
  await postScrollCapture.moveCursorTo(postScrollCursorPosition);
}
    ]],
      to
    ))
  end

  local resizeWindow = {
    increaseHeight = function()
      vscode.call("workbench.action.increaseViewHeight")
    end,

    decreaseHeight = function()
      vscode.call("workbench.action.decreaseViewHeight")
    end,

    increaseWidth = function()
      vscode.call("workbench.action.increaseViewWidth")
    end,

    decreaseWidth = function()
      vscode.call("workbench.action.decreaseViewWidth")
    end,
  }

  -- editor group (<leader>b)
  local editor = {
    save = function()
      vscode.call("workbench.action.files.save")
    end,

    closeAll = function()
      vscode.call("workbench.action.closeAllEditors")
    end,

    switch = function()
      vscode.call("runCommands", {
        args = {
          commands = {
            "workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup",
            "list.select",
          },
        },
      })
    end,

    close = function()
      vscode.call("workbench.action.closeActiveEditor")
    end,

    closeOthers = function()
      vscode.call("workbench.action.closeOtherEditors")
    end,

    closeLeft = function()
      vscode.call("workbench.action.closeEditorsToTheLeft")
    end,

    closeRight = function()
      vscode.call("workbench.action.closeEditorsToTheRight")
    end,

    moveLeftGroup = function()
      vscode.call("workbench.action.moveEditorToLeftGroup")
    end,

    moveRightGroup = function()
      vscode.call("workbench.action.moveEditorToRightGroup")
    end,

    moveBelowGroup = function()
      vscode.call("workbench.action.moveEditorToBelowGroup")
    end,

    moveAboveGroup = function()
      vscode.call("workbench.action.moveEditorToAboveGroup")
    end,

    moveLeftInGroup = function()
      vscode.call("workbench.action.moveEditorLeftInGroup")
    end,

    moveRightInGroup = function()
      vscode.call("workbench.action.moveEditorRightInGroup")
    end,
  }

  -- code group (<leader>c)
  local code = {
    codeAction = function()
      vscode.call("editor.action.autoFix")
    end,

    format = function()
      vscode.call("editor.action.formatDocument")
    end,

    formatSelection = function()
      vscode.call("editor.action.formatSelection")
    end,

    rename = function()
      vscode.call("editor.action.rename")
    end,

    symbols = function()
      vscode.call("breadcrumbs.focusAndSelect")
    end,

    markdownPreview = function()
      vscode.call("markdown.showPreviewToSide")
    end,

    selectVenv = function()
      vscode.call("python.setInterpreter")
    end,
  }

  -- diagnostics group (<leader>x)
  local diagnostics = {
    quickfix = function()
      vscode.call("editor.action.quickFix")
    end,

    problem = function()
      vscode.call("workbench.actions.view.problems")
    end,
  }

  -- task group (<leader>o)
  local task = {
    build = function()
      vscode.call("workbench.action.tasks.build")
    end,

    rerunForActiveTerminal = function()
      vscode.call("workbench.action.tasks.rerunForActiveTerminal")
    end,

    configureDefaultBuild = function()
      vscode.call("workbench.action.tasks.configureDefaultBuildTask")
    end,

    configureDefaultTest = function()
      vscode.call("workbench.action.tasks.configureDefaultTestTask")
    end,

    configureTaskRunner = function()
      vscode.call("workbench.action.tasks.configureTaskRunner")
    end,

    manageAutoRun = function()
      vscode.call("workbench.action.tasks.manageAutomaticRunning")
    end,

    openUserTasks = function()
      vscode.call("workbench.action.tasks.openUserTasks")
    end,

    rerunAll = function()
      vscode.call("workbench.action.tasks.rerunAllRunningTasks")
    end,

    rerunLast = function()
      vscode.call("workbench.action.tasks.reRunTask")
    end,

    restart = function()
      vscode.call("workbench.action.tasks.restartTask")
    end,

    run = function()
      vscode.call("workbench.action.tasks.runTask")
    end,

    test = function()
      vscode.call("workbench.action.tasks.test")
    end,

    show = function()
      vscode.call("workbench.action.tasks.showTasks")
    end,

    showLog = function()
      vscode.call("workbench.action.tasks.showLog")
    end,

    terminate = function()
      vscode.call("workbench.action.tasks.terminate")
    end,
  }

  -- debug group (<leader>d)
  local debug = {
    breakpoint = function()
      vscode.call("editor.debug.action.toggleBreakpoint")
    end,

    breakpointCondition = function()
      vscode.call("editor.debug.action.conditionalBreakpoint")
    end,

    run = function()
      vscode.call("workbench.action.debug.start")
    end,

    runToCursor = function()
      vscode.call("editor.debug.action.runToCursor")
    end,

    stepInto = function()
      vscode.call("workbench.action.debug.stepInto")
    end,

    stepOut = function()
      vscode.call("workbench.action.debug.stepOut")
    end,

    stepOver = function()
      vscode.call("workbench.action.debug.stepOver")
    end,

    down = function()
      vscode.call("workbench.action.debug.callStackDown")
    end,

    up = function()
      vscode.call("workbench.action.debug.callStackUp")
    end,

    runLast = function()
      vscode.call("testing.debugLastRun")
    end,

    pause = function()
      vscode.call("workbench.action.debug.pause")
    end,

    terminate = function()
      vscode.call("workbench.action.debug.stop")
    end,

    repl = function()
      vscode.call("workbench.debug.action.toggleRepl")
    end,

    session = function()
      vscode.call("workbench.action.debug.selectandstart")
    end,

    widgets = function()
      vscode.call("editor.debug.action.showDebugHover")
    end,

    debugUi = function()
      vscode.call("workbench.view.debug")
    end,
  }

  -- find/file group (<leader>f)
  local file = {
    explorer = function()
      vscode.call("workbench.action.toggleSidebarVisibility")
    end,

    explorerFocus = function()
      vscode.call("workbench.files.action.focusFilesExplorer")
    end,

    newFile = function()
      vscode.call("workbench.action.files.newUntitledFile")
    end,

    find = function()
      vscode.call("workbench.action.quickOpen")
    end,

    projects = function()
      vscode.call("projectManager.listProjects")
    end,

    recent = function()
      vscode.call("workbench.action.openRecent")
    end,

    terminal = function()
      vscode.call("workbench.action.terminal.toggleTerminal")
    end,

    newTerminalWithProfile = function()
      vscode.call("workbench.action.terminal.newWithProfile")
    end,
  }

  -- git group (<leader>g)
  local git = {
    scm = function()
      vscode.call("workbench.view.scm")
    end,

    gitlens = function()
      vscode.call("gitlens.gitCommands")
    end,

    log = function()
      vscode.call("git-graph.view")
    end,

    blame = function()
      vscode.call("gitlens.toggleFileBlame:editor")
    end,

    diff = {
      stage = function()
        vscode.call("git.diff.stageHunk")
      end,

      unstage = function()
        vscode.call("git.unstageSelectedRanges")
      end,

      revert = function()
        vscode.call("diffEditor.revert")
      end,

      inlineView = function()
        vscode.call("toggle.diff.renderSideBySide")
      end,

      open = function()
        vscode.call("git.openChange")
      end,
    },

    merge = {
      acceptCurrent = function()
        vscode.call("merge-conflict.accept.current")
      end,

      acceptIncoming = function()
        vscode.call("merge-conflict.accept.incoming")
      end,

      acceptBoth = function()
        vscode.call("merge-conflict.accept.both")
      end,
    },

    stage = function()
      vscode.call("git.stage")
    end,

    unstage = function()
      vscode.call("git.unstage")
    end,

    clean = function()
      vscode.call("git.clean")
    end,

    commit = function()
      vscode.call("git.commitSigned")
    end,

    amendCommit = function()
      vscode.call("git.commitAmend")
    end,

    hunkPeekFocus = function()
      vscode.call("togglePeekWidgetFocus")
    end,
  }

  -- quit group (<leader>q)
  local quit = {
    closeWindow = function()
      vscode.call("workbench.action.closeWindow")
    end,

    closeWorkspace = function()
      vscode.call("workbench.action.closeFolder")
    end,

    closeOtherWindows = function()
      vscode.call("workbench.action.closeOtherWindows")
    end,
  }

  -- search group (<leader>s)
  local search = {
    findInFiles = function()
      vscode.call("workbench.action.findInFiles")
    end,

    replaceInFiles = function()
      vscode.call("workbench.action.replaceInFiles")
    end,

    symbol = function()
      vscode.call("workbench.action.gotoSymbol")
    end,

    symbolWorkspace = function()
      vscode.call("workbench.action.showAllSymbols")
    end,
  }

  -- ui group (<leader>u)
  local ui = {
    toggleSideBar = function()
      vscode.call("workbench.action.toggleSidebarVisibility")
    end,

    toggleSecondarySideBar = function()
      vscode.call("workbench.action.toggleAuxiliaryBar")
    end,

    togglePanel = function()
      vscode.call("workbench.action.togglePanel")
    end,

    toggleFullScreen = function()
      vscode.call("workbench.action.toggleFullScreen")
    end,

    selectTheme = function()
      vscode.call("workbench.action.selectTheme")
    end,

    toggleMaximizedPanel = function()
      vscode.call("workbench.action.toggleMaximizedPanel")
    end,

    toggleActivityBar = function()
      vscode.call("workbench.action.toggleActivityBarVisibility")
    end,

    toggleWordWrap = function()
      vscode.call("editor.action.toggleWordWrap")
    end,

    toggleZenMode = function()
      vscode.call("workbench.action.toggleZenMode")
    end,
  }

  -- window group (<leader>w)
  local group = {
    close = function()
      vscode.call("workbench.action.closeEditorsInGroup")
    end,

    splitDown = function()
      vscode.call("workbench.action.splitEditorDown")
    end,

    splitRight = function()
      vscode.call("workbench.action.splitEditor")
    end,

    focusLeft = function()
      vscode.call("workbench.action.focusLeftGroup")
    end,

    focusRight = function()
      vscode.call("workbench.action.focusRightGroup")
    end,

    focusBelow = function()
      vscode.call("workbench.action.focusBelowGroup")
    end,

    focusAbove = function()
      vscode.call("workbench.action.focusAboveGroup")
    end,

    moveLeft = function()
      vscode.call("workbench.action.moveActiveEditorGroupLeft")
    end,

    moveRight = function()
      vscode.call("workbench.action.moveActiveEditorGroupRight")
    end,

    moveBelow = function()
      vscode.call("workbench.action.moveActiveEditorGroupDown")
    end,

    moveAbove = function()
      vscode.call("workbench.action.moveActiveEditorGroupUp")
    end,

    toggleMaximize = function()
      vscode.call("workbench.action.toggleMaximizeEditorGroup")
    end,

    resetSize = function()
      vscode.call("workbench.action.evenEditorWidths")
    end,

    combineAll = function()
      vscode.call("workbench.action.joinAllGroups")
    end,
  }

  -- remote group (<leader>r)
  local remote = {
    showMenu = function()
      vscode.call("workbench.action.remote.showMenu")
    end,

    reload = function()
      vscode.call("workbench.action.reloadWindow")
    end,

    focusExplorer = function()
      vscode.call("remoteTargets.focus")
    end,

    connectSSH = function()
      vscode.call("opensshremotes.openEmptyWindow")
    end,

    connectWSL = function()
      vscode.call("remote-wsl.connect")
    end,

    attachContainer = function()
      vscode.call("remote-containers.attachToRunningContainer")
    end,

    -- explorer
    explorer = {
      remote = function()
        vscode.call("remoteTargets.focus")
      end,

      wsl = function()
        vscode.call("targetsWsl.focus")
      end,

      containers = function()
        vscode.call("targetsContainers.focus")
      end,
    },

    -- ssh
    ssh = {
      open = function()
        vscode.call("opensshremotes.openEmptyWindow")
      end,

      openCurrent = function()
        vscode.call("opensshremotes.openEmptyWindowInCurrentWindow")
      end,

      config = function()
        vscode.call("opensshremotes.openConfigFile")
      end,

      cleanCurrent = function()
        vscode.call("opensshremotes.cleanCurrentRemoteServer")
      end,

      cleanAll = function()
        vscode.call("opensshremotes.cleanRemoteServer")
      end,

      cleanDevBox = function()
        vscode.call("opensshremotes.cleanDevBox")
      end,
    },

    -- wsl
    wsl = {
      connect = function()
        vscode.call("remote-wsl.connectUsingDistro")
      end,

      openFolder = function()
        vscode.call("remote-wsl.openFolder")
      end,

      addDistro = function()
        vscode.call("remote-wsl.explorer.addDistro")
      end,

      deleteDistro = function()
        vscode.call("remote-wsl.explorer.deleteDistro")
      end,

      setDefault = function()
        vscode.call("remote-wsl.explorer.setDefaultDistro")
      end,
    },

    -- dev containers
    container = {
      openConfig = function()
        vscode.call("remote-containers.openDevContainerFile")
      end,

      openFolder = function()
        vscode.call("remote-containers.openFolder")
      end,

      attach = function()
        vscode.call("remote-containers.attachToRunningContainer")
      end,

      rebuild = function()
        vscode.call("remote-containers.rebuildAndReopenInContainer")
      end,

      rebuildNoCache = function()
        vscode.call("remote-containers.rebuildNoCacheAndReopenInContainer")
      end,
    },
  }

  -- fold group (z)
  local fold = {
    toggle = function()
      vscode.call("editor.toggleFold")
    end,

    close = function()
      vscode.call("editor.fold")
    end,

    closeAll = function()
      vscode.call("editor.foldAll")
    end,

    open = function()
      vscode.call("editor.unfold")
    end,

    openAll = function()
      vscode.call("editor.unfoldAll")
    end,
  }

  -- goto group (g)
  local go = {
    definition = function()
      vscode.call("editor.action.revealDefinition")
    end,

    declaration = function()
      vscode.call("editor.action.revealDeclaration")
    end,

    typeDefinition = function()
      vscode.call("editor.action.goToTypeDefinition")
    end,

    implementation = function()
      vscode.call("editor.action.goToImplementation")
    end,

    references = function()
      vscode.call("editor.action.goToReferences")
    end,
  }

  -- navigation function group ([ and ])
  local nav = {
    prevHunk = function()
      vscode.call("editor.action.dirtydiff.previous")
    end,

    nextHunk = function()
      vscode.call("editor.action.dirtydiff.next")
    end,

    prevChange = function()
      vscode.call("workbench.action.compareEditor.previousChange")
    end,

    nextChange = function()
      vscode.call("workbench.action.compareEditor.nextChange")
    end,

    prevConflict = function()
      vscode.call("merge-conflict.previous")
    end,

    nextConflict = function()
      vscode.call("merge-conflict.next")
    end,

    prevReference = function()
      vscode.call("references-view.prev")
    end,

    nextReference = function()
      vscode.call("references-view.next")
    end,

    prevProblemFile = function()
      vscode.call("editor.action.marker.prevInFiles")
    end,

    nextProblemFile = function()
      vscode.call("editor.action.marker.nextInFiles")
    end,

    prevProblem = function()
      vscode.call("editor.action.marker.prev")
    end,

    nextProblem = function()
      vscode.call("editor.action.marker.next")
    end,

    prevEditor = function()
      vscode.call("workbench.action.previousEditorInGroup")
    end,

    nextEditor = function()
      vscode.call("workbench.action.nextEditorInGroup")
    end,

    moveEditorLeft = function()
      vscode.call("workbench.action.moveEditorLeftInGroup")
    end,

    moveEditorRight = function()
      vscode.call("workbench.action.moveEditorRightInGroup")
    end,
  }

  -- better up/down
  vim.keymap.set({ "n" }, "j", cursorMove.n_gj, { desc = "Down", silent = true })
  vim.keymap.set({ "n" }, "k", cursorMove.n_gk, { desc = "Up", silent = true })
  vim.keymap.set({ "x" }, "gj", cursorMove.x_gj, { desc = "Down", silent = true })
  vim.keymap.set({ "x" }, "gk", cursorMove.x_gk, { desc = "Up", silent = true })

  -- scroll half page
  vim.keymap.set({ "v" }, "<c-u>", function()
    scrollHalfPage("up")
  end, { desc = "Scroll Half Page Up", noremap = true, silent = false })
  vim.keymap.set({ "v" }, "<c-d>", function()
    scrollHalfPage("down")
  end, { desc = "Scroll Half Page Down", noremap = true, silent = false })

  -- Resize window using <ctrl> arrow keys
  vim.keymap.set("n", "<C-Up>", resizeWindow.increaseHeight, { desc = "Increase Window Height" })
  vim.keymap.set("n", "<C-Down>", resizeWindow.decreaseHeight, { desc = "Decrease Window Height" })
  vim.keymap.set("n", "<C-Left>", resizeWindow.decreaseWidth, { desc = "Decrease Window Width" })
  vim.keymap.set("n", "<C-Right>", resizeWindow.increaseWidth, { desc = "Increase Window Width" })

  -- whichkey
  vim.opt.timeoutlen = 1000
  vim.keymap.set({ "n", "v" }, "<leader>", whichKey.show)

  -- quick keymap
  vim.keymap.set("n", ";q", editor.close, { desc = "Close Window" })
  vim.keymap.set("n", ";w", editor.save, { desc = "Save File" })
  vim.keymap.set("n", "<leader>e", file.explorer, { desc = "Explorer" })
  vim.keymap.set("n", "<leader>E", file.explorerFocus, { desc = "Focus Explorer" })
  vim.keymap.set("n", "<leader>`", editor.switch, { desc = "Switch Editor" })
  vim.keymap.set("n", "<leader><leader>", file.find, { desc = "Find Files" })
  vim.keymap.set("n", "<leader>-", group.splitDown, { desc = "Split Window Below" })
  vim.keymap.set("n", "<leader>|", group.splitRight, { desc = "Split Window Right" })
  vim.keymap.set("n", "H", nav.prevEditor, { desc = "Open Previous Editor In Group" })
  vim.keymap.set("n", "L", nav.nextEditor, { desc = "Open Next Editor In Group" })

  -- buffer
  vim.keymap.set("n", "<leader>bb", editor.switch, { desc = "Switch Editor" })
  vim.keymap.set("n", "<leader>bd", editor.close, { desc = "Close Editor" })
  vim.keymap.set("n", "<leader>bl", editor.closeLeft, { desc = "Close Left" })
  vim.keymap.set("n", "<leader>bo", editor.closeOthers, { desc = "Close Others" })
  vim.keymap.set("n", "<leader>br", editor.closeRight, { desc = "Close Right" })
  vim.keymap.set("n", "<leader>bH", editor.moveLeftGroup, { desc = "Move to Left Group" })
  vim.keymap.set("n", "<leader>bL", editor.moveRightGroup, { desc = "Move to Right Group" })
  vim.keymap.set("n", "<leader>bK", editor.moveAboveGroup, { desc = "Move to Above Group" })
  vim.keymap.set("n", "<leader>bJ", editor.moveBelowGroup, { desc = "Move to Below Group" })

  -- code
  vim.keymap.set("n", "<leader>ca", code.codeAction, { desc = "Code Action" })
  vim.keymap.set("n", "<leader>cf", code.format, { desc = "Format" })
  vim.keymap.set("x", "<leader>cf", code.formatSelection, { desc = "Format Selection" })
  vim.keymap.set("n", "<leader>cr", code.rename, { desc = "Rename" })
  vim.keymap.set("n", "<leader>cs", code.symbols, { desc = "Symbols" })
  vim.keymap.set("n", "<leader>cp", code.markdownPreview, { desc = "Markdown Preview" })
  vim.keymap.set("n", "<leader>cv", code.selectVenv, { desc = "Select VirtualEnv" })

  -- diagnostics
  vim.keymap.set("n", "<leader>xq", diagnostics.quickfix, { desc = "Quickfix" })
  vim.keymap.set("n", "<leader>xx", diagnostics.problem, { desc = "Problem list" })

  -- task
  vim.keymap.set("n", "<leader>ob", task.build, { desc = "Build Task" })
  vim.keymap.set("n", "<leader>ot", task.test, { desc = "Test Task" })
  vim.keymap.set("n", "<leader>oT", task.run, { desc = "Run Task" })
  vim.keymap.set("n", "<leader>os", task.show, { desc = "Show Tasks" })
  vim.keymap.set("n", "<leader>ol", task.showLog, { desc = "Show Task Log" })
  vim.keymap.set("n", "<leader>oR", task.rerunForActiveTerminal, { desc = "Rerun Task (Active Terminal)" })
  vim.keymap.set("n", "<leader>od", task.terminate, { desc = "Terminate Task" })
  vim.keymap.set("n", "<leader>oO", task.openUserTasks, { desc = "Open User Tasks" })
  vim.keymap.set("n", "<leader>occ", task.configureTaskRunner, { desc = "Configure Task Runner" })
  vim.keymap.set("n", "<leader>ocb", task.configureDefaultBuild, { desc = "Configure Default Build Task" })
  vim.keymap.set("n", "<leader>oct", task.configureDefaultTest, { desc = "Configure Default Test Task" })
  vim.keymap.set("n", "<leader>oca", task.manageAutoRun, { desc = "Manage Automatic Running" })
  vim.keymap.set("n", "<leader>ora", task.rerunAll, { desc = "Rerun All Running Tasks" })
  vim.keymap.set("n", "<leader>orl", task.rerunLast, { desc = "Rerun Last Task" })
  vim.keymap.set("n", "<leader>orr", task.restart, { desc = "Restart Task" })

  -- debug
  vim.keymap.set("n", "<leader>db", debug.breakpoint, { desc = "Toggle Breakpoint" })
  vim.keymap.set("n", "<leader>dB", debug.breakpointCondition, { desc = "Condition Breakpoint" })
  vim.keymap.set("n", "<leader>dc", debug.run, { desc = "Run/Continue" })
  vim.keymap.set("n", "<leader>dC", debug.runToCursor, { desc = "Run to Cursor" })
  vim.keymap.set("n", "<leader>di", debug.stepInto, { desc = "Step Into" })
  vim.keymap.set("n", "<leader>dj", debug.down, { desc = "Down" })
  vim.keymap.set("n", "<leader>dk", debug.up, { desc = "Up" })
  vim.keymap.set("n", "<leader>dl", debug.runLast, { desc = "Run Last" })
  vim.keymap.set("n", "<leader>do", debug.stepOut, { desc = "Step Out" })
  vim.keymap.set("n", "<leader>dO", debug.stepOver, { desc = "Step Over" })
  vim.keymap.set("n", "<leader>dp", debug.pause, { desc = "Pause" })
  vim.keymap.set("n", "<leader>dr", debug.repl, { desc = "Toggle REPL" })
  vim.keymap.set("n", "<leader>dt", debug.terminate, { desc = "Terminate" })

  -- file/find
  vim.keymap.set("n", "<leader>fe", file.explorer, { desc = "Explorer" })
  vim.keymap.set("n", "<leader>fE", file.explorerFocus, { desc = "Focus Explorer" })
  vim.keymap.set("n", "<leader>fn", file.newFile, { desc = "New File" })
  vim.keymap.set("n", "<leader>ff", file.find, { desc = "Find Files" })
  vim.keymap.set("n", "<leader>fp", file.projects, { desc = "Projects" })
  vim.keymap.set("n", "<leader>fr", file.recent, { desc = "Recent" })
  vim.keymap.set("n", "<leader>ft", file.terminal, { desc = "Terminal" })
  vim.keymap.set("n", "<leader>fT", file.newTerminalWithProfile, { desc = "New Terminal Profile" })

  -- git
  vim.keymap.set("n", "<leader>ge", git.scm, { desc = "Source Control" })
  vim.keymap.set("n", "<leader>gg", git.gitlens, { desc = "GitLens" })
  vim.keymap.set("n", "<leader>gl", git.log, { desc = "Log" })
  vim.keymap.set("n", "<leader>gc", git.commit, { desc = "Commit" })
  vim.keymap.set("n", "<leader>ga", git.amendCommit, { desc = "Amend Commit" })
  vim.keymap.set("n", "<leader>gb", git.blame, { desc = "Blame" })
  -- git diff
  vim.keymap.set("n", "<leader>gd", git.diff.open, { desc = "Diff View" })
  vim.keymap.set("n", "<leader>ghi", git.diff.inlineView, { desc = "Toggle Inline View" })
  vim.keymap.set("n", "<leader>ghs", git.diff.stage, { desc = "Stage Hunk" })
  vim.keymap.set("n", "<leader>ghu", git.diff.unstage, { desc = "Unstage Hunk" })
  vim.keymap.set("n", "<leader>ghr", git.diff.revert, { desc = "Revert Hunk" })
  vim.keymap.set("n", "<leader>ghS", git.stage, { desc = "Stage File" })
  vim.keymap.set("n", "<leader>ghU", git.unstage, { desc = "Unstage File" })
  vim.keymap.set("n", "<leader>ghR", git.clean, { desc = "Revert File" })
  -- git merge conflict
  vim.keymap.set("n", "<leader>gmo", git.merge.acceptCurrent, { desc = "Accept Current (Ours)" })
  vim.keymap.set("n", "<leader>gmt", git.merge.acceptIncoming, { desc = "Accept Incoming (Theirs)" })
  vim.keymap.set("n", "<leader>gmb", git.merge.acceptBoth, { desc = "Accept Both" })

  -- search
  vim.keymap.set("n", "<leader>sf", search.findInFiles, { desc = "Search Files" })
  vim.keymap.set("n", "<leader>sr", search.replaceInFiles, { desc = "Replace Files" })
  vim.keymap.set("n", "<leader>ss", search.symbol, { desc = "Goto Symbol" })
  vim.keymap.set("n", "<leader>sS", search.symbolWorkspace, { desc = "Workspace Symbol" })

  -- ui
  vim.keymap.set("n", "<leader>ub", ui.toggleSideBar, { desc = "Side Bar" })
  vim.keymap.set("n", "<leader>ua", ui.toggleSecondarySideBar, { desc = "Secondary Side Bar" })
  vim.keymap.set("n", "<leader>uj", ui.togglePanel, { desc = "Panel" })
  vim.keymap.set("n", "<leader>uf", ui.toggleFullScreen, { desc = "Full Screen" })
  vim.keymap.set("n", "<leader>us", ui.selectTheme, { desc = "Theme" })
  vim.keymap.set("n", "<leader>um", ui.toggleMaximizedPanel, { desc = "Maximized Panel" })
  vim.keymap.set("n", "<leader>ut", ui.toggleActivityBar, { desc = "Tool/Activity Bar" })
  vim.keymap.set("n", "<leader>uw", ui.toggleWordWrap, { desc = "Word Wrap" })
  vim.keymap.set("n", "<leader>uz", ui.toggleZenMode, { desc = "Zen Mode" })

  -- group
  vim.keymap.set("n", "<leader>wd", group.close, { desc = "Delete Window" })
  vim.keymap.set("n", "<leader>w-", group.splitDown, { desc = "Split Window Below" })
  vim.keymap.set("n", "<leader>w|", group.splitRight, { desc = "Split Window Right" })
  vim.keymap.set("n", "<leader>wh", group.focusLeft, { desc = "Focus Left" })
  vim.keymap.set("n", "<leader>wl", group.focusRight, { desc = "Focus Right" })
  vim.keymap.set("n", "<leader>wj", group.focusBelow, { desc = "Focus Below" })
  vim.keymap.set("n", "<leader>wk", group.focusAbove, { desc = "Focus Above" })
  vim.keymap.set("n", "<leader>wH", group.moveLeft, { desc = "Move Group Left" })
  vim.keymap.set("n", "<leader>wL", group.moveRight, { desc = "Move Group Right" })
  vim.keymap.set("n", "<leader>wJ", group.moveBelow, { desc = "Move Group Down" })
  vim.keymap.set("n", "<leader>wK", group.moveAbove, { desc = "Move Group Up" })
  vim.keymap.set("n", "<leader>wm", group.toggleMaximize, { desc = "Maximize Group" })
  vim.keymap.set("n", "<leader>w=", group.resetSize, { desc = "Reset Sizes" })
  vim.keymap.set("n", "<leader>wz", group.combineAll, { desc = "Combine All Editors" })

  -- remote
  vim.keymap.set("n", "<leader>rr", remote.showMenu,       { desc = "Remote Menu" })
  vim.keymap.set("n", "<leader>rR", remote.reload,       { desc = "Reload Remote" })
  vim.keymap.set("n", "<leader>rE", remote.focusExplorer,  { desc = "Remote Explorer" })
  vim.keymap.set("n", "<leader>rS", remote.connectSSH,     { desc = "Connect SSH (New Window)" })
  vim.keymap.set("n", "<leader>rW", remote.connectWSL,     { desc = "Connect WSL" })
  vim.keymap.set("n", "<leader>rD", remote.attachContainer, { desc = "Attach to Container" })
  -- remote explorer
  vim.keymap.set("n", "<leader>res", remote.explorer.remote,     { desc = "Remote Targets" })
  vim.keymap.set("n", "<leader>rew", remote.explorer.wsl,        { desc = "WSL Targets" })
  vim.keymap.set("n", "<leader>red", remote.explorer.containers, { desc = "Container Targets" })
  -- ssh
  vim.keymap.set("n", "<leader>rss", remote.ssh.open,         { desc = "Open SSH (New Window)" })
  vim.keymap.set("n", "<leader>rsS", remote.ssh.openCurrent,  { desc = "Open SSH (Current Window)" })
  vim.keymap.set("n", "<leader>rsc", remote.ssh.config,       { desc = "Open SSH Config" })
  vim.keymap.set("n", "<leader>rsk", remote.ssh.cleanCurrent, { desc = "Clean Current SSH Server" })
  vim.keymap.set("n", "<leader>rsK", remote.ssh.cleanAll,     { desc = "Clean SSH Server" })
  vim.keymap.set("n", "<leader>rsd", remote.ssh.cleanDevBox,  { desc = "Uninstall VS Code Server" })
  -- wsl
  vim.keymap.set("n", "<leader>rwc", remote.wsl.connect,     { desc = "Connect WSL Distro" })
  vim.keymap.set("n", "<leader>rwo", remote.wsl.openFolder,  { desc = "Open WSL Folder" })
  vim.keymap.set("n", "<leader>rwa", remote.wsl.addDistro,   { desc = "Add WSL Distro" })
  vim.keymap.set("n", "<leader>rwd", remote.wsl.deleteDistro, { desc = "Delete WSL Distro" })
  vim.keymap.set("n", "<leader>rwx", remote.wsl.setDefault,  { desc = "Set Default WSL Distro" })
  -- dev containers
  vim.keymap.set("n", "<leader>rdc", remote.container.openConfig,    { desc = "Open DevContainer Config" })
  vim.keymap.set("n", "<leader>rdo", remote.container.openFolder,    { desc = "Open Container Folder" })
  vim.keymap.set("n", "<leader>rda", remote.container.attach,        { desc = "Attach to Container" })
  vim.keymap.set("n", "<leader>rdr", remote.container.rebuild,       { desc = "Rebuild & Reopen" })
  vim.keymap.set("n", "<leader>rdR", remote.container.rebuildNoCache, { desc = "Rebuild (No Cache) & Reopen" })

  -- quit
  vim.keymap.set("n", "<leader>qq", quit.closeWindow, { desc = "Close Window" })
  vim.keymap.set("n", "<leader>qd", quit.closeWorkspace, { desc = "Close Workspace" })
  vim.keymap.set("n", "<leader>qo", quit.closeOtherWindows, { desc = "Close Others" })

  -- Goto
  vim.keymap.set("n", "gd", go.definition, { desc = "Goto Definition" })
  vim.keymap.set("n", "gD", go.declaration, { desc = "Goto Declaration" })
  vim.keymap.set("n", "gy", go.typeDefinition, { desc = "Goto Type Definition" })
  vim.keymap.set("n", "gI", go.implementation, { desc = "Goto Implementation" })
  vim.keymap.set("n", "gr", go.references, { desc = "Goto References" })
  vim.keymap.set("n", "gh", git.hunkPeekFocus, { desc = "Hunk Peek Focus" })

  -- Prev navigation [
  vim.keymap.set("n", "[h", nav.prevHunk)
  vim.keymap.set("n", "[x", nav.prevConflict)
  vim.keymap.set("n", "[c", nav.prevChange)
  vim.keymap.set("n", "[[", nav.prevReference)
  vim.keymap.set("n", "[d", nav.prevProblemFile)
  vim.keymap.set("n", "[D", nav.prevProblem)
  vim.keymap.set("n", "[b", nav.prevEditor)
  vim.keymap.set("n", "[B", nav.moveEditorLeft)

  -- Next navigation ]
  vim.keymap.set("n", "]h", nav.nextHunk)
  vim.keymap.set("n", "]x", nav.nextConflict)
  vim.keymap.set("n", "]c", nav.nextChange)
  vim.keymap.set("n", "]]", nav.nextReference)
  vim.keymap.set("n", "]d", nav.nextProblemFile)
  vim.keymap.set("n", "]D", nav.nextProblem)
  vim.keymap.set("n", "]b", nav.nextEditor)
  vim.keymap.set("n", "]B", nav.moveEditorRight)
else
  -- delete buffer
  vim.keymap.set("n", ";q", function()
    Snacks.bufdelete()
  end, { desc = "Delete Buffer" })

  -- save file
  vim.keymap.set("n", ";w", "<cmd>w<cr><esc>", { desc = "Save File" })
end
