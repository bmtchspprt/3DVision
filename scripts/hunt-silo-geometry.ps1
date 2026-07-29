param(
  [string]$DllPath = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll",
  [string]$OutDir = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision"
)

$bytes = [IO.File]::ReadAllBytes($DllPath)
# Search UTF-16 for geometry-related strings near vessel drawing
$terms = @(
  'VesselShape','SiloShape','TankShape','FillLevel','FullLevel','EmptyLevel',
  'PathGeometry','StreamGeometry','DrawingImage','VesselView','SiteVessel',
  'topcone','bottomcone','cencylinder','VesselFill','MaterialFill'
)
foreach ($t in $terms) {
  $pat = [Text.Encoding]::Unicode.GetBytes($t)
  $hits = 0
  for ($i = 0; $i -lt $bytes.Length - $pat.Length; $i++) {
    $ok = $true
    for ($j = 0; $j -lt $pat.Length; $j++) {
      if ($bytes[$i+$j] -ne $pat[$j]) { $ok = $false; break }
    }
    if ($ok) { $hits++; if ($hits -le 3) { Write-Output "HIT $t @ $i" } }
  }
  if ($hits -eq 0) { Write-Output "MISS $t" } else { Write-Output "COUNT $t = $hits" }
}

# Also dump nearby ASCII path-like M/L/Z sequences near 'F' marker context is hard;
# Extract all JPG geometry assets with clear names for inspection
$asm = [Reflection.Assembly]::LoadFrom($DllPath)
$resName = $asm.GetManifestResourceNames() | Where-Object { $_ -like "*.g.resources" } | Select-Object -First 1
$stream = $asm.GetManifestResourceStream($resName)
$tmp = Join-Path $env:TEMP "mv.g.resources"
$fs = [IO.File]::Create($tmp)
$stream.CopyTo($fs); $fs.Close(); $stream.Close()

function Read-StreamBytes($s) {
  $ms = New-Object IO.MemoryStream
  if ($s.CanSeek) { $s.Position = 0 }
  $s.CopyTo($ms)
  return $ms.ToArray()
}

$reader = New-Object System.Resources.ResourceReader($tmp)
$enum = $reader.GetEnumerator()
while ($enum.MoveNext()) {
  $key = [string]$enum.Key
  if ($key -match 'images/(top|bottom|cen)') {
    $b = Read-StreamBytes $enum.Value
    $name = Split-Path $key -Leaf
    [IO.File]::WriteAllBytes((Join-Path $OutDir $name), $b)
    Write-Output "SAVED $name $($b.Length)"
  }
  if ($key -match 'vessel|siteview|scroller') {
    $b = Read-StreamBytes $enum.Value
    $safe = ($key -replace '[\\/]', '_') + '.baml'
    [IO.File]::WriteAllBytes((Join-Path $OutDir $safe), $b)
    Write-Output "BAML $key $($b.Length)"
  }
}
$reader.Close()
