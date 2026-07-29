param(
  [string]$ResFile = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision\3DVisionGui.g.resources",
  [string]$Dest = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision"
)

function Read-StreamBytes($stream) {
  if ($null -eq $stream) { return $null }
  if ($stream -is [byte[]]) { return $stream }
  $ms = New-Object IO.MemoryStream
  if ($stream.CanSeek) { $stream.Position = 0 }
  $stream.CopyTo($ms)
  if ($stream -is [IDisposable] -and $stream.GetType().Name -match 'PinnedBuffer') {
    # leave stream open; WPF pinned buffer
  }
  return $ms.ToArray()
}

New-Item -ItemType Directory -Force -Path $Dest | Out-Null
$reader = New-Object System.Resources.ResourceReader($ResFile)
$enum = $reader.GetEnumerator()
$png = 0
$other = 0
while ($enum.MoveNext()) {
  $key = [string]$enum.Key
  $bytes = Read-StreamBytes $enum.Value
  if (-not $bytes -or $bytes.Length -lt 4) { continue }
  $isPng = ($bytes[0] -eq 0x89 -and $bytes[1] -eq 0x50)
  $isJpg = ($bytes[0] -eq 0xFF -and $bytes[1] -eq 0xD8)
  $isIco = ($bytes[0] -eq 0 -and $bytes[1] -eq 0 -and $bytes[2] -eq 1 -and $bytes[3] -eq 0)
  if (-not ($isPng -or $isJpg -or $isIco)) { continue }

  $fileName = Split-Path $key -Leaf
  if ($fileName -notmatch '\.(png|jpg|ico)$') {
    if ($isPng) { $fileName += '.png' }
    elseif ($isJpg) { $fileName += '.jpg' }
    else { $fileName += '.ico' }
  }
  $out = Join-Path $Dest $fileName
  [IO.File]::WriteAllBytes($out, $bytes)
  if ($isPng) { $png++ } else { $other++ }
  Write-Output "OK $key -> $fileName ($($bytes.Length) bytes)"
}
$reader.Close()
Write-Output "Saved $png PNG and $other other image files to $Dest"
