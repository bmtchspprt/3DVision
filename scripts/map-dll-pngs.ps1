param(
  [string]$DllPath = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll",
  [string]$Dest = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\multivision"
)

function Find-PngAtOrAfter($bytes, $start, $maxSearch) {
  $endSearch = [Math]::Min($bytes.Length - 8, $start + $maxSearch)
  for ($k = $start; $k -lt $endSearch - 8; $k++) {
    if ($bytes[$k] -eq 0x89 -and $bytes[$k + 1] -eq 0x50 -and $bytes[$k + 2] -eq 0x4E -and $bytes[$k + 3] -eq 0x47) {
      $end = $k + 4
      while ($end -lt $bytes.Length - 8) {
        if ($bytes[$end] -eq 0x49 -and $bytes[$end + 1] -eq 0x45 -and $bytes[$end + 2] -eq 0x4E -and $bytes[$end + 3] -eq 0x44) {
          $end += 8
          break
        }
        $end++
      }
      $len = $end - $k
      if ($len -gt 80 -and $len -lt 500000) {
        return @{ Offset = $k; Length = $len; Bytes = $bytes[$k..($end - 1)] }
      }
    }
  }
  return $null
}

function Find-AllStringOffsets($bytes, $text, $enc) {
  $pattern = $enc.GetBytes($text)
  $hits = @()
  for ($i = 0; $i -lt $bytes.Length - $pattern.Length; $i++) {
    $match = $true
    for ($j = 0; $j -lt $pattern.Length; $j++) {
      if ($bytes[$i + $j] -ne $pattern[$j]) { $match = $false; break }
    }
    if ($match) { $hits += $i }
  }
  return $hits
}

$bytes = [IO.File]::ReadAllBytes($DllPath)
New-Item -ItemType Directory -Force -Path $Dest | Out-Null

# Discover png-related strings in DLL (ASCII + UTF-16)
$seen = @{}
$regex = [regex]'[A-Za-z0-9_\-]+\.png'
$asciiText = [Text.Encoding]::ASCII.GetString($bytes)
foreach ($m in $regex.Matches($asciiText)) {
  $seen[$m.Value] = $true
}
# UTF-16 scan for .png names
for ($i = 0; $i -lt $bytes.Length - 8; $i += 2) {
  if ($bytes[$i + 1] -eq 0 -and $bytes[$i] -ge 0x20 -and $bytes[$i] -le 0x7e) {
    $chars = New-Object System.Collections.Generic.List[char]
    $j = $i
    while ($j -lt $bytes.Length - 1) {
      if ($bytes[$j + 1] -ne 0) { break }
      $ch = [char]$bytes[$j]
      if ($ch -lt ' ' -or $ch -gt '~') { break }
      $chars.Add($ch)
      $j += 2
    }
    $s = -join $chars
    if ($s -match '\.png$' -and $s.Length -lt 80) { $seen[$s] = $true }
  }
}

$names = $seen.Keys | Sort-Object
Write-Output "Found $($names.Count) png name strings in DLL"

$report = @()
foreach ($name in $names) {
  $best = $null
  foreach ($enc in @([Text.Encoding]::Unicode, [Text.Encoding]::ASCII)) {
    $hits = Find-AllStringOffsets $bytes $name $enc
    foreach ($hit in $hits) {
      foreach ($dir in @(-1, 1)) {
        $searchStart = if ($dir -lt 0) { [Math]::Max(0, $hit - 200000) } else { $hit }
        $png = Find-PngAtOrAfter $bytes $searchStart 200000
        if ($png) {
          $dist = [Math]::Abs($png.Offset - $hit)
          if (-not $best -or $dist -lt $best.Distance) {
            $best = @{ Name = $name; Offset = $png.Offset; Length = $png.Length; Bytes = $png.Bytes; Distance = $dist; Encoding = $enc.EncodingName }
          }
        }
      }
    }
  }
  if ($best) {
    $out = Join-Path $Dest $best.Name
    [IO.File]::WriteAllBytes($out, $best.Bytes)
    $report += [pscustomobject]@{ Name = $best.Name; Offset = $best.Offset; Size = $best.Length; Distance = $best.Distance }
    Write-Output "OK $($best.Name) ($($best.Length) bytes)"
  } else {
    Write-Output "MISS $name"
  }
}

$report | Export-Csv (Join-Path $Dest "_extraction-report.csv") -NoTypeInformation
Write-Output "Report: $(Join-Path $Dest '_extraction-report.csv')"
