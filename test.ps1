function Dance {
    $All = New-Object -TypeName PSObject -Property @{
        unu = 1
        doi = "doi"
        tre = { Write-Host "Trei" }
        pat = @{
            ala = "alla"
            bala = "balla"
        }
    }

    return $All
}
$All = Dance
$All | Add-Member -PassThru NoteProperty cin 5
Write-Host $All
