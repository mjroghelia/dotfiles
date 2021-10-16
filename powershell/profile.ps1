Import-Module PSReadLine
Set-PSReadLineOption -EditMode Emacs -BellStyle None

function ss { git status } 

$env:LESSCHARSET="utf-8"

if ($IsWindows -Or $env:OS -eq "Windows_NT") {
    Set-Alias less more 
    $env:PYTHONPATH = (Join-Path $HOME "src/etc/python")
}
elseif ($IsMacOS) {
    $env:PATH += ":/usr/local/bin"
}

# Add GitHub cli completions
Invoke-Expression -Command $(gh completion -s powershell | Out-String)
