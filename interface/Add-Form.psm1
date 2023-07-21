function New-Form {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [System.Collections.Hashtable]$Screen
    )

    # Create the GUI form
    Add-Type -AssemblyName System.Windows.Forms
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Windows Streamliner"
    $form.AutoScroll = $true
    $form.VerticalScroll.Enabled = $true
    $form.VerticalScroll.Visible = $true
    $form.WindowState = "Maximized"
    $form.AutoSizeMode = "GrowAndShrink"
    $form.ClientSize = New-Object System.Drawing.Size($Screen.HalfWidth, $Screen.Height)
    return $form
}