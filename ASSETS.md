# 3D Vision Assets Guide

This document summarizes where UI assets live in this emulator project and how to pull more from the installed BinMaster **3D Vision** client.

## Project asset folder

Copied and extracted assets used by the emulator:

```
3D Emulator/
  assets/
    images/
      bg_login.png           Sidebar background
      logo.png               General BinMaster logo
      logo_icon.ico          Window / title-bar icon
      logo_login.png         Login branding
      logoBinMaster.PNG      Red BinMaster logo (About dialog)
      imageHeaderBinMaster.PNG  Header strip logo variant
      apm_logo.png           APM Technology logo (About dialog)
      client_logo.png        Placeholder (not used in current UI)
```

Open `index.html` directly in a browser (`file://`). No local server is required.

## Installed 3D Vision source location

Default install path on this machine:

```
C:\Program Files (x86)\BinMaster 3DVision\
```

Most UI images for the connection launcher live here:

```
C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\ImagesBin\
```

| File | Typical use |
|------|-------------|
| `bg_login.png` | Sidebar background |
| `logo.png` | Branding |
| `logo_icon.ico` | Application icon |
| `logo_login.png` | Login / launcher branding |
| `logoBinMaster.PNG` | About / header logos |
| `imageHeaderBinMaster.PNG` | Header graphics |
| `imageLoginBinMaster.PNG` | Product photo splash |
| `WizardLogo.JPG` | Wizard / setup branding |

## Copy assets into this project

From PowerShell:

```powershell
$dest = "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images"
$src  = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\ImagesBin"
New-Item -ItemType Directory -Force -Path $dest | Out-Null
Copy-Item "$src\bg_login.png" $dest
Copy-Item "$src\logo.png" $dest
Copy-Item "$src\logo_icon.ico" $dest
Copy-Item "$src\logo_login.png" $dest
Copy-Item "$src\logoBinMaster.PNG" $dest
Copy-Item "$src\imageHeaderBinMaster.PNG" $dest
```

## Pull embedded images from binaries

Some images are not loose files. They are embedded in `.dll` / `.exe` resources.

Useful binaries:

| Binary | Path | Notes |
|--------|------|-------|
| `3DVisionGui.dll` | `binClient\bin\` | Many toolbar / UI icons |
| `3DVisionClient.exe` | `binClient\bin\` | Main client icons |
| `WPFStuffServer.dll` | `binClient\bin\` | Server / WPF UI assets |
| `Connection.dll` | `binClient\bin\` | Connection UI strings / logic |

### List image resource names in a DLL

```powershell
$path = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll"
$ascii = [Text.Encoding]::ASCII.GetString([IO.File]::ReadAllBytes($path))
[regex]::Matches($ascii, '[\w-]+\.(png|PNG|jpg|JPG|ico)') |
  ForEach-Object { $_.Value } |
  Sort-Object -Unique
```

### Extract embedded PNG files from a binary

```powershell
function Export-PngsFromBinary($inputPath, $outputDir) {
  New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
  $bytes = [IO.File]::ReadAllBytes($inputPath)
  $idx = 0
  $n = 0
  while ($idx -lt $bytes.Length - 8) {
    if ($bytes[$idx] -eq 0x89 -and $bytes[$idx+1] -eq 0x50 -and $bytes[$idx+2] -eq 0x4E -and $bytes[$idx+3] -eq 0x47) {
      $end = $idx + 4
      while ($end -lt $bytes.Length - 8) {
        if ($bytes[$end] -eq 0x49 -and $bytes[$end+1] -eq 0x45 -and $bytes[$end+2] -eq 0x4E -and $bytes[$end+3] -eq 0x44) {
          $end += 8
          break
        }
        $end++
      }
      $len = $end - $idx
      if ($len -gt 500 -and $len -lt 500000) {
        $n++
        $name = [IO.Path]::GetFileNameWithoutExtension($inputPath) + "_$n.png"
        [IO.File]::WriteAllBytes((Join-Path $outputDir $name), $bytes[$idx..($end - 1)])
      }
      $idx = $end
    } else {
      $idx++
    }
  }
  Write-Output "Extracted $n PNG(s) from $inputPath"
}

Export-PngsFromBinary `
  "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionGui.dll" `
  "C:\Users\cody.krehnke\Documents\3D Emulator\assets\images\extracted"
```

The **APM Technology** logo used in the About dialog was extracted from `3DVisionGui.dll` (resource PNG with green concentric circles and “APM TECHNOLOGY” text).

## UI strings and layout research

Helpful places to inspect real UI text and behavior:

```
binClient\bin\Connection.dll      Connection / launcher UI
binClient\bin\3DVisionGui.dll     Main GUI controls
binClient\bin\WPFStuffServer.dll  Server-side WPF UI
binClient\Config\                 XML configuration
```

Extract readable strings:

```powershell
$bytes = [IO.File]::ReadAllBytes("C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\Connection.dll")
$text = [Text.Encoding]::Unicode.GetString($bytes)
[regex]::Matches($text, 'Device Configuration|Advanced Connection|Operational Manual|About 3D Vision') |
  ForEach-Object { $_.Value } |
  Sort-Object -Unique
```

Run the real client and use UI Automation to measure control positions when pixel-matching layouts:

```
C:\Program Files (x86)\BinMaster 3DVision\binClient\bin\3DVisionClient.exe
```

## Help menu behavior in this emulator

| Menu item | Current behavior |
|-----------|------------------|
| **Operational Manual** | Opens `http://www.binmaster.com/` in a new browser tab. The installed client may point to a local PDF/CHM instead; if you locate that file on disk, update `OPERATIONAL_MANUAL_URL` in `js/app.js`. |
| **About** | Opens the About 3D Vision dialog using `logoBinMaster.PNG` and `apm_logo.png`. |

## Version info

The About dialog shows **Version 3.1.010** to match the reference launcher UI. Installed binary metadata may differ (for example `3DVisionClient.exe` may report `3.0.020.0` via File Properties). Use the reference screenshot / real About box as the source of truth when emulating.

## Continuing development

1. Run the real **3D Vision Server Connection** window and capture screenshots.
2. Copy any missing files from `ImagesBin\`.
3. If an image is missing as a file, extract PNGs from the relevant `.dll` / `.exe`.
4. Place final assets in `assets/images/` and reference them from `index.html` or `css/styles.css`.
5. Keep this emulator static: open `index.html` locally without a dev server unless you later add one intentionally.

## 3D MultiVision (main client home screen)

MultiVision is a **WPF** app (`3DVisionGui.dll`). Most of its UI is not loose PNG files — icons and graphics are embedded resources inside the DLL.

### What you need for a pixel-identical home screen

| Need | Source | How to get it |
|------|--------|---------------|
| Toolbar icons | `3DVisionGui.dll` → `3DVisionGui.g.resources` | `icon_distance.png`, `icon_connect.png`, `icon_disconnect.png`, `icon_load_from_scanner.png`, `icon_wizard.png` |
| Status LEDs | `3DVisionGui.dll` | `led_small_green.png`, `led_small_gray.png`, `led_small_red.png` |
| Header / branding | `ImagesBin\` or DLL | `imageHeaderBinMaster.PNG`, `logoBinMaster.PNG` |
| Aggregates nav graphic | `imageLoginBinMaster.PNG` in `ImagesBin\` | Already copied to `assets/images/multivision/aggregates-nav.png` |
| Vessel silo graphics | WPF XAML in DLL | Measure from running app or screenshot overlay |
| Layout metrics | Running `3DVisionClient.exe` | UI Automation (`Inspect.exe`) or screenshot with pixel ruler at 100% DPI |
| Colors / fonts | Running app | Tahoma 11px, header `#000`, toolbar blue gradient, body `#e3e8ee` |
| Reference screenshot | Your desktop | Full window at native size — use as visual diff target |

### Extract named toolbar icons from `3DVisionGui.dll`

Resource names found in the binary (save into `assets/images/multivision/`):

```
icon_connect.png
icon_disconnect.png
icon_distance.png
icon_load_from_scanner.png
icon_wizard.png
led_small_green.png
icon_level.png
3dsurface32.png
```

Run `scripts/extract-multivision-assets.ps1` with **32-bit PowerShell** (`SysWOW64\WindowsPowerShell\v1.0\powershell.exe`) so the x86 `3DVisionGui.dll` loads. The script reads `images/*` entries from `3DVisionGui.g.resources` and writes named PNGs into `assets/images/multivision/`.

### Recommended workflow for matching the real UI

1. Connect with `stech` / `techS` on the real installed client.
2. Screenshot MultiVision at **100% display scaling** (no browser zoom).
3. Export all icons from `3DVisionGui.dll` into `assets/images/multivision/`.
4. Overlay screenshot on the emulator in browser devtools and adjust CSS until panels align.
5. Use UI Automation to read exact control bounds for header height, toolbar, and vessel panel grid.
