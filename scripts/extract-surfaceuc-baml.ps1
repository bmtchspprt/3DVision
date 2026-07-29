$ErrorActionPreference = "Continue"
Add-Type -AssemblyName System.Drawing
$dll = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\APM.SurfaceUC.dll"
$out = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\_deep_hunt\surfaceuc_baml"
New-Item -ItemType Directory -Force -Path $out | Out-Null
$asm = [Reflection.Assembly]::LoadFrom($dll)
foreach ($resName in $asm.GetManifestResourceNames()) {
  Write-Output "RES $resName"
  $stream = $asm.GetManifestResourceStream($resName)
  $ms = New-Object IO.MemoryStream
  $stream.CopyTo($ms); $stream.Close()
  $raw = $ms.ToArray()
  if ($resName -notmatch "resources") { continue }
  $tmp = Join-Path $out "tmp.resources"
  [IO.File]::WriteAllBytes($tmp, $raw)
  try {
    $reader = New-Object System.Resources.ResourceReader($tmp)
  } catch { continue }
  $enum = $reader.GetEnumerator()
  while ($enum.MoveNext()) {
    $key = [string]$enum.Key
    $val = $enum.Value
    $bytes = $null
    if ($val -is [IO.Stream]) {
      $m2 = New-Object IO.MemoryStream
      if ($val.CanSeek) { $val.Position = 0 }
      $val.CopyTo($m2)
      $bytes = $m2.ToArray()
    } elseif ($val -is [byte[]]) { $bytes = $val }
    if (-not $bytes) { continue }
    $safe = ($key -replace "[^a-zA-Z0-9_.-]", "_")
    if ($safe.Length -gt 90) { $safe = $safe.Substring(0,90) }
    $path = Join-Path $out $safe
    [IO.File]::WriteAllBytes($path, $bytes)
    if ($key -match "baml|theme|style|vessel|site") {
      Write-Output ("  KEY $key bytes=$($bytes.Length)")
    }
  }
  $reader.Close()
}

Write-Output ""
Write-Output "=== Search extracted for EM_Vesselbox / site_but / Drawing ==="
Get-ChildItem $out | ForEach-Object {
  $bytes = [IO.File]::ReadAllBytes($_.FullName)
  $uni = [Text.Encoding]::Unicode.GetString($bytes)
  $ascii = [Text.Encoding]::ASCII.GetString($bytes)
  $blob = $uni + $ascii
  if ($blob -match "EM_Vesselbox|site_but|DrawingImage|GeometryDrawing|Vesselbox|imageTemplate") {
    Write-Output $_.Name
    [regex]::Matches($uni, 'EM_[\w#]+|site_but[\w.]*|Images/[\w./]+|component/Images/[\w./]+|Drawing[\w]*|Geometry[\w]*|Path|Brush|Green|#[0-9A-Fa-f]{6,8}') |
      ForEach-Object { $_.Value } | Sort-Object -Unique | Select-Object -First 50 | ForEach-Object { "  $_" }
  }
}
