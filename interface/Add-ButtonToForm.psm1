function Add-ButtonToForm {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [System.Windows.Forms.Form]$Form,

        [Parameter(Mandatory=$true)]
        [int]$X,

        [Parameter(Mandatory=$true)]
        [int]$Y,

        [Parameter(Mandatory = $false)]
        [int]$W,

        [Parameter(Mandatory = $false)]
        [int]$H,

        [Parameter(Mandatory=$true)]
        [string]$Text
    )

    $buttonFont = New-Object System.Drawing.Font("Arial", 14, [System.Drawing.FontStyle]::Bold)
    $button = New-Object System.Windows.Forms.Button
    $button.Location = New-Object System.Drawing.Point($X, $Y)
    $button.Width = $W
    $button.Height = $H
    $button.Text = $Text
    $button.ForeColor = "darkblue"
    $button.Font = $buttonFont
    $Form.Controls.Add($button)
}