Import-Module -Name posh-git, oh-my-posh, Terminal-Icons, PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows
# Set-PoshPrompt -Theme jandedobbeleer
Set-PoshPrompt -Theme ~/.mytheme.omp.json
# Invoke-Expression (&starship init powershell)
