param(
  [string]$DllPath = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll",
  [string]$Dest = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\from-dll"
)

New-Item -ItemType Directory -Force -Path $Dest | Out-Null
Add-Type -AssemblyName System.Drawing

function Export-PngsFromBinary($inputPath, $outputDir, $prefix) {
  $bytes = [IO.File]::ReadAllBytes($inputPath)
  $idx = 0
  $n = 0
  while ($idx -lt $bytes.Length - 8) {
    if ($bytes[$idx] -eq 0x89 -and $bytes[$idx+1] -eq 0x50 -and $bytes[$idx+2] -eq 0x4E -and $bytes[$idx+3] -eq 0x47) {
      $end = $idx + 4
      while ($end -lt $bytes.Length - 8) {
        if ($bytes[$end] -eq 0x49 -and $bytes[$end+1] -eq 0x45 -and $bytes[$end+2] -eq 0x4E -and $bytes[$end+3] -eq 0x44) {
          $end += 8
          break
        }
        $end++
      }
      $len = $end - $idx
      if ($len -gt 200 -and $len -lt 2000000) {
        $n++
        $out = Join-Path $outputDir ("{0}_{1}.png" -f $prefix, $n)
        [IO.File]::WriteAllBytes($out, $bytes[$idx..($end-1)])
      }
      $idx = $end
    } else { $idx++ }
  }
  return $n
}

# Also scan other DLLs in bin for large PNGs that might be silo frames
$bin = Split-Path $DllPath -Parent
Get-ChildItem $bin -Filter *.dll | ForEach-Object {
  Write-Output "Scanning $($_.Name)..."
  $count = Export-PngsFromBinary $_.FullName $Dest $_.BaseName
  Write-Output "  $count PNGs"
}

# List large images that could be silo graphics
Add-Type -AssemblyName System.Drawing
Get-ChildItem $Dest -Filter *.png | ForEach-Object {
  try {
    $img = [Drawing.Image]::FromFile($_.FullName)
    if ($img.Width -ge 40 -and $img.Height -ge 80) {
      Write-Output ("CANDIDATE {0,5}x{1,-5} {2,8}b {3}" -f $img.Width, $img.Height, $_.Length, $_.Name)
    }
    $img.Dispose()
  } catch {}
}
