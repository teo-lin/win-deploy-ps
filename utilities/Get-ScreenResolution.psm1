function Get-ScreenResolution {
    # Load the System.Windows.Forms assembly
    Add-Type -AssemblyName System.Windows.Forms

    # Get the screen resolution of the primary display screen
    $screen = [System.Windows.Forms.Screen]::PrimaryScreen
    $width = $screen.Bounds.Width
    $height = $screen.Bounds.Height

    # Return the screen resolution as a hashtable
    return @{
        Width = $width
        Height = $height
        HalfWidth = $width / 2
    }
}