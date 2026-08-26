param(
    [string]$MayaExe = "C:\Program Files\Autodesk\Maya2025\bin\maya.exe",
    [int]$TimeoutSeconds = 90
)

$ErrorActionPreference = "Stop"
$repoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$artifactRoot = Join-Path $PSScriptRoot "artifacts"
$scriptPath = Join-Path $PSScriptRoot "maya_gui_workspace_validation.mel"
$reportPath = Join-Path $artifactRoot "maya2025_workspace_report.json"
$logPath = Join-Path $artifactRoot "maya2025_workspace.log"

if (-not (Test-Path -LiteralPath $MayaExe -PathType Leaf)) {
    throw "Maya executable not found: $MayaExe"
}
New-Item -ItemType Directory -Path $artifactRoot -Force | Out-Null
Remove-Item -LiteralPath $reportPath, $logPath -Force -ErrorAction SilentlyContinue

$env:MAYACRAFT_VALIDATION_ROOT = $repoRoot
$process = Start-Process -FilePath $MayaExe `
    -ArgumentList @("-hideConsole", "-noAutoloadPlugins", "-script", $scriptPath, "-log", $logPath) `
    -PassThru -WindowStyle Hidden

$deadline = (Get-Date).AddSeconds($TimeoutSeconds)
while ((Get-Date) -lt $deadline -and -not (Test-Path -LiteralPath $reportPath)) {
    Start-Sleep -Milliseconds 250
}

if (-not (Test-Path -LiteralPath $reportPath)) {
    $spawned = Get-Process -Id $process.Id -ErrorAction SilentlyContinue
    if ($spawned -and $spawned.ProcessName -eq "maya") {
        Stop-Process -Id $process.Id
    }
    throw "Maya 2025 GUI validation timed out after $TimeoutSeconds seconds. See $logPath"
}

$report = Get-Content -LiteralPath $reportPath -Raw | ConvertFrom-Json
if (-not $report.passed) {
    throw "Maya 2025 GUI validation failed: $($report.error)"
}

$process.WaitForExit(10000) | Out-Null
$report | ConvertTo-Json -Depth 8
