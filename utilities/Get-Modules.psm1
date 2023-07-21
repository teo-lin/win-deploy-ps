function Get-Modules {
    # Get the module folder groups (subfolders)
    $Groups = Get-ChildItem -Path "$PSScriptRoot\..\modules" -Directory

    # Loop through each subfolder and load the modules
    $Mod = New-Object -TypeName PSObject
    foreach ($Group in $Groups) {
        # Create a nested object for the module category subfolder
        $Category = $Group.Name
        $Mod | Add-Member -MemberType NoteProperty -Name $Group.Name -Value (New-Object -TypeName PSObject)

        # Get a collection of FileInfo Object as $Modules
        $Modules = Get-ChildItem -Path $Group.FullName -Filter *.psm1

        # Loop through each module file and load it
        foreach ($Module in $Modules) {
            # Load the module file and get the exports
            $ModuleName = $Module.BaseName
            $ModulePath = Join-Path (Split-Path $PSScriptRoot -Parent) "modules\$Group\$Module"
            Import-Module -Name $ModulePath -Force #-Verbose

            # Execute the main function (the function must be named exactly as the module file)
            $Hash = Invoke-Expression $ModuleName

            # Add the content to $Mod
            $Mod.$Category | Add-Member -MemberType NoteProperty -Name $ModuleName -Value $Hash

            # Remove the module from memory
            Remove-Module $ModuleName
        }
    }

    return $Mod
}