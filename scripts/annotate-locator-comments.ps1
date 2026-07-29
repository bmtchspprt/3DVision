<#
.SYNOPSIS
  Prepend navigation / math-protection banners to all decompiled Locator .cs files.
#>
param(
  [string]$Root = (Join-Path (Split-Path $PSScriptRoot -Parent) "decompiled\locator")
)

$ErrorActionPreference = "Stop"
$marker = "DECOMPILED-LOCATOR:"

$assemblyRoles = @{
  "APM.LocatorII"           = "MAIN APP - wizard UI, ExhaustiveSearch, ErrorEstimation, Fuzzy, AlgoCalc. Placement entry."
  "Algorithm"               = "MATH-CRITICAL - largest-empty-circle / bad-ball packing primitives for error estimation."
  "APM.VesselGeom"          = "Vessel / silo geometry model used by placement scoring."
  "APM.SurfaceUC"           = "Surface visualization UI controls."
  "MultiScanner"            = "Multi-scanner calculation / mapping data types."
  "Analyze"                 = "Analysis helpers (small)."
  "Data"                    = "Vessel/scanner/domain data model (large)."
  "ApplMngr"                = "Application configuration / project manager glue."
  "ProjMngr"                = "Project manager types."
  "ConicSynthDLLWrapper"    = "MATH-SENSITIVE - bridges to voronoi + NNAlgo interpolation."
  "NNAlgoCSharpWrapper"     = "Thin managed wrapper over NNAlgoCPP (do not bypass)."
  "NNAlgoCPP"               = "MATH-CRITICAL mixed-mode C++/CLI - keep _binaries/NNAlgoCPP.dll for real Sibson math."
  "FortuneVoronoi"          = "Managed Fortune voronoi graph (BenTools)."
  "ConfigFile"              = "Config file IO."
  "Utils"                   = "Shared utilities."
  "GuiUtils"                = "GUI utilities."
  "WPFStuff"                = "WPF helpers / progress UI."
  "WPFStuffServer"          = "Server-side WPF helpers."
  "WPFInfra"                = "WPF infrastructure."
  "Logger"                  = "Logging."
  "LoggerBase"              = "Logging base."
  "Defines"                 = "Shared defines / enums."
  "Errors"                  = "Error types."
  "BaseMngr"                = "Base manager."
  "Communication"           = "Comms (shared with Vision stack)."
  "Connection"              = "Connection / ports."
  "Parser"                  = "Protocol parsers."
  "Packer"                  = "Packing helpers."
  "Dal"                     = "Data access layer stubs."
  "3DTools"                 = "3D viewport helpers (Trackball etc)."
  "3DVisionGui"             = "Shared Vision GUI (large; not Locator-specific math)."
  "VisualVision3DUtils"     = "3D visualization utilities."
  "TDLMMain"                = "Main TDLM UI stack (shared)."
  "TDLMMainBase"            = "TDLM main base."
  "TDLMServerClientWrapper" = "Server client wrapper contracts."
  "TDLM.ReportServer"       = "Reporting."
  "APMRes"                  = "Resources."
  "ApplProjConfigFile"      = "Project config file."
  "Resoem"                  = "Resources / OEM."
  "Lzma#"                   = "LZMA compression (SevenZip) - not placement math."
}

function Get-AssemblyName([string]$fullPath, [string]$root) {
  $rel = $fullPath.Substring($root.Length).TrimStart('\', '/')
  return ($rel -split '[\\/]')[0]
}

function Test-IsMathCritical([string]$fullPath, [string]$assembly) {
  if ($assembly -in @('Algorithm', 'NNAlgoCPP', 'NNAlgoCSharpWrapper', 'ConicSynthDLLWrapper', 'FortuneVoronoi', 'MultiScanner')) {
    return $true
  }
  if ($fullPath -match 'ExhaustiveSearch|ErrorEstimation|Fuzzy|\\\\Algo\\\\|AlgoCalc|AlgoError|Geometry') {
    return $true
  }
  return $false
}

$files = Get-ChildItem -LiteralPath $Root -Recurse -Filter *.cs -File | Where-Object {
  $_.FullName -notmatch '\\(obj|bin)\\'
}

$updated = 0
$skipped = 0

foreach ($f in $files) {
  $text = [IO.File]::ReadAllText($f.FullName)
  if ($text.Contains($marker)) {
    $skipped++
    continue
  }

  $asm = Get-AssemblyName $f.FullName $Root
  $role = if ($assemblyRoles.ContainsKey($asm)) { $assemblyRoles[$asm] } else { "Decompiled assembly support code." }
  $rel = $f.FullName.Substring($Root.Length).TrimStart('\', '/')
  $math = Test-IsMathCritical $f.FullName $asm

  $mathLines = @()
  if ($math) {
    $mathLines = @(
      "// MATH-CRITICAL / PLACEMENT-SENSITIVE",
      "// - DO NOT simplify, refactor, rearrange, or clean up numeric expressions.",
      "// - DO NOT change magic constants, loop bounds, float vs double, or evaluation order.",
      "// - Locals named num/num2/flag/list are ILSpy artifacts - preserve expressions exactly when porting.",
      "// - Validate any intentional change against the real Locator + _il/$asm.il golden IL.",
      "//"
    )
  }

  $bannerLines = @(
    "// ============================================================================",
    "// $marker $rel",
    "// Assembly: $asm",
    "// Role: $role",
    "// Origin: ILSpy reconstruction of 3D Solids Scanner Locator (NOT original hand-written source).",
    "// Nav: see decompiled/locator/SIMPLE.md (plain English), NAVIGATION.md, PLACEMENT.md, README.md",
    "// Rule: .cursor/rules/locator-decompiled.mdc"
  ) + $mathLines + @(
    "// ============================================================================",
    ""
  )

  $banner = ($bannerLines -join "`r`n") + "`r`n"
  $utf8Bom = New-Object System.Text.UTF8Encoding $true
  [IO.File]::WriteAllText($f.FullName, $banner + $text, $utf8Bom)
  $updated++
}

Write-Host "Annotated=$updated SkippedExisting=$skipped Total=$($files.Count)"
