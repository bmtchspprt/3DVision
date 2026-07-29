param(
  [string]$DllPath = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll",
  [string]$Dest = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision"
)

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName PresentationCore

New-Item -ItemType Directory -Force -Path $Dest | Out-Null
$asm = [Reflection.Assembly]::LoadFrom($DllPath)
$names = $asm.GetManifestResourceNames() | Sort-Object
Write-Output "Manifest resources: $($names.Count)"
foreach ($resName in $names) {
  Write-Output $resName
  $stream = $asm.GetManifestResourceStream($resName)
  if (-not $stream) { continue }
  $out = Join-Path $Dest ($resName -replace '[\\/:*?"<>|]', '_')
  $fs = [IO.File]::Create($out)
  $stream.CopyTo($fs)
  $fs.Close()
  $stream.Close()
}
