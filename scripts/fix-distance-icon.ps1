param(
  [string]$Strip = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\toolbar_strip.png",
  [string]$Dest = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\icon_distance.png"
)

Add-Type -AssemblyName System.Drawing
$img = [Drawing.Bitmap]::FromFile($Strip)
Write-Output ("strip {0}x{1}" -f $img.Width, $img.Height)

# Distance icon is leftmost on the blue toolbar strip. Sample a few crops.
# From visual: icon sits just left of the word Distance.
$crops = @(
  @{ x = 4; y = 8; s = 18 },
  @{ x = 6; y = 10; s = 16 },
  @{ x = 8; y = 9; s = 17 },
  @{ x = 5; y = 7; s = 20 }
)
$dir = Split-Path $Dest
foreach ($c in $crops) {
  $rect = New-Object Drawing.Rectangle $c.x, $c.y, $c.s, $c.s
  $crop = $img.Clone($rect, $img.PixelFormat)
  $path = Join-Path $dir ("dist_icon_{0}_{1}.png" -f $c.x, $c.s)
  $crop.Save($path, [Drawing.Imaging.ImageFormat]::Png)
  Write-Output $path
  $crop.Dispose()
}

# Best guess: ~16px icon near left of Distance label
$best = $img.Clone((New-Object Drawing.Rectangle 6, 10, 16, 16), $img.PixelFormat)
# Make blue background transparent-ish by keeping as-is for toolbar (blue on blue is fine)
$best.Save($Dest, [Drawing.Imaging.ImageFormat]::Png)
Write-Output ("Wrote {0} {1}x{2}" -f $Dest, $best.Width, $best.Height)
$best.Dispose()
$img.Dispose()
