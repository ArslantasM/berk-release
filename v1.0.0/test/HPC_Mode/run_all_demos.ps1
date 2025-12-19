# ============================================================================
# BERK-DDS HPC Mode - Demo Runner Script (PowerShell)
# ============================================================================
# Bu script tüm HPC Mode demo dosyalarını çalıştırır.
# 
# Kullanım:
#   .\run_all_demos.ps1           -> Tüm demoları çalıştır
#   .\run_all_demos.ps1 basic     -> Sadece basic demoyu çalıştır
#   .\run_all_demos.ps1 benchmark -> Sadece benchmark demoyu çalıştır
# ============================================================================

param(
    [string]$Demo = "all"
)

$BerkCmd = "cargo run --release --manifest-path ..\..\berk-lang\Cargo.toml --"

function Show-Header {
    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║           BERK-DDS HPC MODE - DEMO RUNNER                       ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

function Show-Footer {
    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
    Write-Host "║                      DEMO(S) TAMAMLANDI                          ║" -ForegroundColor Green
    Write-Host "╚══════════════════════════════════════════════════════════════════╝" -ForegroundColor Green
}

function Run-Demo {
    param([string]$Name, [string]$File, [int]$Index, [int]$Total)
    
    Write-Host "[$Index/$Total] Running $Name..." -ForegroundColor Yellow
    Write-Host "═══════════════════════════════════════════════════════════════════" -ForegroundColor DarkGray
    
    $process = Start-Process -FilePath "cargo" -ArgumentList "run", "--release", "--manifest-path", "..\..\berk-lang\Cargo.toml", "--", $File -NoNewWindow -Wait -PassThru
    
    if ($process.ExitCode -eq 0) {
        Write-Host "✓ $Name completed successfully" -ForegroundColor Green
    } else {
        Write-Host "✗ $Name failed with exit code $($process.ExitCode)" -ForegroundColor Red
    }
    Write-Host ""
}

Show-Header

$demos = @{
    "basic"     = @{ Name = "Basic Demo"; File = "hpc_basic_demo.berk" }
    "pubsub"    = @{ Name = "Pub/Sub Demo"; File = "hpc_pubsub_demo.berk" }
    "benchmark" = @{ Name = "Benchmark Demo"; File = "hpc_benchmark_demo.berk" }
    "robot"     = @{ Name = "Robot Control Demo"; File = "hpc_robot_control.berk" }
    "sensor"    = @{ Name = "Sensor Fusion Demo"; File = "hpc_sensor_fusion.berk" }
    "config"    = @{ Name = "Config Profiles Demo"; File = "hpc_config_profiles.berk" }
}

if ($Demo -eq "all") {
    $index = 1
    $total = $demos.Count
    foreach ($key in @("basic", "pubsub", "benchmark", "robot", "sensor", "config")) {
        $d = $demos[$key]
        Run-Demo -Name $d.Name -File $d.File -Index $index -Total $total
        $index++
    }
} elseif ($demos.ContainsKey($Demo)) {
    $d = $demos[$Demo]
    Run-Demo -Name $d.Name -File $d.File -Index 1 -Total 1
} else {
    Write-Host "Unknown demo: $Demo" -ForegroundColor Red
    Write-Host "Available demos: all, basic, pubsub, benchmark, robot, sensor, config" -ForegroundColor Yellow
    exit 1
}

Show-Footer
