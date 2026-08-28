param(
    [string]$DestinationRoot = "",
    [switch]$Preview
)

$ErrorActionPreference = "Stop"
$repoRoot = (Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")).Path
$packageParent = Split-Path -Parent $repoRoot
if ([string]::IsNullOrWhiteSpace($DestinationRoot)) {
    $documentsRoot = [Environment]::GetFolderPath("MyDocuments")
    $DestinationRoot = Join-Path $documentsRoot "maya\2025\modules"
}
$moduleDirectory = [System.IO.Path]::GetFullPath($DestinationRoot)
$moduleFile = Join-Path $moduleDirectory "MayaCraft.mod"
$normalizedModuleRoot = (Join-Path $repoRoot "install\module").Replace("\", "/")
$moduleText = @(
    "+ MayaCraft 2.1 $normalizedModuleRoot"
) -join [Environment]::NewLine
$moduleText += [Environment]::NewLine

Write-Output "MayaCraft 2.1 / Maya 2025 安装计划"
Write-Output "模块文件：$moduleFile"
Write-Output "Python 包目录：$packageParent"
Write-Output ""
Write-Output $moduleText

if ($Preview) {
    Write-Output "预览完成：未写入任何文件。"
    return
}

New-Item -ItemType Directory -Path $moduleDirectory -Force | Out-Null
[System.IO.File]::WriteAllText(
    $moduleFile,
    $moduleText,
    [System.Text.UTF8Encoding]::new($false)
)
$writtenText = [System.IO.File]::ReadAllText($moduleFile)
if ($writtenText -ne $moduleText) {
    throw "MayaCraft.mod 写入后读回不一致：$moduleFile"
}
Write-Output "安装完成并已读回验证。重新启动 Maya 2025 后即可 import MayaCraft。"
