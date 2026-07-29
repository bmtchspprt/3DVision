param(
  [string]$DllPath = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll",
  [string]$Dest = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\icon_distance.png"
)

function Read-StreamBytes($stream) {
  $ms = New-Object IO.MemoryStream
  if ($stream.CanSeek) { $stream.Position = 0 }
  $stream.CopyTo($ms)
  return $ms.ToArray()
}

$asm = [Reflection.Assembly]::LoadFrom($DllPath)
$resName = $asm.GetManifestResourceNames() | Where-Object { $_ -like "*.g.resources" } | Select-Object -First 1
$stream = $asm.GetManifestResourceStream($resName)
$tmp = Join-Path $env:TEMP "mv_dist.g.resources"
$fs = [IO.File]::Create($tmp)
$stream.CopyTo($fs)
$fs.Close()
$stream.Close()

$reader = New-Object System.Resources.ResourceReader($tmp)
$enum = $reader.GetEnumerator()
$found = $false
while ($enum.MoveNext()) {
  $key = [string]$enum.Key
  if ($key -eq "images/icon_distance.png") {
    $bytes = Read-StreamBytes $enum.Value
    [IO.File]::WriteAllBytes($Dest, $bytes)
    Write-Output "OK images/icon_distance.png -> $Dest ($($bytes.Length) bytes)"
    $found = $true
  }
}
$reader.Close()
if (-not $found) { Write-Output "MISS icon_distance.png" }

Add-Type -AssemblyName System.Drawing
$img = [Drawing.Image]::FromFile($Dest)
Write-Output ("size {0}x{1}" -f $img.Width, $img.Height)
$img.Dispose()
