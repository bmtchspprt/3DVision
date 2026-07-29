$ErrorActionPreference = "Continue"
$dll = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll"
$out = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\_deep_hunt\baml"
New-Item -ItemType Directory -Force -Path $out | Out-Null
$asm = [Reflection.Assembly]::LoadFrom($dll)
$resName = $asm.GetManifestResourceNames() | Where-Object { $_ -like "*.g.resources" } | Select-Object -First 1
$stream = $asm.GetManifestResourceStream($resName)
$tmp = Join-Path $out "gui.g.resources"
$fs = [IO.File]::Create($tmp); $stream.CopyTo($fs); $fs.Close(); $stream.Close()
$reader = New-Object System.Resources.ResourceReader($tmp)
$enum = $reader.GetEnumerator()
$bamlKeys = @()
while ($enum.MoveNext()) {
  $key = [string]$enum.Key
  if ($key -match "baml") {
    $val = $enum.Value
    $ms = New-Object IO.MemoryStream
    if ($val.CanSeek) { $val.Position = 0 }
    $val.CopyTo($ms)
    $bytes = $ms.ToArray()
    $safe = ($key -replace "[^a-zA-Z0-9_.-]", "_")
    if ($safe.Length -gt 90) { $safe = $safe.Substring(0,90) }
    [IO.File]::WriteAllBytes((Join-Path $out ($safe + ".baml")), $bytes)
    $bamlKeys += $key
  }
}
$reader.Close()
Write-Output ("BAML count: " + $bamlKeys.Count)
$bamlKeys | Where-Object { $_ -match "vessel|site|main|home|overview|list|tab|simple" } | Sort-Object

Write-Output ""
Write-Output "=== Search BAML unicode for site_but / ImageSource / vessel icon ==="
Get-ChildItem $out -Filter "*.baml" | ForEach-Object {
  $bytes = [IO.File]::ReadAllBytes($_.FullName)
  $uni = [Text.Encoding]::Unicode.GetString($bytes)
  $ascii = [Text.Encoding]::ASCII.GetString($bytes)
  $hits = @()
  foreach ($pat in @("site_but", "icon_level", "led_small", "ImageSource", "pack://", "images/")) {
    if ($uni.Contains($pat) -or $ascii.Contains($pat)) { $hits += $pat }
  }
  if ($hits.Count) {
    Write-Output ("$($_.Name): " + ($hits -join ", "))
    # show nearby strings for site_but
    if ($uni.Contains("site_but") -or $ascii.Contains("site_but")) {
      $idx = $uni.IndexOf("site_but")
      if ($idx -lt 0) { $idx = 0 }
      else {
        $s = [Math]::Max(0,$idx-60); $e = [Math]::Min($uni.Length, $idx+80)
        Write-Output ("  UNI: " + ($uni.Substring($s,$e-$s) -replace "[^\x20-\x7E]", "."))
      }
    }
  }
}
