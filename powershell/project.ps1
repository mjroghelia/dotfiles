$SourcePath = Join-Path $HOME "src"

function Initialize-PoshGit {
    Import-Module posh-git
    $GitPromptSettings.WindowTitle = {
        param($GitStatus, [bool]$IsAdmin) 
        "$(if ($IsAdmin) {'Admin: '})$(if ($GitStatus) {"$($GitStatus.RepoName) [$($GitStatus.Branch)]"} else {Get-PromptPath})"
    }
}

function Set-Project {
    [CmdletBinding()]
    param (
        [ArgumentCompleter( {
            param (
                $commandName,
                $parameterName,
                $wordToComplete,
                $commandAst,
                $fakeBoundParameters
            )
            Get-ChildItem -Path $SourcePath -Filter "$wordToComplete*" |
            Select-Object -ExpandProperty Name
        } )]
        $Project
    )

    if ($Project) {
        $global:MyProject = $Project
    }
    
    if ($MyProject) {
        Join-Path $SourcePath $MyProject | Set-Location
    }
    else {
        Write-Error "No project set."
    }

    Initialize-PoshGit
}

Set-Alias pd Set-Project
