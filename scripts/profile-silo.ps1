param(
  [string]$Src = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\silo-real-measured.png"
)
Add-Type -AssemblyName System.Drawing
$bmp = [Drawing.Bitmap]::FromFile($Src)
Write-Output ("crop {0}x{1}" -f $bmp.Width, $bmp.Height)

# Find silhouette by non-background pixels (bg is light blue-grey ~176,196,222)
function IsBg($c) {
  return ($c.B -gt 180 -and $c.G -gt 170 -and $c.R -gt 150 -and [Math]::Abs([int]$c.B - [int]$c.G) -lt 40)
}
function IsOutline($c) {
  return ($c.R -lt 70 -and $c.G -lt 70 -and $c.B -lt 70)
}

# Width profile every few rows
$profiles = @()
for ($y = 0; $y -lt $bmp.Height; $y += 2) {
  $l = -1; $r = -1
  for ($x = 0; $x -lt $bmp.Width; $x++) {
    $c = $bmp.GetPixel($x, $y)
    if (IsOutline $c) {
      if ($l -lt 0) { $l = $x }
      $r = $x
    }
  }
  if ($l -ge 0) {
    $profiles += [pscustomobject]@{ y = $y; l = $l; r = $r; w = ($r - $l + 1) }
  }
}
$maxW = ($profiles | Measure-Object w -Maximum).Maximum
Write-Output "max outline width $maxW"
# Find where width reaches 90% of max (roof join) and drops below 90% (hopper join)
$roof = ($profiles | Where-Object { $_.w -ge $maxW * 0.9 } | Select-Object -First 1)
$hopper = ($profiles | Where-Object { $_.w -ge $maxW * 0.9 } | Select-Object -Last 1)
$top = $profiles[0]
$bot = $profiles[-1]
Write-Output ("top peak-ish y={0} w={1}" -f $top.y, $top.w)
Write-Output ("roof join y={0} w={1}" -f $roof.y, $roof.w)
Write-Output ("hopper join y={0} w={1}" -f $hopper.y, $hopper.w)
Write-Output ("tip y={0} w={1}" -f $bot.y, $bot.w)
$h = $bot.y - $top.y
if ($h -gt 0) {
  Write-Output ("roof%={0:N1} cyl%={1:N1} hop%={2:N1}" -f (100*($roof.y-$top.y)/$h), (100*($hopper.y-$roof.y)/$h), (100*($bot.y-$hopper.y)/$h))
  Write-Output ("body aspect = {0:N3}" -f ($maxW / $h))
}

# Sample fill color at mid lower body
$sy = [int](($roof.y + $hopper.y) * 0.7)
$sx = [int](($roof.l + $roof.r) / 2)
$fc = $bmp.GetPixel($sx, $sy)
Write-Output ("center fill sample @{0},{1} = {2},{3},{4}" -f $sx, $sy, $fc.R, $fc.G, $fc.B)
$sx2 = $roof.l + 8
$fc2 = $bmp.GetPixel($sx2, $sy)
Write-Output ("left fill sample = {0},{1},{2}" -f $fc2.R, $fc2.G, $fc2.B)
$sx3 = $roof.r - 8
$fc3 = $bmp.GetPixel($sx3, $sy)
Write-Output ("right fill sample = {0},{1},{2}" -f $fc3.R, $fc3.G, $fc3.B)

# Empty area sample near top of cylinder
$ey = $roof.y + 20
$ec = $bmp.GetPixel($sx, $ey)
Write-Output ("empty center = {0},{1},{2}" -f $ec.R, $ec.G, $ec.B)
$bmp.Dispose()
