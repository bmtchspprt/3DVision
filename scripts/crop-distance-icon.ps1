param(
  [string]$Shot = "C:\Users\cody.krehnke\.cursor\projects\c-Users-cody-krehnke-Documents-3D-Emulator\assets\c__Users_cody.krehnke_AppData_Roaming_Cursor_User_workspaceStorage_c18693dd6ebe325de398c56d6e132002_images_image-f0622815-0655-40bc-ab7b-128186ffd6d6.png",
  [string]$Dest = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\icon_distance_real.png"
)

Add-Type -AssemblyName System.Drawing
if (-not (Test-Path $Shot)) {
  $Shot = (Get-ChildItem "C:\Users\cody.krehnke\.cursor\projects\c-Users-cody-krehnke-Documents-3D-Emulator\assets" -Filter "*f062*.png" | Select-Object -First 1).FullName
}
$img = [Drawing.Bitmap]::FromFile($Shot)
Write-Output ("Shot {0}x{1}" -f $img.Width, $img.Height)

# Toolbar is a thin blue bar; Distance is the leftmost button icon.
# Estimate from typical MultiVision layout proportions.
$toolbarTop = [int]($img.Height * 0.175)
$toolbarH = [int]($img.Height * 0.035)
$iconX = [int]($img.Width * 0.012)
$iconY = $toolbarTop + [int]($toolbarH * 0.15)
$iconS = [Math]::Max(12, [int]($toolbarH * 0.70))

# Save a few candidate crops around Distance
$candidates = @(
  @{ n = "dist_a.png"; x = 0.010; y = 0.168; s = 0.028 },
  @{ n = "dist_b.png"; x = 0.012; y = 0.172; s = 0.024 },
  @{ n = "dist_c.png"; x = 0.008; y = 0.165; s = 0.032 },
  @{ n = "dist_d.png"; x = 0.014; y = 0.175; s = 0.022 }
)
$outDir = Split-Path $Dest
foreach ($c in $candidates) {
  $sz = [int]($img.Width * $c.s)
  $x = [int]($img.Width * $c.x)
  $y = [int]($img.Height * $c.y)
  if ($x + $sz -gt $img.Width) { continue }
  if ($y + $sz -gt $img.Height) { continue }
  $rect = New-Object Drawing.Rectangle $x, $y, $sz, $sz
  $crop = $img.Clone($rect, $img.PixelFormat)
  $path = Join-Path $outDir $c.n
  $crop.Save($path, [Drawing.Imaging.ImageFormat]::Png)
  Write-Output ("Saved {0} {1}x{2} at {3},{4}" -f $c.n, $sz, $sz, $x, $y)
  $crop.Dispose()
}

# Also crop a wider strip of the left toolbar for inspection
$stripX = [int]($img.Width * 0.005)
$stripY = [int]($img.Height * 0.160)
$stripW = [int]($img.Width * 0.45)
$stripH = [int]($img.Height * 0.055)
$strip = $img.Clone((New-Object Drawing.Rectangle $stripX, $stripY, $stripW, $stripH), $img.PixelFormat)
$strip.Save((Join-Path $outDir "toolbar_strip.png"), [Drawing.Imaging.ImageFormat]::Png)
Write-Output ("toolbar_strip {0}x{1}" -f $strip.Width, $strip.Height)
$strip.Dispose()
$img.Dispose()
