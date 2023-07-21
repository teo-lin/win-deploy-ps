# Import the check-admin-privileges module
Import-Module -Name "$PSScriptRoot\..\utilities\Test-AdminPrivileges.psm1"
Test-AdminPrivileges

# Create Interface
Import-Module -Name "$PSScriptRoot\..\interface\New-Interface.psm1"
New-Interface