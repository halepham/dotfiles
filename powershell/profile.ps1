oh-my-posh --init --shell pwsh --config ~\dotfiles\powershell\mytheme.omp.json | Invoke-Expression
Import-Module PSReadLine
Import-Module -Name Terminal-Icons

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionViewStyle InlineView

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Chord "Shift+Tab" -Function SwitchPredictionView
Set-PSReadlineKeyHandler -Chord "Ctrl+p" -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Chord "Ctrl+n" -Function HistorySearchForward