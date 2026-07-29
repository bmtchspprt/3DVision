$ErrorActionPreference = "Continue"
Add-Type -AssemblyName System.Drawing

$binDir = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin"
$out = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\_deep_hunt\from_resources"
New-Item -ItemType Directory -Force -Path $out | Out-Null

function Try-SaveBytes($bytes, $pathBase) {
  if (-not $bytes -or $bytes.Length -lt 16) { return $false }
  $ext = $null
  if ($bytes[0] -eq 0x89 -and $bytes[1] -eq 0x50) { $ext = ".png" }
  elseif ($bytes[0] -eq 0xFF -and $bytes[1] -eq 0xD8) { $ext = ".jpg" }
  elseif ($bytes[0] -eq 0x42 -and $bytes[1] -eq 0x4D) { $ext = ".bmp" }
  elseif ($bytes[0] -eq 0x47 -and $bytes[1] -eq 0x49) { $ext = ".gif" }
  elseif ($bytes[0] -eq 0x00 -and $bytes[1] -eq 0x00 -and $bytes[2] -eq 0x01 -and $bytes[3] -eq 0x00) { $ext = ".ico" }
  if (-not $ext) { return $false }
  $path = $pathBase + $ext
  [IO.File]::WriteAllBytes($path, $bytes)
  return $true
}

function Read-StreamBytes($stream) {
  if ($null -eq $stream) { return $null }
  if ($stream -is [byte[]]) { return $stream }
  $ms = New-Object IO.MemoryStream
  if ($stream.CanSeek) { $stream.Position = 0 }
  $stream.CopyTo($ms)
  return $ms.ToArray()
}

$report = @()
Get-ChildItem $binDir -Filter "*.dll" | ForEach-Object {
  $dll = $_
  try { $asm = [Reflection.Assembly]::LoadFrom($dll.FullName) } catch { return }
  foreach ($resName in $asm.GetManifestResourceNames()) {
    try {
      $stream = $asm.GetManifestResourceStream($resName)
      if (-not $stream) { continue }
      $raw = Read-StreamBytes $stream
      $stream.Close()
      if (-not $raw) { continue }

      # Direct image resource
      $safeRes = ($dll.BaseName + "__" + ($resName -replace "[^a-zA-Z0-9_.-]", "_"))
      if ($safeRes.Length -gt 100) { $safeRes = $safeRes.Substring(0, 100) }
      if (Try-SaveBytes $raw (Join-Path $out $safeRes)) {
        $report += [pscustomobject]@{ Dll=$dll.Name; Key=$resName; Kind="direct"; Bytes=$raw.Length }
        continue
      }

      # ResourceReader for .resources
      if ($resName -match "\.resources$|\.g\.resources$") {
        $tmp = Join-Path $out ("tmp_" + $dll.BaseName + "_" + [Guid]::NewGuid().ToString("N").Substring(0,8) + ".resources")
        [IO.File]::WriteAllBytes($tmp, $raw)
        try {
          $reader = New-Object System.Resources.ResourceReader($tmp)
          $enum = $reader.GetEnumerator()
          while ($enum.MoveNext()) {
            $key = [string]$enum.Key
            $val = $enum.Value
            $bytes = $null
            try {
              if ($val -is [byte[]]) { $bytes = $val }
              elseif ($val -is [IO.Stream]) { $bytes = Read-StreamBytes $val }
              elseif ($val -is [System.Drawing.Bitmap]) {
                $ms = New-Object IO.MemoryStream
                $val.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
                $bytes = $ms.ToArray()
              }
              elseif ($val -is [System.Drawing.Icon]) {
                $ms = New-Object IO.MemoryStream
                $val.Save($ms)
                $bytes = $ms.ToArray()
              }
            } catch {}
            if (-not $bytes) { continue }
            $safe = ($dll.BaseName + "__" + ($key -replace "[^a-zA-Z0-9_.-]", "_"))
            if ($safe.Length -gt 100) { $safe = $safe.Substring(0, 100) }
            if (Try-SaveBytes $bytes (Join-Path $out $safe)) {
              $report += [pscustomobject]@{ Dll=$dll.Name; Key=$key; Kind="resources"; Bytes=$bytes.Length }
            }
          }
          $reader.Close()
        } catch {}
      }
    } catch {}
  }
}

Write-Output "=== Saved image resources ==="
$report | Sort-Object Dll, Key | Format-Table -AutoSize
Write-Output ("count=" + $report.Count)

Write-Output ""
Write-Output "=== Small tall candidates (possible single vessel) ==="
Get-ChildItem $out -Include *.png,*.bmp,*.gif,*.jpg -Recurse -ErrorAction SilentlyContinue | ForEach-Object {
  try {
    $img = [System.Drawing.Image]::FromFile($_.FullName)
    if ($img.Width -le 48 -and $img.Height -ge 16 -and $img.Height -ge $img.Width) {
      # color stats
      $bmp = New-Object System.Drawing.Bitmap $_.FullName
      $green=0; $blue=0; $white=0; $opaque=0
      for ($y=0; $y -lt $bmp.Height; $y++) {
        for ($x=0; $x -lt $bmp.Width; $x++) {
          $p = $bmp.GetPixel($x,$y)
          if ($p.A -lt 128) { continue }
          $opaque++
          if ($p.G -gt 90 -and $p.G -gt $p.R+20 -and $p.G -gt $p.B) { $green++ }
          elseif ($p.B -gt $p.R+15 -and $p.B -gt $p.G) { $blue++ }
          elseif ($p.R -gt 200 -and $p.G -gt 200 -and $p.B -gt 200) { $white++ }
        }
      }
      $bmp.Dispose()
      [pscustomobject]@{ Name=$_.Name; W=$img.Width; H=$img.Height; Green=$green; Blue=$blue; White=$white; Opaque=$opaque }
    }
    $img.Dispose()
  } catch {}
} | Sort-Object Green, Blue -Descending | Format-Table -AutoSize
