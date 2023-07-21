Import-Module -Name "$PSScriptRoot\..\utilities\Get-ScreenResolution.psm1"
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
    function Get-Modules {
        # Get the module folder groups (subfolders)
        $Groups = Get-ChildItem -Path "$PSScriptRoot\..\modules" -Directory
        $log.Text += "`nFOLDERS: $Groups"

        # Loop through each subfolder and load the modules
        $Mod = New-Object -TypeName PSObject
        foreach ($Group in $Groups) {
            # Create a nested object for the module category subfolder
            $Category = $Group.Name
            $Mod | Add-Member -MemberType NoteProperty -Name $Group.Name -Value (New-Object -TypeName PSObject)
            $All | Add-Member -PassThru NoteProperty -Name $Group.Name -Value (New-Object -TypeName PSObject)

            # Get a collection of FileInfo Object as $Modules
            $Modules = Get-ChildItem -Path $Group.FullName -Filter *.psm1
            $log.Text += "`nPMS1s: $Modules in $Group"
    
            # Loop through each module file and load it
            foreach ($Module in $Modules) {
                # Load the module file and get the exports
                $ModuleName = $Module.BaseName
                $ModulePath = Join-Path (Split-Path $PSScriptRoot -Parent) "modules\$Group\$Module"
                $log.Text += "`nLoading $ModuleName from $ModulePath"
                # Write-Host "`nLoading $ModuleName from $ModulePath"
                Import-Module -Name $ModulePath -Force

                # Execute the main function (the function must be named exactly as the module file)
                Invoke-Expression $ModuleName
                $Info = "Info"+$ModuleName
                $Hash = Invoke-Expression $Info
                # Write-Host $Hash.title

                # Add the content to $All
                $All.$Category | Add-Member -MemberType NoteProperty -Name $ModuleName -Value $Hash
                $Jay = $All | ConvertTo-Json
                Write-Host "JAY: " $Jay

                # Remove the module from memory
                Remove-Module $ModuleName
            }
        }
    
        return $Mod
    }
    $All = New-Object -TypeName PSObject
    $Mod = Get-Modules
    $log.Text += "`nMOD: $Mod`n"
    Write-Host "ALL: " $All.general.DoSomething.short "MOD: " $Mod.general.DoSomething.short

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