Add-Type -AssemblyName System.Drawing

$realPath = "C:\Users\cody.krehnke\.cursor\projects\c-Users-cody-krehnke-Documents-3D-Emulator\assets\c__Users_cody.krehnke_AppData_Roaming_Cursor_User_workspaceStorage_c18693dd6ebe325de398c56d6e132002_images_image-466b7f33-801e-4866-8147-b28e1063008f.png"
$minePath = "C:\Users\cody.krehnke\.cursor\projects\c-Users-cody-krehnke-Documents-3D-Emulator\assets\c__Users_cody.krehnke_AppData_Roaming_Cursor_User_workspaceStorage_c18693dd6ebe325de398c56d6e132002_images_image-2a5bf197-9db7-4b12-8601-75c9fe177956.png"

function Find-SiloBounds([System.Drawing.Bitmap]$bmp) {
  $xs = New-Object System.Collections.Generic.List[int]
  $ys = New-Object System.Collections.Generic.List[int]
  $maxX = [int]($bmp.Width * 0.55)
  for ($y = 15; $y -lt $bmp.Height - 3; $y++) {
    for ($x = 3; $x -lt $maxX; $x++) {
      $p = $bmp.GetPixel($x, $y)
      $isDark = ($p.R -lt 90 -and $p.G -lt 90 -and $p.B -lt 90)
      $isBrown = ($p.R -gt 95 -and $p.R -gt $p.G -and $p.G -gt 35 -and $p.B -lt 130 -and (($p.R - $p.B) -gt 25))
      $isShell = ($p.R -gt 210 -and $p.G -gt 210 -and $p.B -gt 210)
      if ($isDark -or $isBrown -or ($isShell -and $x -gt 20 -and $x -lt ($maxX - 20))) {
        [void]$xs.Add($x)
        [void]$ys.Add($y)
      }
    }
  }
  if ($xs.Count -eq 0) { return $null }
  $L = ($xs | Measure-Object -Minimum).Minimum
  $R = ($xs | Measure-Object -Maximum).Maximum
  $T = ($ys | Measure-Object -Minimum).Minimum
  $B = ($ys | Measure-Object -Maximum).Maximum
  return [pscustomobject]@{ L = $L; R = $R; T = $T; B = $B; W = ($R - $L + 1); H = ($B - $T + 1) }
}

function Find-ColorBand([System.Drawing.Bitmap]$bmp, [scriptblock]$pred, [double]$maxXFrac = 0.55) {
  $ys = New-Object System.Collections.Generic.List[int]
  $xs = New-Object System.Collections.Generic.List[int]
  $maxX = [int]($bmp.Width * $maxXFrac)
  for ($y = 0; $y -lt $bmp.Height; $y++) {
    for ($x = 0; $x -lt $maxX; $x++) {
      $p = $bmp.GetPixel($x, $y)
      if (& $pred $p) {
        [void]$ys.Add($y)
        [void]$xs.Add($x)
      }
    }
  }
  if ($ys.Count -eq 0) { return $null }
  return [pscustomobject]@{
    yMin = ($ys | Measure-Object -Minimum).Minimum
    yMax = ($ys | Measure-Object -Maximum).Maximum
    xMin = ($xs | Measure-Object -Minimum).Minimum
    xMax = ($xs | Measure-Object -Maximum).Maximum
  }
}

function Analyze([string]$name, [string]$path) {
  $bmp = [System.Drawing.Bitmap]::FromFile($path)
  Write-Output ("==== {0} {1}x{2} ====" -f $name, $bmp.Width, $bmp.Height)
  $b = Find-SiloBounds $bmp
  if ($b) {
    Write-Output ("silo L={0} R={1} T={2} B={3} size={4}x{5} aspect={6:N3}" -f $b.L, $b.R, $b.T, $b.B, $b.W, $b.H, ($b.W / $b.H))
    Write-Output ("silo left%={0:N1} width%={1:N1} top%={2:N1} height%={3:N1}" -f (100.0 * $b.L / $bmp.Width), (100.0 * $b.W / $bmp.Width), (100.0 * $b.T / $bmp.Height), (100.0 * $b.H / $bmp.Height))
  }
  $red = Find-ColorBand $bmp { param($p) $p.R -gt 180 -and $p.G -lt 90 -and $p.B -lt 90 }
  if ($red) {
    Write-Output ("red F y={0}..{1} x={2}..{3} (y% of card={4:N1}-{5:N1})" -f $red.yMin, $red.yMax, $red.xMin, $red.xMax, (100.0 * $red.yMin / $bmp.Height), (100.0 * $red.yMax / $bmp.Height))
    if ($b) {
      Write-Output ("red relative to silo top: {0}px ({1:N1}% of silo H)" -f ($red.yMin - $b.T), (100.0 * ($red.yMin - $b.T) / $b.H))
    }
  }
  $orange = Find-ColorBand $bmp { param($p) $p.R -gt 170 -and $p.G -gt 70 -and $p.G -lt 210 -and $p.B -lt 90 }
  if ($orange) {
    Write-Output ("orange E y={0}..{1}" -f $orange.yMin, $orange.yMax)
    if ($b) {
      Write-Output ("orange relative to silo bottom: {0}px" -f ($b.B - $orange.yMax))
    }
  }

  # Sample body width at mid-cylinder and near tip to get hopper bluntness
  if ($b) {
    $midY = [int](($b.T + $b.B) * 0.45)
    $nearTipY = [int]($b.B - ($b.H * 0.08))
    $hopperStartProbe = @()
    foreach ($probeY in @($midY, $nearTipY, ($b.B - 2))) {
      $leftEdge = $null; $rightEdge = $null
      for ($x = $b.L; $x -le $b.R; $x++) {
        $p = $bmp.GetPixel($x, $probeY)
        $hit = ($p.R -lt 100 -and $p.G -lt 100 -and $p.B -lt 100) -or ($p.R -gt 95 -and $p.R -gt $p.G -and (($p.R - $p.B) -gt 25))
        if ($hit) {
          if ($null -eq $leftEdge) { $leftEdge = $x }
          $rightEdge = $x
        }
      }
      if ($null -ne $leftEdge) {
        Write-Output ("width at y={0}: {1}px (x={2}..{3})" -f $probeY, ($rightEdge - $leftEdge + 1), $leftEdge, $rightEdge)
      }
    }

    # Find where hopper starts: first y from bottom where width >= 90% of mid width
    $midLeft = $null; $midRight = $null
    for ($x = $b.L; $x -le $b.R; $x++) {
      $p = $bmp.GetPixel($x, $midY)
      $hit = ($p.R -lt 100 -and $p.G -lt 100 -and $p.B -lt 100) -or ($p.R -gt 95 -and $p.R -gt $p.G -and (($p.R - $p.B) -gt 25))
      if ($hit) {
        if ($null -eq $midLeft) { $midLeft = $x }
        $midRight = $x
      }
    }
    $midW = $midRight - $midLeft + 1
    $hopperY = $null
    for ($y = $b.B; $y -ge $b.T; $y--) {
      $l = $null; $r = $null
      for ($x = $b.L; $x -le $b.R; $x++) {
        $p = $bmp.GetPixel($x, $y)
        $hit = ($p.R -lt 100 -and $p.G -lt 100 -and $p.B -lt 100) -or ($p.R -gt 95 -and $p.R -gt $p.G -and (($p.R - $p.B) -gt 25))
        if ($hit) {
          if ($null -eq $l) { $l = $x }
          $r = $x
        }
      }
      if ($null -ne $l) {
        $w = $r - $l + 1
        if ($w -ge ($midW * 0.92)) { $hopperY = $y; break }
      }
    }
    if ($null -ne $hopperY) {
      $hopperH = $b.B - $hopperY
      Write-Output ("hopper start y={0} hopperH={1}px ({2:N1}% of silo)" -f $hopperY, $hopperH, (100.0 * $hopperH / $b.H))
      # tip width
      $tipL = $null; $tipR = $null
      for ($x = $b.L; $x -le $b.R; $x++) {
        $p = $bmp.GetPixel($x, $b.B)
        $hit = ($p.R -lt 100 -and $p.G -lt 100 -and $p.B -lt 100) -or ($p.R -gt 95 -and $p.R -gt $p.G -and (($p.R - $p.B) -gt 25)) -or ($p.R -gt 170 -and $p.G -gt 70 -and $p.B -lt 100)
        if ($hit) {
          if ($null -eq $tipL) { $tipL = $x }
          $tipR = $x
        }
      }
      if ($null -ne $tipL) {
        Write-Output ("tip width at bottom={0}px (x={1}..{2}) tip/body={3:N2}" -f ($tipR - $tipL + 1), $tipL, $tipR, (($tipR - $tipL + 1) / $midW))
      }
    }
  }
  $bmp.Dispose()
}

Analyze "REAL" $realPath
Analyze "MINE" $minePath
