$dir = "c:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision"
Get-ChildItem $dir -File | Where-Object { $_.Length -eq 19497 -or $_.Name -match '^[/\\]' -or $_.Name -eq '.png' -or $_.Name -eq '_add.png' } | ForEach-Object { $_.FullName }
