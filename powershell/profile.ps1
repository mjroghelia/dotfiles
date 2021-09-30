Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs -BellStyle None

function ss { git status } 
Set-Alias less more 

$env:LESSCHARSET="utf-8"

if ($IsWindows -Or $env:OS -eq "Windows_NT") {
    $env:PYTHONPATH = (Join-Path $HOME "src/etc/python")
}
elseif ($IsMacOS) {
    $env:PATH += ":/usr/local/bin"
}
