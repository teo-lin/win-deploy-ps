function SetInfo {
    $DoSomething = @{
        short = "DoSomething"
        title = "TITLE: Description of what DoSomething is..."
        enable = "Info if you tick the DoSomething checkbox"
        disable = "Info if you untick the DoSomething checkbox"
    }
    return $DoSomething
}

function DoSomething {
    Write-Host "INVOKED1:" this.short
}

Export-ModuleMember -Function *