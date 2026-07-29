param(
  [string]$SrcDir = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision",
  [string]$Dest = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\extracted"
)

New-Item -ItemType Directory -Force -Path $Dest | Out-Null
$total = 0

function Export-PngsFromResourceFile($path) {
  $local = 0
  try {
    $reader = New-Object System.Resources.ResourceReader($path)
    $enum = $reader.GetEnumerator()
    while ($enum.MoveNext()) {
      $key = [string]$enum.Key
      $val = $enum.Value
      if ($val -isnot [byte[]]) { continue }
      $bytes = [byte[]]$val
      if ($bytes.Length -lt 8) { continue }
      if ($bytes[0] -ne 0x89 -or $bytes[1] -ne 0x50) { continue }
      $base = [IO.Path]::GetFileNameWithoutExtension($path)
      $safeKey = ($key -replace '[\\/:*?"<>|]', '_')
      $name = if ($safeKey -match '\.png$') { $safeKey } else { $safeKey + '.png' }
      $out = Join-Path $Dest $name
      if (Test-Path $out) {
        $out = Join-Path $Dest ($base + '__' + $name)
      }
      [IO.File]::WriteAllBytes($out, $bytes)
      $local++
      Write-Output "  $name ($($bytes.Length) bytes)"
    }
    $reader.Close()
  } catch {
    Write-Output "  SKIP $($_.Exception.Message)"
  }
  return $local
}

Get-ChildItem $SrcDir -Filter '*.resources' | ForEach-Object {
  Write-Output "FILE $($_.Name)"
  $total += Export-PngsFromResourceFile $_.FullName
}
Write-Output "TOTAL PNGs: $total -> $Dest"
