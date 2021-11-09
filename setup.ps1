$PythonPath = "$PSScriptRoot\python"

if (-not (Test-Path env:PYTHONPATH)) {
    Write-Output "Setting PYTHONPATH to $PythonPath"
    [Environment]::SetEnvironmentVariable('PYTHONPATH', $PythonPath, 'User')
    $env:PYTHONPATH = $PythonPath
}
else {
    Write-Output "PYTHONPATH is $env:PYTHONPATH"
}

pip install -r "$PythonPath\requirements.txt"
pip install pyreadline
python "$PSScriptRoot\git\setup.py"
python "$PSScriptRoot\powershell\setup.py"
python "$PSScriptRoot\ruby\setup.py"
python "$PSScriptRoot\vim\setup.py"
# python "$PSScriptRoot\vscode\setup.py"
python "$PSScriptRoot\windows-terminal\setup.py"
