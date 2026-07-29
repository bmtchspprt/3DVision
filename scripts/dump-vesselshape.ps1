param(
  [string]$DllPath = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll",
  [string]$OutDir = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision"
)

$bytes = [IO.File]::ReadAllBytes($DllPath)
$offset = 1325060
$start = [Math]::Max(0, $offset - 200)
$end = [Math]::Min($bytes.Length - 1, $offset + 800)
# Dump surrounding as UTF-16 text
$chunk = $bytes[$start..$end]
$text = [Text.Encoding]::Unicode.GetString($chunk)
Write-Output "=== UTF16 around VesselShape ==="
Write-Output $text

# Also search for more vessel drawing related UTF16 strings
$more = @('VesselShape','VesselGeometry','DrawVessel','PaintVessel','VesselPath','ConeTop','ConeBottom','CylinderBody','FullMark','EmptyMark')
foreach ($t in $more) {
  $pat = [Text.Encoding]::Unicode.GetBytes($t)
  for ($i = 0; $i -lt $bytes.Length - $pat.Length; $i++) {
    $ok = $true
    for ($j = 0; $j -lt $pat.Length; $j++) {
      if ($bytes[$i+$j] -ne $pat[$j]) { $ok = $false; break }
    }
    if ($ok) {
      $s = [Math]::Max(0, $i - 40)
      $e = [Math]::Min($bytes.Length - 1, $i + 120)
      $ctx = [Text.Encoding]::Unicode.GetString($bytes[$s..$e]) -replace '[\x00-\x1f]', ' '
      Write-Output "CTX $t @ $i : $ctx"
      break
    }
  }
}
