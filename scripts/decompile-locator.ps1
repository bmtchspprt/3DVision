<#
.SYNOPSIS
  Maximum-fidelity decompile of 3D Solids Scanner Locator (ilspycmd).

.DESCRIPTION
  - Decompiles all first-party + placement-relevant managed assemblies (incl. C++/CLI NNAlgoCPP, FortuneVoronoi)
  - Fidelity-oriented ILSpy settings (no dead-code removal)
  - Copies install binaries for exact-reuse path
  - Dumps IL for placement-critical assemblies
  - Generates PDBs, type inventories, resource lists
  - Builds a placement-focused Visual Studio solution
  Requires: dotnet tool install -g ilspycmd
#>
param(
  [string]$LocatorBin = "C:\Program Files (x86)\3D Solids Scanner Locator",
  [string]$OutRoot = (Join-Path (Split-Path $PSScriptRoot -Parent) "decompiled\locator"),
  [switch]$Clean
)

$ErrorActionPreference = "Continue"

if (-not (Get-Command ilspycmd -ErrorAction SilentlyContinue)) {
  throw "ilspycmd not found. Install with: dotnet tool install -g ilspycmd"
}

$toolVersion = (ilspycmd -v 2>&1 | Select-Object -First 1).ToString().Trim()

# Only skip pure vendor UI/PDF/mail stacks and the installer. Include FortuneVoronoi + NNAlgoCPP (C++/CLI).
$skip = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
@(
  "itextsharp.dll", "OpenPop.dll",
  "TeeChart.dll", "TeeChart.Languages.dll", "TeeChart.WPF.dll",
  "WPFToolkit.dll",
  "Uninstall.exe"
) | ForEach-Object { [void]$skip.Add($_) }

# Placement-critical assemblies get IL + PDB + diagrammer extras
$critical = [System.Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
@(
  "APM.LocatorII.exe", "Algorithm.dll", "APM.VesselGeom.dll", "APM.SurfaceUC.dll",
  "MultiScanner.dll", "Analyze.dll", "Data.dll", "ApplMngr.dll", "ProjMngr.dll",
  "ConicSynthDLLWrapper.dll", "NNAlgoCSharpWrapper.dll", "NNAlgoCPP.dll",
  "FortuneVoronoi.dll", "ConfigFile.dll", "Utils.dll"
) | ForEach-Object { [void]$skip.Remove($_); [void]$critical.Add($_) }

# Fidelity-oriented settings: keep all IL-derived code, prefer explicit braces/locals
$decompilerSettings = @(
  "AlwaysUseBraces=true",
  "SeparateLocalVariableDeclarations=true",
  "UseExpressionBodiesForMethods=false",
  "UseExpressionBodiesForProperties=false",
  "UseExpressionBodiesForAccessors=false",
  "AggressiveInlining=false",
  "RemoveDeadCode=false",
  "RemoveDeadStores=false",
  "ShowXmlDocumentation=true",
  "UseDebugSymbols=true",
  "AlwaysShowEnumMemberValues=true",
  "OptionalArguments=false",
  "NamedArguments=false"
)

function Test-IsDotNetAssembly([string]$path) {
  try {
    $bytes = [IO.File]::ReadAllBytes($path)
    if ($bytes.Length -lt 64) { return $false }
    $ascii = [Text.Encoding]::ASCII.GetString($bytes)
    return $ascii.Contains("BSJB")
  } catch {
    return $false
  }
}

function Get-IlspyBaseArgs([string]$srcDir) {
  $args = @(
    "-p",
    "--nested-directories",
    "--decompile-baml",
    "--disable-updatecheck",
    "-lv", "CSharp7_3",
    "-r", $srcDir
  )
  foreach ($s in $decompilerSettings) {
    $args += @("-ds", $s)
  }
  return $args
}

function Invoke-DecompileOne([System.IO.FileInfo]$f, [string]$srcDir, [string]$outRoot) {
  $out = Join-Path $outRoot $f.BaseName
  if (Test-Path $out) { Remove-Item -Recurse -Force $out }
  New-Item -ItemType Directory -Force -Path $out | Out-Null

  $pdbBeside = [IO.Path]::ChangeExtension($f.FullName, ".pdb")
  $argList = Get-IlspyBaseArgs $srcDir
  $argList += @("-o", $out)
  if (Test-Path $pdbBeside) {
    $argList += "--use-varnames-from-pdb"
  }
  $argList += $f.FullName

  Write-Host "DECOMP $($f.Name)"
  $prevEap = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  $log = & ilspycmd @argList 2>&1 | ForEach-Object { "$_" } | Out-String
  $code = $LASTEXITCODE
  $ErrorActionPreference = $prevEap

  $csCount = @(Get-ChildItem $out -Recurse -Filter *.cs -File -ErrorAction SilentlyContinue).Count
  $xamlCount = @(Get-ChildItem $out -Recurse -Filter *.xaml -File -ErrorAction SilentlyContinue).Count
  $ok = ($code -eq 0 -and $csCount -gt 0)

  $meta = @"
Source: $($f.FullName)
SizeBytes: $($f.Length)
HasPdb: $(Test-Path $pdbBeside)
DecompiledUtc: $([DateTime]::UtcNow.ToString('o'))
Tool: $toolVersion
LanguageVersion: CSharp7_3
FidelitySettings: $($decompilerSettings -join '; ')
CsFiles: $csCount
XamlFiles: $xamlCount
CriticalPlacement: $($critical.Contains($f.Name))
MixedModeOrCppCli: $($f.Name -match 'NNAlgoCPP')
"@
  if ($ok) {
    Set-Content -Encoding UTF8 (Join-Path $out "_SOURCE.txt") $meta
  } else {
    Write-Warning "FAIL $($f.Name) exit=$code cs=$csCount"
    Set-Content -Encoding UTF8 (Join-Path $out "_FAILED.txt") ("exit=$code`n$log`n$meta")
  }

  return [PSCustomObject]@{
    Assembly = $f.Name
    Status   = if ($ok) { "ok" } else { "fail" }
    Cs       = $csCount
    Xaml     = $xamlCount
    OutDir   = $out
  }
}

function Export-Extras([System.IO.FileInfo]$f, [string]$srcDir, [string]$outRoot, [string]$assemblyOut) {
  if (-not $critical.Contains($f.Name)) { return }

  # Type inventory
  $invDir = Join-Path $outRoot "_inventory"
  New-Item -ItemType Directory -Force -Path $invDir | Out-Null
  $invBase = Join-Path $invDir $f.BaseName
  foreach ($kind in @("c", "i", "s", "e", "d")) {
    $prevEap = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    & ilspycmd -l $kind --disable-updatecheck -r $srcDir $f.FullName 2>&1 |
      ForEach-Object { "$_" } |
      Set-Content -Encoding UTF8 "$invBase.$kind.txt"
    $ErrorActionPreference = $prevEap
  }

  # Resource list
  $prevEap = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  & ilspycmd --list-resources --disable-updatecheck -r $srcDir $f.FullName 2>&1 |
    ForEach-Object { "$_" } |
    Set-Content -Encoding UTF8 "$invBase.resources.txt"
  $ErrorActionPreference = $prevEap

  # IL dump (reference / golden)
  $ilDir = Join-Path $outRoot "_il"
  New-Item -ItemType Directory -Force -Path $ilDir | Out-Null
  $ilOut = Join-Path $ilDir ($f.BaseName + ".il")
  Write-Host "IL $($f.Name)"
  $prevEap = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  & ilspycmd -il --il-sequence-points --disable-updatecheck -r $srcDir $f.FullName 2>&1 |
    ForEach-Object { "$_" } |
    Set-Content -Encoding UTF8 $ilOut
  $ErrorActionPreference = $prevEap

  # Generated PDB next to decompiled project (aids debugging ports)
  $pdbDir = Join-Path $outRoot "_pdbs"
  New-Item -ItemType Directory -Force -Path $pdbDir | Out-Null
  Write-Host "PDB $($f.Name)"
  $prevEap = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  & ilspycmd -genpdb -o $pdbDir --disable-updatecheck -r $srcDir $f.FullName 2>&1 | Out-Null
  $ErrorActionPreference = $prevEap
}

function Copy-InstallTree([string]$srcDir, [string]$outRoot) {
  $binRoot = Join-Path $outRoot "_binaries"
  if (Test-Path $binRoot) { Remove-Item -Recurse -Force $binRoot }
  New-Item -ItemType Directory -Force -Path $binRoot | Out-Null

  # Full managed + native install payload for exact-reuse / side-by-side validation
  Get-ChildItem $srcDir -File | Where-Object {
    $_.Extension -match "^\.(dll|exe|config|manifest|application|txt)$"
  } | ForEach-Object {
    Copy-Item $_.FullName (Join-Path $binRoot $_.Name) -Force
  }

  $fuzzySrc = Join-Path $srcDir "FuzzyTables"
  if (Test-Path $fuzzySrc) {
    Copy-Item $fuzzySrc (Join-Path $binRoot "FuzzyTables") -Recurse -Force
  }

  # Also keep friendly _install_data mirror
  $dataRoot = Join-Path $outRoot "_install_data"
  if (Test-Path $dataRoot) { Remove-Item -Recurse -Force $dataRoot }
  New-Item -ItemType Directory -Force -Path $dataRoot | Out-Null
  Get-ChildItem $srcDir -File | Where-Object {
    $_.Extension -match "^\.(txt|config|manifest|application)$" -or $_.Name -like "Locator*"
  } | ForEach-Object {
    Copy-Item $_.FullName (Join-Path $dataRoot $_.Name) -Force
  }
  if (Test-Path $fuzzySrc) {
    Copy-Item $fuzzySrc (Join-Path $dataRoot "FuzzyTables") -Recurse -Force
  }

  # Native/mixed dumpbin notes
  $dumpbinCandidates = @(
    "${env:ProgramFiles}\Microsoft Visual Studio\*\*\VC\Tools\MSVC\*\bin\Hostx86\x86\dumpbin.exe",
    "${env:ProgramFiles}\Microsoft Visual Studio\*\Community\VC\Tools\MSVC\*\bin\Hostx86\x86\dumpbin.exe"
  )
  $dumpbin = $null
  foreach ($pat in $dumpbinCandidates) {
    $hit = Get-Item $pat -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($hit) { $dumpbin = $hit.FullName; break }
  }
  if (-not $dumpbin) {
    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
    if (Test-Path $vswhere) {
      $dumpbin = & $vswhere -latest -products * -find "**/Hostx86/x86/dumpbin.exe" 2>$null | Select-Object -First 1
    }
  }

  $nativeDir = Join-Path $outRoot "_native"
  New-Item -ItemType Directory -Force -Path $nativeDir | Out-Null
  $nn = Join-Path $srcDir "NNAlgoCPP.dll"
  if ((Test-Path $nn) -and $dumpbin) {
    Write-Host "NATIVE-DUMP NNAlgoCPP.dll"
    & $dumpbin /headers $nn > (Join-Path $nativeDir "NNAlgoCPP.headers.txt") 2>&1
    & $dumpbin /dependents $nn > (Join-Path $nativeDir "NNAlgoCPP.dependents.txt") 2>&1
    & $dumpbin /exports $nn > (Join-Path $nativeDir "NNAlgoCPP.exports.txt") 2>&1
    & $dumpbin /clrheader $nn > (Join-Path $nativeDir "NNAlgoCPP.clrheader.txt") 2>&1
  }

  @"
# Native / mixed-mode notes

NNAlgoCPP.dll is a **C++/CLI mixed-mode** assembly (BSJB + native code, depends on MSVCR100.dll).
- Managed surface (NNAlgoCPPManaged, NNAlgoPoints, eAlgoNNType) is decompiled under ``NNAlgoCPP/``.
- Core Sibson / interpolation math lives in native methods inside the same DLL (called via ``<Module>`` helpers).
- For bit-identical interpolation results, load the original ``_binaries/NNAlgoCPP.dll`` (x86) rather than reimplementing native code from the C++/CLI stubs.

GeneratedUtc: $([DateTime]::UtcNow.ToString('o'))
Dumpbin: $dumpbin
"@ | Set-Content -Encoding UTF8 (Join-Path $nativeDir "README.md")
}

function New-PlacementSolution([string]$outRoot) {
  $projects = @(
    "APM.LocatorII", "Algorithm", "APM.VesselGeom", "APM.SurfaceUC",
    "MultiScanner", "Analyze", "Data", "ApplMngr", "ProjMngr",
    "ConicSynthDLLWrapper", "NNAlgoCSharpWrapper", "NNAlgoCPP",
    "FortuneVoronoi", "ConfigFile", "Utils", "GuiUtils", "WPFStuff",
    "Logger", "LoggerBase", "Defines", "Errors", "BaseMngr"
  ) | Where-Object { Test-Path (Join-Path $outRoot $_) }

  $slnPath = Join-Path $outRoot "Locator.Placement.sln"
  $sb = New-Object System.Text.StringBuilder
  [void]$sb.AppendLine("Microsoft Visual Studio Solution File, Format Version 12.00")
  [void]$sb.AppendLine("# Visual Studio Version 17")
  [void]$sb.AppendLine("VisualStudioVersion = 17.0.31903.59")
  [void]$sb.AppendLine("MinimumVisualStudioVersion = 10.0.40219.1")

  $guids = @{}
  foreach ($p in $projects) {
    $csproj = Get-ChildItem (Join-Path $outRoot $p) -Filter *.csproj | Select-Object -First 1
    if (-not $csproj) { continue }
    $guid = [guid]::NewGuid().ToString().ToUpperInvariant()
    $guids[$p] = $guid
    $rel = "$p\$($csproj.Name)"
    [void]$sb.AppendLine("Project(`"{FAE04EC0-301F-11D3-BF4B-00C04F79EFBC}`") = `"$p`", `"$rel`", `"{$guid}`"")
    [void]$sb.AppendLine("EndProject")
  }

  [void]$sb.AppendLine("Global")
  [void]$sb.AppendLine("`tGlobalSection(SolutionConfigurationPlatforms) = preSolution")
  [void]$sb.AppendLine("`t`tDebug|Any CPU = Debug|Any CPU")
  [void]$sb.AppendLine("`t`tRelease|Any CPU = Release|Any CPU")
  [void]$sb.AppendLine("`tEndGlobalSection")
  [void]$sb.AppendLine("`tGlobalSection(ProjectConfigurationPlatforms) = postSolution")
  foreach ($p in $guids.Keys) {
    $g = $guids[$p]
    [void]$sb.AppendLine("`t`t{$g}.Debug|Any CPU.ActiveCfg = Debug|Any CPU")
    [void]$sb.AppendLine("`t`t{$g}.Debug|Any CPU.Build.0 = Debug|Any CPU")
    [void]$sb.AppendLine("`t`t{$g}.Release|Any CPU.ActiveCfg = Release|Any CPU")
    [void]$sb.AppendLine("`t`t{$g}.Release|Any CPU.Build.0 = Release|Any CPU")
  }
  [void]$sb.AppendLine("`tEndGlobalSection")
  [void]$sb.AppendLine("EndGlobal")
  Set-Content -Encoding UTF8 $slnPath $sb.ToString()
  Write-Host "Wrote $slnPath"
}

function New-Diagrammer([string]$srcDir, [string]$outRoot) {
  $diagRoot = Join-Path $outRoot "_diagrammer"
  New-Item -ItemType Directory -Force -Path $diagRoot | Out-Null
  $exe = Join-Path $srcDir "APM.LocatorII.exe"
  if (-not (Test-Path $exe)) { return }
  Write-Host "DIAGRAMMER APM.LocatorII (placement types)"
  $prevEap = $ErrorActionPreference
  $ErrorActionPreference = "Continue"
  & ilspycmd $exe -o $diagRoot --disable-updatecheck -r $srcDir `
    --generate-diagrammer `
    --generate-diagrammer-include "APM\.Locator\.(Algo|ExhaustiveSearch|ErrorEstimation|Fuzzy|Geometry|Config).*" `
    2>&1 | Out-Null
  $ErrorActionPreference = $prevEap
}

if ($Clean -and (Test-Path $OutRoot)) {
  Write-Host "Cleaning $OutRoot"
  Remove-Item -Recurse -Force $OutRoot
}

New-Item -ItemType Directory -Force -Path $OutRoot | Out-Null

Write-Host "=== LOCATOR MAX-FIDELITY ($LocatorBin) ==="
Write-Host "Tool: $toolVersion"

$files = Get-ChildItem $LocatorBin -File | Where-Object {
  $_.Extension -match "^\.(dll|exe)$" -and $_.Name -notmatch "\.vshost\.exe$"
}

$ok = 0; $fail = 0; $skipNative = 0; $skipThird = 0
$results = @()

foreach ($f in $files) {
  if ($skip.Contains($f.Name)) {
    Write-Host "SKIP-3RD  $($f.Name)"
    $skipThird++
    $results += [PSCustomObject]@{ Assembly = $f.Name; Status = "skip-third-party"; Cs = 0; Xaml = 0 }
    continue
  }
  if (-not (Test-IsDotNetAssembly $f.FullName)) {
    Write-Host "SKIP-NATIVE $($f.Name)"
    $skipNative++
    $results += [PSCustomObject]@{ Assembly = $f.Name; Status = "skip-native"; Cs = 0; Xaml = 0 }
    continue
  }

  $r = Invoke-DecompileOne $f $LocatorBin $OutRoot
  $results += $r
  if ($r.Status -eq "ok") {
    $ok++
    Export-Extras $f $LocatorBin $OutRoot $r.OutDir
  } else {
    $fail++
  }
}

$results | Export-Csv -NoTypeInformation -Encoding UTF8 (Join-Path $OutRoot "_manifest.csv")

Copy-InstallTree $LocatorBin $OutRoot
New-PlacementSolution $OutRoot
New-Diagrammer $LocatorBin $OutRoot

$allCs = @(Get-ChildItem $OutRoot -Recurse -Filter *.cs -File -ErrorAction SilentlyContinue | Where-Object { $_.FullName -notmatch '\\_il\\' }).Count
$allXaml = @(Get-ChildItem $OutRoot -Recurse -Filter *.xaml -File -ErrorAction SilentlyContinue).Count
$allProj = @(Get-ChildItem $OutRoot -Recurse -Filter *.csproj -File -ErrorAction SilentlyContinue).Count

@"
# 3D Solids Scanner Locator — maximum-fidelity decompilation

Generated by ``scripts/decompile-locator.ps1`` using **ilspycmd** ``$toolVersion``.

## Source

``$LocatorBin``  
Main entry: ``APM.LocatorII.exe`` (v2.6.7.0, .NET Framework 4 / CLR v4.0.30319)

## What "best possible" means here

| Layer | Status |
|-------|--------|
| First-party managed C# / WPF | Full project decompile (``.csproj`` + nested types + BAML→XAML) |
| FortuneVoronoi | Included (managed; used by ConicSynth voronoi path) |
| NNAlgoCPP | **C++/CLI mixed-mode**: managed API decompiled; native Sibson core kept as original binary |
| Vendor UI/PDF (TeeChart, itextsharp, OpenPop, WPFToolkit) | Skipped (not needed for placement math) |
| Install FuzzyTables + Locator sample txt | Copied under ``_install_data/`` and ``_binaries/`` |

### Fidelity switches used

- Language: **CSharp7_3** (matches .NET Framework-era product)
- ``AlwaysUseBraces``, ``SeparateLocalVariableDeclarations``
- **No** dead-code / dead-store removal (preserves IL-faithful bodies)
- ``--decompile-baml``, ``--nested-directories``
- Reference path = install folder for correct assembly resolve

## Layout

- ``<Assembly>/`` — ILSpy project per assembly
- ``_binaries/`` — **exact install copies** (preferred for same-precision reuse)
- ``_install_data/`` — FuzzyTables + Locator.*.txt + app config/manifest
- ``_il/`` — IL dumps for placement-critical assemblies (golden reference)
- ``_pdbs/`` — generated PDBs for critical assemblies
- ``_inventory/`` — type + resource inventories
- ``_native/`` — dumpbin headers/dependents for NNAlgoCPP
- ``_diagrammer/`` — HTML diagram of placement-related Locator types
- ``Locator.Placement.sln`` — solution of placement-critical projects
- ``_manifest.csv`` — per-assembly status

## Same-precision placement path

1. **Highest fidelity:** reference ``_binaries/*.dll`` + call into ``APM.LocatorII`` / ``ErrorEstimationCal`` / ``ExhaustiveSearchExe`` (or a thin host).
2. **Port path:** reimplement from decompiled ``ExhaustiveSearch``, ``ErrorEstimation``, ``Algorithm``, ``Fuzzy`` + ship original ``NNAlgoCPP.dll`` (x86) beside the app.
3. Validate side-by-side against the real Locator on the same vessel dimensions.

## Refresh

``````powershell
dotnet tool install -g ilspycmd
.\scripts\decompile-locator.ps1 -Clean
``````

## Stats

GeneratedUtc: $([DateTime]::UtcNow.ToString('o'))
Ok=$ok Fail=$fail SkipNative=$skipNative SkipThirdParty=$skipThird Candidates=$($files.Count)
CsFiles=$allCs XamlFiles=$allXaml Projects=$allProj
"@ | Set-Content -Encoding UTF8 (Join-Path $OutRoot "README.md")

Write-Host "Done. Ok=$ok Fail=$fail Cs=$allCs Xaml=$allXaml Out=$OutRoot"
[PSCustomObject]@{ Ok = $ok; Fail = $fail; SkipNative = $skipNative; SkipThirdParty = $skipThird; Cs = $allCs; Xaml = $allXaml; Projects = $allProj }
