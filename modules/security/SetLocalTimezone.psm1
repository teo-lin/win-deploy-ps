function SetLocalTimezone {
    $SetLocalTimezone = @{
        short = "SetLocalTimezone"
        title = "TITLE: Description of what SetLocalTimezone is..."
        enable = "Info if you tick the SetLocalTimezone checkbox"
        disable = "Info if you untick the SetLocalTimezone checkbox"
        run2 = "function DoSomething {Write-Host 'INVOKED:' this.short}"
        run = function DoSomething {
            Write-Host "INVOKED:" this.short
        }
    }
    return $SetLocalTimezone
}

Export-ModuleMember -Function *