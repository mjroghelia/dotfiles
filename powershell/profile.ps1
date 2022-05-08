Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs -BellStyle None

function ss { git status } 

$env:LESSCHARSET="utf-8"

if ($IsWindows -Or $env:OS -eq "Windows_NT") {
    Set-Alias less more 
}
elseif ($IsMacOS) {
    $env:PATH = ":/usr/local/bin:/usr/local/opt/ruby/bin:" + $env:PATH
}

$env:PYTHONPATH = (Join-Path $HOME "src/dotfiles/python")

# Add GitHub cli completions
Invoke-Expression -Command $(gh completion -s powershell | Out-String)
