# function Add-ConsoleToForm ($form, $screen) {
#     # Add a textPanel
#     $logPanel = New-Object System.Windows.Forms.Panel
#     $logPanel.Location = New-Object System.Drawing.Point(($screen.HalfWidth+40), 80)
#     $logPanel.Width = $screen.HalfWidth-80
#     $logPanel.Height = $screen.Height-180
#     $logPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
#     $logPanel.BackColor = [System.Drawing.Color]::Beige
#     $form.Controls.Add($logPanel)
# }
function Add-LogToForm {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [System.Windows.Forms.Form]$Form,

        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]$Screen
    )

    # Add a console panel
    $logPanel = New-Object System.Windows.Forms.Panel
    $logPanel.Location = New-Object System.Drawing.Point(($Screen.HalfWidth+40), 80)
    $logPanel.Width = $Screen.HalfWidth-80
    $logPanel.Height = $Screen.Height-180
    $logPanel.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
    $logPanel.BackColor = [System.Drawing.Color]::Beige
    $form.Controls.Add($logPanel)

    # Add a console label to the panel
    $logLabel = New-Object System.Windows.Forms.Label
    $logLabel.AutoSize = $false
    $logLabel.Dock = [System.Windows.Forms.DockStyle]::Fill
    $logPanel.Controls.Add($logLabel)

    # Return the console panel object
    return $logPanel, $logLabel
}