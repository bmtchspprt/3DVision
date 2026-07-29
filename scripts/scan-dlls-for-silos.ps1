param(
  [string]$DllDir = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin",
  [string]$OutDir = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\from-dll"
)

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
Add-Type -AssemblyName System.Drawing

function Export-Pngs($path, $prefix) {
  $bytes = [IO.File]::ReadAllBytes($path)
  $idx = 0; $n = 0
  while ($idx -lt $bytes.Length - 8) {
    if ($bytes[$idx] -eq 0x89 -and $bytes[$idx+1] -eq 0x50 -and $bytes[$idx+2] -eq 0x4E -and $bytes[$idx+3] -eq 0x47) {
      $end = $idx + 4
      while ($end -lt $bytes.Length - 8) {
        if ($bytes[$end] -eq 0x49 -and $bytes[$end+1] -eq 0x45 -and $bytes[$end+2] -eq 0x4E -and $bytes[$end+3] -eq 0x44) { $end += 8; break }
        $end++
      }
      $len = $end - $idx
      if ($len -gt 500 -and $len -lt 5000000) {
        $n++
        $out = Join-Path $OutDir ("{0}_{1}.png" -f $prefix, $n)
        [IO.File]::WriteAllBytes($out, $bytes[$idx..($end-1)])
      }
      $idx = $end
    } else { $idx++ }
  }
  return $n
}

# Focus on likely UI assemblies
$targets = @('3DVisionGui.dll','APM.WPF.dll','APM.Common.dll','APM.Controls.dll')
Get-ChildItem $DllDir -Filter *.dll | Where-Object { $_.Name -match 'APM|Vision|WPF|Control|Draw|Graph|Vessel' } | ForEach-Object {
  Write-Output "Scan $($_.Name) ($([math]::Round($_.Length/1MB,1)) MB)"
  $c = Export-Pngs $_.FullName ($_.BaseName)
  Write-Output "  -> $c pngs"
}

Write-Output "=== Tall candidates (possible silos) ==="
Get-ChildItem $OutDir -Filter *.png | ForEach-Object {
  try {
    $img = [Drawing.Image]::FromFile($_.FullName)
    if ($img.Height -gt $img.Width -and $img.Height -ge 60 -and $img.Width -ge 20) {
      Write-Output ("{0,4}x{1,-4} {2,7}b {3}" -f $img.Width, $img.Height, $_.Length, $_.Name)
    }
    $img.Dispose()
  } catch {}
}
