param(
  [string]$DllPath = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll",
  [string]$ImagesBin = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\ImagesBin",
  [string]$Dest = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision"
)

$ErrorActionPreference = "Stop"
New-Item -ItemType Directory -Force -Path $Dest | Out-Null

function Read-StreamBytes($stream) {
  if ($null -eq $stream) { return $null }
  if ($stream -is [byte[]]) { return $stream }
  $ms = New-Object IO.MemoryStream
  if ($stream.CanSeek) { $stream.Position = 0 }
  $stream.CopyTo($ms)
  return $ms.ToArray()
}

if (Test-Path $ImagesBin) {
  Copy-Item (Join-Path $ImagesBin "logoBinMaster.PNG") (Join-Path $Dest "binmaster-header.png") -Force
  Copy-Item (Join-Path $ImagesBin "imageHeaderBinMaster.PNG") (Join-Path $Dest "image-header-binmaster.png") -Force
  Copy-Item (Join-Path $ImagesBin "imageLoginBinMaster.PNG") (Join-Path $Dest "aggregates-nav.png") -Force
  Copy-Item (Join-Path $ImagesBin "logo_icon.ico") (Join-Path $Dest "logo_icon.ico") -Force
}

if (-not (Test-Path $DllPath)) {
  Write-Error "DLL not found: $DllPath"
}

$asm = [Reflection.Assembly]::LoadFrom($DllPath)
$resName = $asm.GetManifestResourceNames() | Where-Object { $_ -like "*.g.resources" } | Select-Object -First 1
if (-not $resName) {
  Write-Error "No .g.resources manifest found in $DllPath"
}

$stream = $asm.GetManifestResourceStream($resName)
$tempRes = Join-Path $Dest "3DVisionGui.g.resources"
$fs = [IO.File]::Create($tempRes)
$stream.CopyTo($fs)
$fs.Close()
$stream.Close()

$reader = New-Object System.Resources.ResourceReader($tempRes)
$enum = $reader.GetEnumerator()
$png = 0
while ($enum.MoveNext()) {
  $key = [string]$enum.Key
  if ($key -notmatch '^images/') { continue }
  $bytes = Read-StreamBytes $enum.Value
  if (-not $bytes -or $bytes.Length -lt 8) { continue }
  if ($bytes[0] -ne 0x89 -or $bytes[1] -ne 0x50) { continue }
  $fileName = Split-Path $key -Leaf
  $out = Join-Path $Dest $fileName
  [IO.File]::WriteAllBytes($out, $bytes)
  $png++
  Write-Output "OK $fileName"
}
$reader.Close()
Write-Output "Extracted $png toolbar/UI PNG files to $Dest"
