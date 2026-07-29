$ErrorActionPreference = "Continue"
Add-Type -AssemblyName System.Drawing

$binDir = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin"
$out = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\_deep_hunt\surfaceuc"
New-Item -ItemType Directory -Force -Path $out | Out-Null

$targets = @(
  "APM.SurfaceUC.dll",
  "VesselComponents.dll",
  "WPFStuff.dll",
  "APM.VesselGeom.dll",
  "APMRes.dll",
  "3DVisionGui.dll"
)

function Read-StreamBytes($stream) {
  if ($null -eq $stream) { return $null }
  if ($stream -is [byte[]]) { return $stream }
  $ms = New-Object IO.MemoryStream
  if ($stream.CanSeek) { $stream.Position = 0 }
  $stream.CopyTo($ms)
  return $ms.ToArray()
}

foreach ($name in $targets) {
  $path = Join-Path $binDir $name
  if (-not (Test-Path $path)) { Write-Output "MISSING $name"; continue }
  Write-Output "==== $name ===="
  try { $asm = [Reflection.Assembly]::LoadFrom($path) } catch { Write-Output "LOAD FAIL $_"; continue }
  Write-Output ("Manifest: " + ($asm.GetManifestResourceNames() -join ", "))
  foreach ($resName in $asm.GetManifestResourceNames()) {
    $stream = $asm.GetManifestResourceStream($resName)
    if (-not $stream) { continue }
    $raw = Read-StreamBytes $stream
    $stream.Close()
    $tmp = Join-Path $out (($name -replace "\.dll$","") + "__" + ($resName -replace "[^a-zA-Z0-9_.-]","_") + ".bin")
    [IO.File]::WriteAllBytes($tmp, $raw)
    Write-Output ("  resource $resName bytes=$($raw.Length)")

    # If .resources, enumerate keys
    if ($resName -match "resources") {
      try {
        $reader = New-Object System.Resources.ResourceReader($tmp)
        $enum = $reader.GetEnumerator()
        while ($enum.MoveNext()) {
          $key = [string]$enum.Key
          $val = $enum.Value
          $bytes = $null
          $typeName = if ($val) { $val.GetType().FullName } else { "null" }
          try {
            if ($val -is [byte[]]) { $bytes = $val }
            elseif ($val -is [IO.Stream]) { $bytes = Read-StreamBytes $val }
            elseif ($val -is [System.Drawing.Bitmap]) {
              $ms = New-Object IO.MemoryStream
              $val.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
              $bytes = $ms.ToArray()
            }
          } catch {}
          $info = "    KEY=$key TYPE=$typeName"
          if ($bytes) {
            $info += " BYTES=$($bytes.Length)"
            $leaf = ($key -replace "[^a-zA-Z0-9_.-]", "_")
            if ($leaf.Length -gt 80) { $leaf = $leaf.Substring(0,80) }
            $outFile = Join-Path $out (($name -replace "\.dll$","") + "__" + $leaf)
            if ($bytes.Length -ge 8 -and $bytes[0] -eq 0x89 -and $bytes[1] -eq 0x50) {
              [IO.File]::WriteAllBytes($outFile + ".png", $bytes)
              $info += " -> PNG"
              try {
                $img = [System.Drawing.Image]::FromFile($outFile + ".png")
                $info += " $($img.Width)x$($img.Height)"
                $img.Dispose()
              } catch {}
            } elseif ($bytes.Length -ge 2 -and $bytes[0] -eq 0x42 -and $bytes[1] -eq 0x4D) {
              [IO.File]::WriteAllBytes($outFile + ".bmp", $bytes)
              $info += " -> BMP"
            } else {
              [IO.File]::WriteAllBytes($outFile + ".bin", $bytes)
              $info += " -> BIN"
            }
          }
          Write-Output $info
        }
        $reader.Close()
      } catch {
        Write-Output ("  ResourceReader fail: " + $_)
      }
    }
  }
}

# Also dump unicode strings around site_but from SurfaceUC
Write-Output ""
Write-Output "==== site_but context strings in APM.SurfaceUC.dll ===="
$bytes = [IO.File]::ReadAllBytes((Join-Path $binDir "APM.SurfaceUC.dll"))
$uni = [Text.Encoding]::Unicode.GetString($bytes)
$ascii = [Text.Encoding]::ASCII.GetString($bytes)
foreach ($pat in @("site_but", "SiteBut", "vessel_but", "VesselBut", "icon_vessel", "images/")) {
  $idx = 0
  $count = 0
  while (($idx = $uni.IndexOf($pat, $idx)) -ge 0 -and $count -lt 20) {
    $start = [Math]::Max(0, $idx - 40)
    $len = [Math]::Min(120, $uni.Length - $start)
    $snip = $uni.Substring($start, $len) -replace "[^\x20-\x7E]", "."
    Write-Output ("UNI[$pat] $snip")
    $idx += $pat.Length
    $count++
  }
  $idx = 0
  $count = 0
  while (($idx = $ascii.IndexOf($pat, $idx)) -ge 0 -and $count -lt 20) {
    $start = [Math]::Max(0, $idx - 40)
    $len = [Math]::Min(120, $ascii.Length - $start)
    $snip = $ascii.Substring($start, $len) -replace "[^\x20-\x7E]", "."
    Write-Output ("ASC[$pat] $snip")
    $idx += $pat.Length
    $count++
  }
}
