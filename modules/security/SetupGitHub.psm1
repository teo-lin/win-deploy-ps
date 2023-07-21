function SetupGitHub {
    $SetupGitHub = @{
        short = "SetupGitHub"
        title = "TITLE: Description of what SetupGitHub is..."
        enable = "Info if you tick the SetupGitHub checkbox"
        disable = "Info if you untick the SetupGitHub checkbox"
        run2 = "function DoSomething {Write-Host 'INVOKED:' this.short}"
        run = function DoSomething {
            Write-Host "INVOKED:" this.short
        }
    }
    return $SetupGitHub
}

Export-ModuleMember -Function *