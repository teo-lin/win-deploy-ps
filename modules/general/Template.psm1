function Template {
    $Template = @{
        short = "Template"
        title = "TITLE: Description of what Template is..."
        enable = "Info if you tick the Template checkbox"
        disable = "Info if you untick the Template checkbox"
        run2 = "function DoSomething {Write-Host 'INVOKED:' this.short}"
        run = function DoSomething {
            Write-Host "INVOKED:" this.short
        }
    }
    return $Template
}

Export-ModuleMember -Function *