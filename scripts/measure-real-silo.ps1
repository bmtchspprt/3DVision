param(
  [string]$Src = "C:\Users\cody.krehnke\.cursor\projects\c-Users-cody-krehnke-Documents-3D-Emulator\assets\c__Users_cody.krehnke_AppData_Roaming_Cursor_User_workspaceStorage_c18693dd6ebe325de398c56d6e132002_images_image-4ba0a41a-1f16-4ae0-b6e3-f5e002a9d3a1.png"
)

Add-Type -AssemblyName System.Drawing
$bmp = [Drawing.Bitmap]::FromFile($Src)
Write-Output ("card {0}x{1}" -f $bmp.Width, $bmp.Height)

# Scan for dark outline pixels to find silo bounding box (left side of card)
$minX = $bmp.Width; $maxX = 0; $minY = $bmp.Height; $maxY = 0
$scanW = [int]($bmp.Width * 0.45)
for ($y = 0; $y -lt $bmp.Height; $y++) {
  for ($x = 0; $x -lt $scanW; $x++) {
    $c = $bmp.GetPixel($x, $y)
    # near-black outline
    if ($c.R -lt 60 -and $c.G -lt 60 -and $c.B -lt 60) {
      if ($x -lt $minX) { $minX = $x }
      if ($x -gt $maxX) { $maxX = $x }
      if ($y -lt $minY) { $minY = $y }
      if ($y -gt $maxY) { $maxY = $y }
    }
  }
}
Write-Output ("outline bbox x={0}..{1} y={2}..{3} w={4} h={5}" -f $minX, $maxX, $minY, $maxY, ($maxX-$minX+1), ($maxY-$minY+1))

# Find red F-line (high R, low G/B) within silo x-range
$redYs = @()
for ($y = $minY; $y -le $maxY; $y++) {
  $redCount = 0
  for ($x = $minX; $x -le $maxX; $x++) {
    $c = $bmp.GetPixel($x, $y)
    if ($c.R -gt 180 -and $c.G -lt 90 -and $c.B -lt 90) { $redCount++ }
  }
  if ($redCount -gt 8) { $redYs += $y }
}
if ($redYs.Count) {
  Write-Output ("F-line y approx {0}..{1}" -f $redYs[0], $redYs[-1])
}

# Find orange E-line
$orangeYs = @()
for ($y = $minY; $y -le $maxY; $y++) {
  $cnt = 0
  for ($x = $minX; $x -le $maxX; $x++) {
    $c = $bmp.GetPixel($x, $y)
    if ($c.R -gt 180 -and $c.G -gt 70 -and $c.G -lt 160 -and $c.B -lt 80) { $cnt++ }
  }
  if ($cnt -gt 4) { $orangeYs += $y }
}
if ($orangeYs.Count) {
  Write-Output ("E-line y approx {0}..{1}" -f $orangeYs[0], $orangeYs[-1])
}

# Sample width at mid-body
$midY = [int](($minY + $maxY) / 2)
$leftEdge = -1; $rightEdge = -1
for ($x = $minX; $x -le $maxX; $x++) {
  $c = $bmp.GetPixel($x, $midY)
  if ($c.R -lt 60 -and $c.G -lt 60 -and $c.B -lt 60) {
    if ($leftEdge -lt 0) { $leftEdge = $x }
    $rightEdge = $x
  }
}
Write-Output ("mid-body width edges {0}..{1} = {2}px" -f $leftEdge, $rightEdge, ($rightEdge-$leftEdge+1))

# Find roof junction: first y where width becomes ~full cylinder width
$fullW = $rightEdge - $leftEdge
$roofJoin = $minY
for ($y = $minY; $y -lt $midY; $y++) {
  $l = -1; $r = -1
  for ($x = $minX; $x -le $maxX; $x++) {
    $c = $bmp.GetPixel($x, $y)
    if ($c.R -lt 60 -and $c.G -lt 60 -and $c.B -lt 60) {
      if ($l -lt 0) { $l = $x }
      $r = $x
    }
  }
  if ($l -ge 0 -and ($r - $l) -ge ($fullW * 0.92)) { $roofJoin = $y; break }
}
Write-Output ("roof->cylinder join y={0} (from top {1}px)" -f $roofJoin, ($roofJoin-$minY))

# Find hopper join: last y from bottom where width still ~full
$hopperJoin = $maxY
for ($y = $maxY; $y -gt $midY; $y--) {
  $l = -1; $r = -1
  for ($x = $minX; $x -le $maxX; $x++) {
    $c = $bmp.GetPixel($x, $y)
    if ($c.R -lt 60 -and $c.G -lt 60 -and $c.B -lt 60) {
      if ($l -lt 0) { $l = $x }
      $r = $x
    }
  }
  if ($l -ge 0 -and ($r - $l) -ge ($fullW * 0.92)) { $hopperJoin = $y; break }
}
Write-Output ("cylinder->hopper join y={0} (from tip up {1}px)" -f $hopperJoin, ($maxY-$hopperJoin))

$h = $maxY - $minY + 1
Write-Output ("ratios roof={0:P0} cyl={1:P0} hopper={2:P0}" -f (($roofJoin-$minY)/$h), (($hopperJoin-$roofJoin)/$h), (($maxY-$hopperJoin)/$h))
Write-Output ("aspect w/h = {0:N3}" -f (($maxX-$minX+1)/$h))

# Crop silo only for reference asset
$pad = 4
$rx = [Math]::Max(0, $minX - $pad)
$ry = [Math]::Max(0, $minY - $pad)
$rw = [Math]::Min($bmp.Width - $rx, $maxX - $minX + 1 + $pad * 2 + 20)
$rh = [Math]::Min($bmp.Height - $ry, $maxY - $minY + 1 + $pad * 2)
$crop = $bmp.Clone((New-Object Drawing.Rectangle $rx, $ry, $rw, $rh), $bmp.PixelFormat)
$out = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\silo-real-measured.png"
$crop.Save($out, [Drawing.Imaging.ImageFormat]::Png)
Write-Output "saved $out"
$crop.Dispose()
$bmp.Dispose()
