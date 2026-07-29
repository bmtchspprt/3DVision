$ErrorActionPreference = "Stop"
Add-Type -AssemblyName System.Drawing
$DllPath = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll"
$outDir = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\_reextract"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$asm = [Reflection.Assembly]::LoadFrom($DllPath)
$resName = $asm.GetManifestResourceNames() | Where-Object { $_ -like "*.g.resources" } | Select-Object -First 1
Write-Output "Resource: $resName"
$stream = $asm.GetManifestResourceStream($resName)
$tempRes = Join-Path $outDir "temp.g.resources"
$fs = [IO.File]::Create($tempRes)
$stream.CopyTo($fs); $fs.Close(); $stream.Close()
$reader = New-Object System.Resources.ResourceReader($tempRes)
$enum = $reader.GetEnumerator()
$found = @()
while ($enum.MoveNext()) {
  $key = [string]$enum.Key
  if ($key -notmatch '^images/') { continue }
  $val = $enum.Value
  $bytes = $null
  if ($val -is [byte[]]) { $bytes = $val }
  else {
    $ms = New-Object IO.MemoryStream
    if ($val.CanSeek) { $val.Position = 0 }
    $val.CopyTo($ms)
    $bytes = $ms.ToArray()
  }
  if (-not $bytes -or $bytes.Length -lt 8) { continue }
  if ($bytes[0] -ne 0x89 -or $bytes[1] -ne 0x50) { continue }
  $leaf = Split-Path $key -Leaf
  $path = Join-Path $outDir $leaf
  [IO.File]::WriteAllBytes($path, $bytes)
  $bmp = [System.Drawing.Bitmap]::FromFile($path)
  $green = 0; $blue = 0; $brown = 0; $opaque = 0
  for ($y = 0; $y -lt $bmp.Height; $y++) {
    for ($x = 0; $x -lt $bmp.Width; $x++) {
      $p = $bmp.GetPixel($x, $y)
      if ($p.A -lt 128) { continue }
      $opaque++
      if ($p.G -gt 80 -and $p.G -gt $p.R + 15 -and $p.G -gt $p.B) { $green++ }
      elseif ($p.B -gt $p.R + 20 -and $p.B -gt $p.G) { $blue++ }
      elseif ($p.R -gt 100 -and $p.R -gt $p.B -and $p.G -gt 60 -and $p.G -lt 200) { $brown++ }
    }
  }
  $found += [pscustomobject]@{
    Name = $leaf; W = $bmp.Width; H = $bmp.Height; Bytes = $bytes.Length
    Green = $green; Blue = $blue; Brown = $brown; Opaque = $opaque; Key = $key
  }
  $bmp.Dispose()
}
$reader.Close()
Write-Output "=== Top green images ==="
$found | Sort-Object Green -Descending | Select-Object -First 20 | Format-Table Name, W, H, Bytes, Green, Blue, Brown, Opaque -AutoSize
Write-Output "=== level/silo names ==="
$found | Where-Object { $_.Name -match "level|silo|vessel|tank|bin|fill" } | Format-Table Name, W, H, Green, Blue, Brown, Bytes -AutoSize
Write-Output ("Total PNGs: " + $found.Count)
