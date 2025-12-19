#!/usr/bin/env pwsh
# BERK Demo Test Runner
# Tum demo dosyalarini calistirir ve sonuclari raporlar

$ErrorActionPreference = "Continue"
$OutputEncoding = [System.Text.Encoding]::UTF8

$demosDir = "C:\Projects\berk\demos"
$berkExe = "C:\Projects\berk\berk-vscode\bin\berk-lang.exe"
$reportFile = "$demosDir\demo_dosyasi_raporu.md"

# Sonuc listeleri
$successTests = @()
$failedTests = @()

Write-Host ""
Write-Host "BERK Demo Testleri Calistiriliyor..." -ForegroundColor Cyan
Write-Host ("=" * 60) -ForegroundColor Cyan

# Tum .berk dosyalarini bul (alt klasorler dahil)
$berkFiles = Get-ChildItem -Path $demosDir -Filter "*.berk" -File -Recurse | Sort-Object FullName

$total = $berkFiles.Count
$current = 0

foreach ($file in $berkFiles) {
    $current++
    $testName = $file.FullName.Replace($demosDir + "\", "")
    
    Write-Host ""
    Write-Host "[$current/$total] Test: $testName" -ForegroundColor Yellow
    
    # Testi calistir
    $output = ""
    $exitCode = 0
    
    try {
        $process = Start-Process -FilePath $berkExe -ArgumentList "run", $file.FullName -WorkingDirectory $demosDir -NoNewWindow -Wait -PassThru -RedirectStandardOutput "$env:TEMP\berk_stdout.txt" -RedirectStandardError "$env:TEMP\berk_stderr.txt"
        $exitCode = $process.ExitCode
        
        $stdout = Get-Content "$env:TEMP\berk_stdout.txt" -Raw -ErrorAction SilentlyContinue
        $stderr = Get-Content "$env:TEMP\berk_stderr.txt" -Raw -ErrorAction SilentlyContinue
        
        $output = if ($stdout) { $stdout } else { "" }
        if ($stderr) { $output += "`nSTDERR: $stderr" }
        
    } catch {
        $exitCode = 1
        $output = "Exception: $_"
    }
    
    if ($exitCode -eq 0) {
        Write-Host "  [OK] BASARILI" -ForegroundColor Green
        $successTests += @{
            Name = $testName
            Output = $output.Trim()
        }
    } else {
        Write-Host "  [X] BASARISIZ (Exit: $exitCode)" -ForegroundColor Red
        $failedTests += @{
            Name = $testName
            ExitCode = $exitCode
            Output = $output.Trim()
        }
    }
}

# Raporu olustur
$successRate = 0
if ($total -gt 0) {
    $successRate = [math]::Round(($successTests.Count / $total) * 100, 1)
}

$report = @"
# BERK Demo Dosyalari Test Raporu

**Tarih:** $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
**Toplam Test:** $total
**Basarili:** $($successTests.Count)
**Basarisiz:** $($failedTests.Count)
**Basari Orani:** $successRate%

---

## Basarili Testler ($($successTests.Count))

"@

foreach ($test in $successTests) {
    $report += "### $($test.Name)`n`n"
    $outputPreview = if ($test.Output.Length -gt 500) { $test.Output.Substring(0, 500) + "`n... (cikti kisaltildi)" } else { $test.Output }
    if ($outputPreview) {
        $report += "``````text`n$outputPreview`n```````n`n"
    } else {
        $report += "*Cikti yok*`n`n"
    }
}

$report += @"

---

## Basarisiz Testler ($($failedTests.Count))

"@

if ($failedTests.Count -eq 0) {
    $report += "*Tum testler basarili!*`n"
} else {
    foreach ($test in $failedTests) {
        $report += "### $($test.Name)`n`n"
        $report += "**Exit Code:** $($test.ExitCode)`n`n"
        $report += "**Hata Ciktisi:**`n"
        $report += "``````text`n$($test.Output)`n```````n`n"
        
        # Hata nedenini analiz et
        $reason = "Bilinmeyen hata"
        
        if ($test.Output -match "Tanimsiz mod") {
            $reason = "Modul fonksiyonu bulunamadi"
        }
        elseif ($test.Output -match "requires (\d+) arguments?") {
            $reason = "Yanlis arguman sayisi"
        }
        elseif ($test.Output -match "Expected (\w+) for") {
            $reason = "Tip hatasi"
        }
        elseif ($test.Output -match "syntax|parse|Sozdizimi") {
            $reason = "Sozdizimi hatasi"
        }
        elseif ($test.Output -match "runtime|Calisma hatasi") {
            $reason = "Calisma zamani hatasi"
        }
        
        $report += "**Hata Nedeni:** $reason`n`n"
        $report += "---`n`n"
    }
}

$report += @"

## Ozet

| Kategori | Sayi |
|----------|------|
| Toplam Test | $total |
| Basarili | $($successTests.Count) |
| Basarisiz | $($failedTests.Count) |
| Basari Orani | $successRate% |

### Test Edilen Moduller

- **Embedded:** Arduino, ESP32, STM32F4, RISC-V, BAL
- **Grafik/Medya:** Graphics, GUI, Image, Audio, CAD3D, Color
- **Veritabani:** SQLite
- **XR:** VR/AR destegi
- **Temel:** Time, Module, Condition, Range

---

*Bu rapor otomatik olarak olusturulmustur.*
"@

# Raporu kaydet
$report | Out-File -FilePath $reportFile -Encoding UTF8

Write-Host ""
Write-Host ("=" * 60) -ForegroundColor Cyan
Write-Host "Test Ozeti:" -ForegroundColor Cyan
Write-Host "  Toplam: $total" -ForegroundColor White
Write-Host "  Basarili: $($successTests.Count)" -ForegroundColor Green
Write-Host "  Basarisiz: $($failedTests.Count)" -ForegroundColor Red
Write-Host ""
Write-Host "Rapor kaydedildi: $reportFile" -ForegroundColor Yellow
