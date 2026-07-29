param(
  [string]$Src = "C:\Users\cody.krehnke\.cursor\projects\c-Users-cody-krehnke-Documents-3D-Emulator\assets\c__Users_cody.krehnke_AppData_Roaming_Cursor_User_workspaceStorage_c18693dd6ebe325de398c56d6e132002_images_image-55b955b1-a394-41b8-9463-562fb161b1eb.png",
  [string]$DestDir = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision"
)

Add-Type -AssemblyName System.Drawing
$img = [Drawing.Bitmap]::FromFile($Src)
Write-Output ("Source {0}x{1}" -f $img.Width, $img.Height)

# Crop the silo graphic region from the real MultiVision vessel card screenshot.
# The silo sits left of the data text; tune crop box from measured proportions.
$w = $img.Width
$h = $img.Height

# Approximate: header ~8% height, silo starts ~12% from top, ~28% width, ~78% height
$x = [int]($w * 0.04)
$y = [int]($h * 0.14)
$cw = [int]($w * 0.30)
$ch = [int]($h * 0.78)

$rect = New-Object Drawing.Rectangle $x, $y, $cw, $ch
$crop = $img.Clone($rect, $img.PixelFormat)
$out = Join-Path $DestDir "silo-real-crop.png"
$crop.Save($out, [Drawing.Imaging.ImageFormat]::Png)
Write-Output ("Cropped {0}x{1} -> {2}" -f $crop.Width, $crop.Height, $out)

# Also save a few alternate crops for manual pick
$alts = @(
  @{ name = "silo-real-tight.png"; x = 0.06; y = 0.16; w = 0.26; h = 0.74 },
  @{ name = "silo-real-wide.png"; x = 0.02; y = 0.12; w = 0.34; h = 0.80 }
)
foreach ($a in $alts) {
  $r = New-Object Drawing.Rectangle ([int]($w*$a.x)), ([int]($h*$a.y)), ([int]($w*$a.w)), ([int]($h*$a.h))
  $c = $img.Clone($r, $img.PixelFormat)
  $p = Join-Path $DestDir $a.name
  $c.Save($p, [Drawing.Imaging.ImageFormat]::Png)
  Write-Output ("Alt {0} {1}x{2}" -f $a.name, $c.Width, $c.Height)
  $c.Dispose()
}

$crop.Dispose()
$img.Dispose()
