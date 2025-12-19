#!/usr/bin/env pwsh
# BERK Demo Test Runner
# Tüm demo dosyalarını çalıştırır ve sonuçları raporlar

$ErrorActionPreference = "Continue"

$demosDir = "C:\Projects\berk\demos"
$berkExe = "C:\Projects\berk\berk-vscode\bin\berk-lang.exe"
$reportFile = "$demosDir\demo_dosyası_raporu.md"

# Sonuç listeleri
$successTests = @()
$failedTests = @()

Write-Host "🧪 BERK Demo Testleri Çalıştırılıyor..." -ForegroundColor Cyan
Write-Host "=" * 60

# Tüm .berk dosyalarını bul
$berkFiles = Get-ChildItem -Path $demosDir -Filter "*.berk" -File | Sort-Object Name

$total = $berkFiles.Count
$current = 0

foreach ($file in $berkFiles) {
    $current++
    $testName = $file.Name
    
    Write-Host "`n[$current/$total] Test: $testName" -ForegroundColor Yellow
    
    # Testi çalıştır
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
        Write-Host "  ✅ BAŞARILI" -ForegroundColor Green
        $successTests += @{
            Name = $testName
            Output = $output.Trim()
        }
    } else {
        Write-Host "  ❌ BAŞARISIZ (Exit: $exitCode)" -ForegroundColor Red
        $failedTests += @{
            Name = $testName
            ExitCode = $exitCode
            Output = $output.Trim()
        }
    }
}

# Raporu oluştur
$report = @"
# BERK Demo Dosyaları Test Raporu

**Tarih:** $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
**Toplam Test:** $total
**Başarılı:** $($successTests.Count)
**Başarısız:** $($failedTests.Count)
**Başarı Oranı:** $([math]::Round(($successTests.Count / $total) * 100, 1))%

---

## ✅ Başarılı Testler ($($successTests.Count))

"@

foreach ($test in $successTests) {
    $report += "### $($test.Name)`n"
    $report += "``````"
    $report += "berk`n"
    $outputPreview = if ($test.Output.Length -gt 500) { $test.Output.Substring(0, 500) + "`n... (çıktı kısaltıldı)" } else { $test.Output }
    $report += "$outputPreview`n"
    $report += "```````n`n"
}

$report += @"

---

## ❌ Başarısız Testler ($($failedTests.Count))

"@

if ($failedTests.Count -eq 0) {
    $report += "*Tüm testler başarılı!*`n"
} else {
    foreach ($test in $failedTests) {
        $report += "### $($test.Name)`n"
        $report += "**Exit Code:** $($test.ExitCode)`n`n"
        $report += "**Hata Çıktısı:**`n"
        $report += "``````"
        $report += "`n$($test.Output)`n"
        $report += "```````n`n"
        
        # Hata nedenini analiz et
        $reason = "Bilinmeyen hata"
        
        if ($test.Output -match "Tanımsız modül fonksiyonu: (\S+)") {
            $reason = "Modül fonksiyonu bulunamadı: $($Matches[1])"
        }
        elseif ($test.Output -match "requires (\d+) arguments?") {
            $reason = "Yanlış argüman sayısı - $($Matches[0])"
        }
        elseif ($test.Output -match "Expected (\w+) for") {
            $reason = "Tip hatası - $($Matches[0])"
        }
        elseif ($test.Output -match "Sözdizimi hatası") {
            $reason = "Sözdizimi hatası"
        }
        elseif ($test.Output -match "Çalışma hatası: (.+)") {
            $reason = "Çalışma hatası: $($Matches[1])"
        }
        
        $report += "**Hata Nedeni:** $reason`n`n"
        $report += "---`n`n"
    }
}

$report += @"

## Özet

| Kategori | Sayı |
|----------|------|
| Toplam Test | $total |
| Başarılı | $($successTests.Count) |
| Başarısız | $($failedTests.Count) |
| Başarı Oranı | $([math]::Round(($successTests.Count / $total) * 100, 1))% |

### Test Edilen Modüller

- **Embedded:** Arduino, ESP32, STM32F4, RISC-V, BAL
- **Grafik/Medya:** Graphics, GUI, Image, Audio, CAD3D, Color
- **Veritabanı:** SQLite
- **XR:** VR/AR desteği
- **Temel:** Time, Module, Condition, Range

---

*Bu rapor otomatik olarak oluşturulmuştur.*
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
