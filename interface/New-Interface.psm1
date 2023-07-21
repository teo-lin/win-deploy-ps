Import-Module -Name "$PSScriptRoot\..\utilities\Get-ScreenResolution.psm1"
Import-Module -Name "$PSScriptRoot\..\utilities\Get-Modules.psm1"
Import-Module -Name "$PSScriptRoot\Add-Form.psm1"
Import-Module -Name "$PSScriptRoot\Add-ButtonToForm.psm1"
Import-Module -Name "$PSScriptRoot\Add-PanelToForm.psm1"
Import-Module -Name "$PSScriptRoot\Add-LogToForm.psm1"
# X,Y=coordinates, H,W=Height,Width, D=Delta
# $Settings = Get-Content -Path "$PSScriptRoot\settings.json" -Raw | ConvertFrom-Json

function New-Interface {
    # Get the screen resolution
    Write-Host "Creating Interface..."
    $screen = Get-ScreenResolution

    # Add the Interface form
    $form = New-Form -Screen $screen
    
    # Add a Console to the right
    $logPanel = Add-LogToForm -Form $form -Screen $screen
    $log = $logPanel.Controls[0]
    $log.Text = "Console Initiated"

    # Add the top Buttons
    Add-ButtonToForm -Form $form -X 20 -Y 20 -W 200 -H 40 -Text "Enable / Disable All"
    $log.Text += "`nButton Added"

    # Add modules: Scan modules folder and extract modules
    $Mod = Get-Modules
    $r2 = $Mod.general.DoSomething.run
    Write-Host "MOD1: " $r2 "TYPE:" $r2.GetType() "JSON:" $r2 | ConvertTo-Json
    Invoke-Expression ($r2)


    # Add panels below Menu
    $panelTitles = @(
        "TITLE: Very long description of what the bleep this does - First Panel Added",
        "TITLE: Very long description - Second Panel Added",
        "TITLE: Very long description of what this does - Third Panel Added"
    )

    # Add panels below Menu
    $Y = 80
    foreach ($title in $panelTitles) {
        $panel = Add-PanelToForm -Form $form -X 20 -Y $Y -ScreenSize $screen -Text $title
        $panel.AutoSize = $true
        $panel.Tag = $title
        $check = $panel.Controls[0]
        $Y += $panel.Height
        $log.Text += "`n$title"
        $check.Add_CheckedChanged({ if ($this.Checked) {$log.Text += "`n"+$this.Parent.Tag+"`n" }})
    }

    # Show the form
    $log.Text += "`nFinished initialisation`n"
    $form.ShowDialog()
    $form.Dispose()
}