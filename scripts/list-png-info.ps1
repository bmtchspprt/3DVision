param([string]$Dir = "c:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\_staging")
Add-Type -AssemblyName System.Drawing
Get-ChildItem (Join-Path $Dir "*.png") | Sort-Object { [int]($_.BaseName -replace '\D','') } | ForEach-Object {
  $img = [Drawing.Image]::FromFile($_.FullName)
  $w = $img.Width
  $h = $img.Height
  $img.Dispose()
  Write-Output ("{0,-12} {1,6} bytes  {2}x{3}" -f $_.Name, $_.Length, $w, $h)
}
