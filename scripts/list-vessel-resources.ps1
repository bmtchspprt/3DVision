param(
  [string]$ResFile = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\3DVisionGui.g.resources",
  [string]$DllPath = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll"
)

# List all image-like keys and any vessel/silo related names
if (-not (Test-Path $ResFile)) {
  $asm = [Reflection.Assembly]::LoadFrom($DllPath)
  $resName = $asm.GetManifestResourceNames() | Where-Object { $_ -like "*.g.resources" } | Select-Object -First 1
  $stream = $asm.GetManifestResourceStream($resName)
  $ResFile = Join-Path $env:TEMP "3DVisionGui.g.resources"
  $fs = [IO.File]::Create($ResFile)
  $stream.CopyTo($fs)
  $fs.Close()
  $stream.Close()
}

$reader = New-Object System.Resources.ResourceReader($ResFile)
$enum = $reader.GetEnumerator()
while ($enum.MoveNext()) {
  $key = [string]$enum.Key
  if ($key -match 'image|png|jpg|silo|vessel|level|surface|cone|cylin|bin|tank|fill|3d|gauge|site|scanner') {
    Write-Output $key
  }
}
$reader.Close()
