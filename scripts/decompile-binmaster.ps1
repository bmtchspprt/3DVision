<#
.SYNOPSIS
  Decompile first-party BinMaster 3D Vision .NET assemblies with ilspycmd.

.DESCRIPTION
  Writes C# projects under decompiled/client and decompiled/server.
  Skips known third-party libraries, *.vshost.exe, and native DLLs.
  Requires: dotnet tool install -g ilspycmd
#>
param(
  [string]$ClientBin = "C:\Program Files (x86)\BinMaster 3DVision\binClient\bin",
  [string]$ServerBin = "C:\Program Files (x86)\BinMaster 3DVision\binServer\bin",
  [string]$OutRoot = (Join-Path (Split-Path $PSScriptRoot -Parent) "decompiled"),
  [switch]$Clean
)

$ErrorActionPreference = "Continue"

if (-not (Get-Command ilspycmd -ErrorAction SilentlyContinue)) {
  throw "ilspycmd not found. Install with: dotnet tool install -g ilspycmd"
}

$toolVersion = (ilspycmd -v 2>&1 | Select-Object -First 1).ToString().Trim()

$skip = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
@(
  "AWSSDK.dll", "Ionic.Zip.dll", "itextsharp.dll", "OpenPop.dll",
  "SciChart.Charting.dll", "SciChart.Core.dll", "SciChart.Data.dll",
  "SciChart.Drawing.dll", "SciChart.Drawing.DirectX.dll",
  "SharpDX.dll", "SharpDX.D3DCompiler.dll", "SharpDX.Direct3D10.dll",
  "SharpDX.Direct3D9.dll", "SharpDX.DXGI.dll",
  "TeeChart.dll", "TeeChart.Languages.dll", "TeeChart.WPF.dll",
  "WPFToolkit.dll", "System.Windows.Controls.DataVisualization.Toolkit.dll",
  "Microsoft.VisualStudio.OLE.Interop.dll",
  "Interop.AxTeeChart8.dll", "Interop.ConicSynth.dll",
  "ConicSynthCPP.dll", "NNAlgoCpp.dll",
  "CodeVendor.Controls.dll", "FortuneVoronoi.dll", "Lzma#.dll",
  "wrapper.exe"  # native Java Service Wrapper, not managed
) | ForEach-Object { [void]$skip.Add($_) }

function Test-IsDotNetAssembly([string]$path) {
  try {
    $bytes = [IO.File]::ReadAllBytes($path)
    if ($bytes.Length -lt 64) { return $false }
    # Require CLR metadata root ("BSJB"); "mscoree.dll" alone can appear in native wrappers.
    $ascii = [Text.Encoding]::ASCII.GetString($bytes)
    return $ascii.Contains("BSJB")
  } catch {
    return $false
  }
}

function Invoke-DecompileTree([string]$srcDir, [string]$outRoot) {
  if (-not (Test-Path $srcDir)) {
    Write-Warning "Missing source dir: $srcDir"
    return [PSCustomObject]@{ Ok = 0; Fail = 0; SkipNative = 0; SkipThirdParty = 0; Candidates = 0 }
  }

  New-Item -ItemType Directory -Force -Path $outRoot | Out-Null
  $files = Get-ChildItem $srcDir -File | Where-Object {
    $_.Extension -match "^\.(dll|exe)$" -and $_.Name -notmatch "\.vshost\.exe$"
  }

  $ok = 0; $fail = 0; $skipNative = 0; $skipThird = 0
  $results = @()

  foreach ($f in $files) {
    if ($skip.Contains($f.Name)) {
      $skipThird++
      continue
    }
    if (-not (Test-IsDotNetAssembly $f.FullName)) {
      Write-Host "SKIP-NATIVE $($f.Name)"
      $skipNative++
      $results += [PSCustomObject]@{ Assembly = $f.Name; Status = "skip-native" }
      continue
    }

    $out = Join-Path $outRoot $f.BaseName
    if (Test-Path $out) { Remove-Item -Recurse -Force $out }
    New-Item -ItemType Directory -Force -Path $out | Out-Null
    Write-Host "DECOMP $($f.Name)"

    $pdbBeside = [IO.Path]::ChangeExtension($f.FullName, ".pdb")
    $argList = @(
      "-p",
      "-o", $out,
      "--nested-directories",
      "--decompile-baml",
      "--disable-updatecheck",
      "-r", $srcDir
    )
    if (Test-Path $pdbBeside) {
      $argList += "--use-varnames-from-pdb"
    }
    $argList += $f.FullName

    $prevEap = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    $log = & ilspycmd @argList 2>&1 | ForEach-Object { "$_" } | Out-String
    $code = $LASTEXITCODE
    $ErrorActionPreference = $prevEap

    $csCount = @(Get-ChildItem $out -Recurse -Filter *.cs -File -ErrorAction SilentlyContinue).Count
    $xamlCount = @(Get-ChildItem $out -Recurse -Filter *.xaml -File -ErrorAction SilentlyContinue).Count
    if ($code -eq 0 -and $csCount -gt 0) {
      $ok++
      @"
Source: $($f.FullName)
SizeBytes: $($f.Length)
HasPdb: $(Test-Path $pdbBeside)
DecompiledUtc: $([DateTime]::UtcNow.ToString('o'))
Tool: $toolVersion
CsFiles: $csCount
XamlFiles: $xamlCount
"@ | Set-Content -Encoding UTF8 (Join-Path $out "_SOURCE.txt")
      $results += [PSCustomObject]@{ Assembly = $f.Name; Status = "ok"; Cs = $csCount; Xaml = $xamlCount }
    } else {
      $fail++
      Write-Warning "FAIL $($f.Name) exit=$code"
      ("exit=$code`n$log") | Set-Content -Encoding UTF8 (Join-Path $out "_FAILED.txt")
      $results += [PSCustomObject]@{ Assembly = $f.Name; Status = "fail"; Cs = $csCount; Xaml = $xamlCount }
    }
  }

  $results | Export-Csv -NoTypeInformation -Encoding UTF8 (Join-Path $outRoot "_manifest.csv")
  [PSCustomObject]@{
    Ok = $ok
    Fail = $fail
    SkipNative = $skipNative
    SkipThirdParty = $skipThird
    Candidates = $files.Count
  }
}

if ($Clean -and (Test-Path $OutRoot)) {
  Write-Host "Cleaning $OutRoot"
  Remove-Item -Recurse -Force $OutRoot
}

New-Item -ItemType Directory -Force -Path $OutRoot | Out-Null

Write-Host "=== CLIENT ($ClientBin) ==="
$r1 = Invoke-DecompileTree $ClientBin (Join-Path $OutRoot "client")
$r1 | Format-List

Write-Host "=== SERVER ($ServerBin) ==="
$r2 = Invoke-DecompileTree $ServerBin (Join-Path $OutRoot "server")
$r2 | Format-List

@"
# BinMaster 3D Vision decompilation

Generated by ``scripts/decompile-binmaster.ps1`` using **ilspycmd** (ICSharpCode.Decompiler).

## Layout

- ``client/`` — assemblies from ``binClient\bin``
- ``server/`` — assemblies from ``binServer\bin``
- Each assembly folder is an ILSpy project (``.csproj`` + one ``.cs`` per type)
- WPF BAML resources are converted to ``.xaml`` where possible (``--decompile-baml``)
- Variable names from sidecars ``.pdb`` are used when present (``--use-varnames-from-pdb``)

## Not included

Third-party / vendor libraries (SharpDX, SciChart, TeeChart, AWSSDK, Ionic.Zip, itextsharp, OpenPop, WPFToolkit, Interop stubs) and native DLLs (``ConicSynthCPP``, ``NNAlgoCpp``).

## Refresh

``````powershell
dotnet tool install -g ilspycmd   # once
.\scripts\decompile-binmaster.ps1 -Clean
``````

## Notes

- Output is reconstructed C#, not original source. Expect compiler-generated names, missing comments, and imperfect control flow in places.
- Projects are for reading / navigation; they are not guaranteed to rebuild into the original product.
- Client and server share many assembly names; both trees are kept so differences are visible.

GeneratedUtc: $([DateTime]::UtcNow.ToString('o'))
Client: Ok=$($r1.Ok) Fail=$($r1.Fail) SkipNative=$($r1.SkipNative) SkipThirdParty=$($r1.SkipThirdParty)
Server: Ok=$($r2.Ok) Fail=$($r2.Fail) SkipNative=$($r2.SkipNative) SkipThirdParty=$($r2.SkipThirdParty)
"@ | Set-Content -Encoding UTF8 (Join-Path $OutRoot "README.md")

Write-Host "Done. Output: $OutRoot"
