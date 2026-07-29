$ErrorActionPreference = "Continue"
Add-Type -AssemblyName System.Drawing

$bin = "C:\Program Files (x86)\BinMaster 3DVision"
$out = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\_deep_hunt"
New-Item -ItemType Directory -Force -Path $out | Out-Null

Write-Output "=== Loose image files under BinMaster ==="
Get-ChildItem $bin -Recurse -Include *.png,*.jpg,*.jpeg,*.bmp,*.gif,*.ico,*.tif -ErrorAction SilentlyContinue |
  ForEach-Object {
    try {
      $img = [System.Drawing.Image]::FromFile($_.FullName)
      $rel = $_.FullName.Substring($bin.Length)
      "{0} | {1}x{2} | {3} bytes" -f $rel, $img.Width, $img.Height, $_.Length
      # Copy small vessel-like candidates
      if ($img.Width -le 64 -and $img.Height -le 64 -and $img.Height -ge $img.Width * 0.8) {
        $safe = ($rel -replace "[^a-zA-Z0-9_.-]", "_")
        if ($safe.Length -gt 90) { $safe = $safe.Substring($safe.Length - 90) }
        Copy-Item $_.FullName (Join-Path $out $safe) -Force
      }
      $img.Dispose()
    } catch {}
  }

Write-Output ""
Write-Output "=== String hits for site_but / vessel icon names in DLLs ==="
$needles = @(
  "site_but", "site_but_image", "icon_level", "icon_vessel", "vessel",
  "silo", "FillAndDraw", "VesselShape", "images/"
)
Get-ChildItem "$bin\binClient\bin" -Filter "*.dll" -ErrorAction SilentlyContinue | ForEach-Object {
  $bytes = [IO.File]::ReadAllBytes($_.FullName)
  $textAscii = [Text.Encoding]::ASCII.GetString($bytes)
  $textUni = [Text.Encoding]::Unicode.GetString($bytes)
  foreach ($n in $needles) {
    if ($textAscii.Contains($n) -or $textUni.Contains($n)) {
      "HIT $($_.Name) :: $n"
    }
  }
}
