$ModulesFolder = "$PSScriptRoot\modules"

# Create an empty object to store the module information
$Mod = New-Object -TypeName PSObject

# Get a list of all subfolders in the modules folder
$ModuleFolders = Get-ChildItem -Path $ModulesFolder -Directory

# Loop through each subfolder and load the modules
foreach ($ModuleFolder in $ModuleFolders) {
    # Create a nested object for the module category
    $Mod | Add-Member -MemberType NoteProperty -Name $ModuleFolder.Name -Value (New-Object -TypeName PSObject)

    # Get a list of all module files in the subfolder
    $ModuleFiles = Get-ChildItem -Path $ModuleFolder.FullName -Filter *.psm1

    # Loop through each module file and load it
    foreach ($ModuleFile in $ModuleFiles) {
        # Load the module file and get the exported variable
        Import-Module -Name $ModuleFile.FullName -Force
        $ExportedVariables = Get-Variable -Scope Global -Name *

        # Get the name of the exported variable
        $VariableName = $ExportedVariables.Name | Where-Object { $_ -notlike "*__*" }

        # Add the module as a property of the category object
        $Mod.$ModuleFolder.Name | Add-Member -MemberType NoteProperty -Name $VariableName -Value $ExportedVariables.Value
    }
}

Write-Host $Mod

# Export the $Mod variable so it can be used in other scripts
Export-ModuleMember -Variable $Mod