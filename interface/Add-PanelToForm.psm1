function Add-PanelToForm {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [System.Windows.Forms.Form]$Form,

        [Parameter(Mandatory = $true)]
        [int]$X,

        [Parameter(Mandatory = $true)]
        [int]$Y,

        [Parameter(Mandatory = $false)]
        [System.Collections.Hashtable]$ScreenSize,

        [Parameter(Mandatory = $true)]
        [string]$Text
    )

    # Add panel
    $panel = New-Object System.Windows.Forms.Panel
    $panel.Location = New-Object System.Drawing.Point($X, $Y)
    $buttonFont = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $W = $ScreenSize.HalfWidth
    $H = [math]::Ceiling($form.CreateGraphics().MeasureString($Text, $buttonFont, $W).Height / 20) * 16 + 1
    $panel.Width = $W
    $panel.Height = $H
    $panel.BorderStyle = [System.Windows.Forms.BorderStyle]::Fixed3D
    $panel.BackColor = [System.Drawing.Color]::Lavender

    # Add checkbox
    $check = New-Object System.Windows.Forms.CheckBox
    $check.Location = New-Object System.Drawing.Point(10, 0)
    $check.Font = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
    $check.Text = $Text
    $check.Dock = "Fill"
    $check.Padding = New-Object System.Windows.Forms.Padding(3)

    # Add label
    if ($Label) {
        $label = New-Object System.Windows.Forms.Label
        $label.Location = New-Object System.Drawing.Point(10, 30)
        $label.Font = New-Object System.Drawing.Font("Arial", 10, [System.Drawing.FontStyle]::Regular)
        $label.Text = $Label
        $label.AutoSize = $true
        $panel.Controls.Add($label)
    }

    # Add controls to panel
    $panel.Controls.Add($check)

    # Add panel to form
    $Form.Controls.Add($panel)

    return $panel
}