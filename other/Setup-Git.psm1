function Config-Git {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Settings
    )

    # Set Git configuration settings
    git config --global user.name $Settings.username
    $mail = $Settings.email
    if ($mail = New-Object System.Net.Mail.MailAddress($mail)) { git config --global user.email $mail }
    else {
        $mail = "$mail@users.noreply.github.com"
        if ($mail = New-Object System.Net.Mail.MailAddress($mail)) { git config --global user.email $mail }
    }

    git config --global credential.helper store
    git config --global core.editor "code --wait"

    # Store the PAT in the Windows Credential Manager
    $cred = New-Object System.Management.Automation.PSCredential($Username, $PersonalAccessToken)
    $uri = "git:https://github.com"
    cmdkey /add:$uri /user:$Username /pass:$PersonalAccessToken

    # Test the connection by cloning a repository
    git clone https://github.com/your-github-username/your-repository.git

    Write-Host "You are now logged in to GitHub with username $Username."
}