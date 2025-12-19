@echo off
REM ============================================================================
REM BERK-DDS HPC Mode - Demo Runner Script
REM ============================================================================
REM Bu script tüm HPC Mode demo dosyalarını çalıştırır.
REM 
REM Kullanım:
REM   run_all_demos.bat           -> Tüm demoları çalıştır
REM   run_all_demos.bat basic     -> Sadece basic demoyu çalıştır
REM   run_all_demos.bat benchmark -> Sadece benchmark demoyu çalıştır
REM ============================================================================

echo.
echo ╔══════════════════════════════════════════════════════════════════╗
echo ║           BERK-DDS HPC MODE - DEMO RUNNER                       ║
echo ╚══════════════════════════════════════════════════════════════════╝
echo.

set BERK_CMD=cargo run --release --manifest-path ..\..\berk-lang\Cargo.toml --

if "%1"=="" goto :run_all
if "%1"=="basic" goto :run_basic
if "%1"=="pubsub" goto :run_pubsub
if "%1"=="benchmark" goto :run_benchmark
if "%1"=="robot" goto :run_robot
if "%1"=="sensor" goto :run_sensor
if "%1"=="config" goto :run_config
goto :run_all

:run_all
echo [1/6] Running Basic Demo...
echo ═══════════════════════════════════════════════════════════════════
%BERK_CMD% hpc_basic_demo.berk
echo.
echo [2/6] Running Pub/Sub Demo...
echo ═══════════════════════════════════════════════════════════════════
%BERK_CMD% hpc_pubsub_demo.berk
echo.
echo [3/6] Running Benchmark Demo...
echo ═══════════════════════════════════════════════════════════════════
%BERK_CMD% hpc_benchmark_demo.berk
echo.
echo [4/6] Running Robot Control Demo...
echo ═══════════════════════════════════════════════════════════════════
%BERK_CMD% hpc_robot_control.berk
echo.
echo [5/6] Running Sensor Fusion Demo...
echo ═══════════════════════════════════════════════════════════════════
%BERK_CMD% hpc_sensor_fusion.berk
echo.
echo [6/6] Running Config Profiles Demo...
echo ═══════════════════════════════════════════════════════════════════
%BERK_CMD% hpc_config_profiles.berk
echo.
goto :done

:run_basic
echo Running Basic Demo...
%BERK_CMD% hpc_basic_demo.berk
goto :done

:run_pubsub
echo Running Pub/Sub Demo...
%BERK_CMD% hpc_pubsub_demo.berk
goto :done

:run_benchmark
echo Running Benchmark Demo...
%BERK_CMD% hpc_benchmark_demo.berk
goto :done

:run_robot
echo Running Robot Control Demo...
%BERK_CMD% hpc_robot_control.berk
goto :done

:run_sensor
echo Running Sensor Fusion Demo...
%BERK_CMD% hpc_sensor_fusion.berk
goto :done

:run_config
echo Running Config Profiles Demo...
%BERK_CMD% hpc_config_profiles.berk
goto :done

:done
echo.
echo ╔══════════════════════════════════════════════════════════════════╗
echo ║                      DEMO(S) TAMAMLANDI                          ║
echo ╚══════════════════════════════════════════════════════════════════╝
