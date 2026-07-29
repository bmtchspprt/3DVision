$dir = "c:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision"
$patterns = @('*.resources', '_staging', 'extracted', '.png', '_*.png', 'add.png', 'ain.png')
foreach ($pat in $patterns) {
  Get-ChildItem $dir -Recurse -Force -Filter $pat -ErrorAction SilentlyContinue | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}
Get-ChildItem $dir -File | Where-Object { $_.Length -eq 19497 } | Remove-Item -Force
Write-Output "Cleanup done"
