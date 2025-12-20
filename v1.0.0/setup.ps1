# BERK Programming Language - Windows Setup Script
# Version: 1.0.0
# This script installs BERK and configures the system PATH

param(
    [switch]$Uninstall,
    [string]$InstallPath = "$env:LOCALAPPDATA\BERK"
)

$ErrorActionPreference = "Stop"

# Colors for output
function Write-Success { param($msg) Write-Host $msg -ForegroundColor Green }
function Write-Info { param($msg) Write-Host $msg -ForegroundColor Cyan }
function Write-Warn { param($msg) Write-Host $msg -ForegroundColor Yellow }
function Write-Err { param($msg) Write-Host $msg -ForegroundColor Red }

# Banner
Write-Host @"

██████╗ ███████╗██████╗ ██╗  ██╗
██╔══██╗██╔════╝██╔══██╗██║ ██╔╝
██████╔╝█████╗  ██████╔╝█████╔╝ 
██╔══██╗██╔══╝  ██╔══██╗██╔═██╗ 
██████╔╝███████╗██║  ██║██║  ██╗
╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
                                
"@ -ForegroundColor Cyan

Write-Host "BERK Programming Language Installer v1.0.0" -ForegroundColor White
Write-Host "Turkish-English Dual Syntax Language" -ForegroundColor Gray
Write-Host ""

if ($Uninstall) {
    Write-Info "Uninstalling BERK..."
    
    # Remove from PATH
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -like "*$InstallPath*") {
        $newPath = ($currentPath -split ';' | Where-Object { $_ -ne $InstallPath }) -join ';'
        [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
        Write-Success "Removed BERK from PATH"
    }
    
    # Remove installation directory
    if (Test-Path $InstallPath) {
        Remove-Item -Path $InstallPath -Recurse -Force
        Write-Success "Removed installation directory: $InstallPath"
    }
    
    Write-Success "`nBERK has been uninstalled successfully!"
    exit 0
}

# Installation
Write-Info "Installing BERK to: $InstallPath"
Write-Host ""

# Create installation directory
if (-not (Test-Path $InstallPath)) {
    New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null
    Write-Success "Created installation directory"
}

# Get script directory (where the exe files are)
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BinDir = Join-Path $ScriptDir "bin"

# Check if bin directory exists, otherwise use script directory
if (-not (Test-Path $BinDir)) {
    $BinDir = $ScriptDir
}

# Copy executables
$exeFiles = @("berk-lang.exe", "berk-lsp.exe", "berk-repl.exe")
$copiedCount = 0

foreach ($exe in $exeFiles) {
    $srcPath = Join-Path $BinDir $exe
    $dstPath = Join-Path $InstallPath $exe
    
    if (Test-Path $srcPath) {
        Copy-Item -Path $srcPath -Destination $dstPath -Force
        Write-Success "  Installed: $exe"
        $copiedCount++
    } else {
        Write-Warn "  Not found: $exe (skipping)"
    }
}

if ($copiedCount -eq 0) {
    Write-Err "No executable files found to install!"
    Write-Err "Please ensure berk-lang.exe, berk-lsp.exe, and berk-repl.exe are in the bin directory."
    exit 1
}

# Create berk.cmd wrapper for easier command line usage
$berkCmd = @"
@echo off
"%~dp0berk-lang.exe" %*
"@
$berkCmd | Out-File -FilePath (Join-Path $InstallPath "berk.cmd") -Encoding ASCII
Write-Success "  Created: berk.cmd (shortcut)"

# Add to PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
if ($currentPath -notlike "*$InstallPath*") {
    $newPath = "$currentPath;$InstallPath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Success "Added BERK to user PATH"
} else {
    Write-Info "BERK already in PATH"
}

# Copy stdlib if available
$stdlibSrc = Join-Path $ScriptDir "stdlib"
$stdlibDst = Join-Path $InstallPath "stdlib"

if (Test-Path $stdlibSrc) {
    if (Test-Path $stdlibDst) { Remove-Item $stdlibDst -Recurse -Force }
    Copy-Item -Path $stdlibSrc -Destination $stdlibDst -Recurse -Force
    Write-Success "  Installed: stdlib"
}

Write-Host ""
Write-Success "═══════════════════════════════════════════════════════════"
Write-Success "  BERK has been installed successfully!"
Write-Success "═══════════════════════════════════════════════════════════"
Write-Host ""
Write-Info "To get started, open a NEW terminal and try:"
Write-Host ""
Write-Host "  berk --version        # Check version" -ForegroundColor White
Write-Host "  berk --help           # Show help" -ForegroundColor White
Write-Host "  berk run hello.berk   # Run a program" -ForegroundColor White
Write-Host "  berk-repl             # Start interactive REPL" -ForegroundColor White
Write-Host ""
Write-Info "Installation path: $InstallPath"
Write-Host ""
Write-Warn "Note: You may need to restart your terminal for PATH changes to take effect."
Write-Host ""
