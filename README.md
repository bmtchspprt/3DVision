# 3D MultiVision Install Guide

Fork of the 3D Emulator remake, focused on a guided first-time install.

**Do not confuse with** `Documents/3D Emulator` — that project is untouched.

## What this fork teaches

1. Open Browser to `https://support.binmaster.com/downloads` and click **3D LevelScanner Software**
2. Open Downloads / File Manager and run the installer
3. Run Setup: **Custom install** → **Service** → Browse → **Make New Folder** creates `C:\BinMaster` → leave Program Files (x86) → Finish
4. Use **Advanced Connection**, sign in `stech` / `techS`
5. On the Start page, choose **New Project**

## Run it (source)

Open `index.html` in a browser (same as the Emulator remake).

## Build obfuscated distribution

Produces a single self-contained HTML (assets embedded, JS obfuscated) in `dist/`:

```bash
npm install
npm run build
```

Upload `dist/index.html` (or the whole `dist/` folder) to GitHub / GitHub Pages. Do **not** upload the source `js/`, `css/`, or `assets/` tree if you want the guide harder to reverse-engineer.
