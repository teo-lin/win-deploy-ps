function Test-AdminPrivileges {
    # Check if the script is running as an administrator
    if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "Nooo! This script requires administrator rights. Please run this script as an administrator."
        exit
    }

    # The script has administrator rights
    Write-Host "Yepii! This script is running with administrator rights."
}