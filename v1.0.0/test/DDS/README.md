# BERK DDS Demos

Bu klasör BERK dilinin **DDS (Data Distribution Service)** yeteneklerini gösteren demo dosyalarını içerir.

##  BERK-DDS: Türkçe Real-Time Messaging

BERK, **dünyada ilk Türkçe sözdizimli DDS implementasyonu**nu sunar.

### Türkçe DDS Anahtar Kelimeleri

| Türkçe | English | Açıklama |
|--------|---------|----------|
| `katılımcı` | participant | DDS Domain Participant |
| `konu` | topic | DDS Topic |
| `yayıncı` | publisher | DDS Publisher |
| `abone` | subscriber | DDS Subscriber |
| `güvenilir` | reliable | Reliable QoS |
| `elinden_gelen` | best_effort | Best Effort QoS |
| `geçmiş` | history | History QoS depth |
| `kalıcı` | transient_local | Durability QoS |

##  Demo Dosyaları

### Başlangıç Seviyesi
| Dosya | Açıklama |
|-------|----------|
| [01_ilk_dds.berk](01_ilk_dds.berk) | İlk DDS uygulaması - Temel kavramlar |
| [02_qos_profilleri.berk](02_qos_profilleri.berk) | QoS profilleri ve kullanımları |

### Orta Seviye
| Dosya | Açıklama |
|-------|----------|
| [03_akilli_ev.berk](03_akilli_ev.berk) | Akıllı ev otomasyon senaryosu |
| [04_trafik_izleme.berk](04_trafik_izleme.berk) | Şehir trafik izleme sistemi |

### İleri Seviye
| Dosya | Açıklama |
|-------|----------|
| [05_otonom_arac.berk](05_otonom_arac.berk) | Otonom araç sensör füzyonu |
| [06_fabrika_otomasyon.berk](06_fabrika_otomasyon.berk) | Endüstri 4.0 fabrika otomasyonu |
| [07_drone_filosu.berk](07_drone_filosu.berk) | Çoklu drone koordinasyonu |

##  Çalıştırma

### Önerilen Yöntem (Doğrudan Çalıştırma)
```powershell
# En iyi Türkçe karakter ve emoji desteği için
cd C:\Projects\berk\demos\DDS
berk-lang.exe run 01_ilk_dds.berk
```

### REPL ile Çalıştırma
```powershell
# REPL ile çalıştır
cd C:\Projects\berk\berk-lang
echo '%run ..\demos\DDS\01_ilk_dds.berk' | .\target\release\berk-repl.exe
```

### ⚠️ PowerShell Encoding Sorunu

REPL'i pipe (`|`) ile kullanırken Türkçe karakterler bozuk görünebilir. Bu PowerShell'in varsayılan encoding'inin UTF-16 olmasından kaynaklanır.

**Çözüm 1:** Doğrudan `berk-lang.exe run` kullanın (önerilen)

**Çözüm 2:** PowerShell encoding'ini ayarlayın:
```powershell
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
echo '%run 01_ilk_dds.berk' | berk-repl.exe
```

**Çözüm 3:** PowerShell profilinize kalıcı olarak ekleyin:
```powershell
# $PROFILE dosyasına ekleyin:
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
```

##  Öğrenme Yolu

```
1. 01_ilk_dds.berk          → DDS temelleri
   ↓
2. 02_qos_profilleri.berk   → QoS kavramları
   ↓
3. 03_akilli_ev.berk        → Gerçek dünya uygulaması
   ↓
4. 04_trafik_izleme.berk    → Büyük ölçekli sistem
   ↓
5. 05_otonom_arac.berk      → Kritik sistem tasarımı
   ↓
6. 06_fabrika_otomasyon.berk→ Endüstriyel IoT
   ↓
7. 07_drone_filosu.berk     → Dağıtık koordinasyon
```

##  Performans

BERK-DDS, HPC Mode ile aşağıdaki performans hedeflerini karşılar:

| Metrik | Değer |
|--------|-------|
| Throughput | 307+ M ops/sec |
| Latency P99.99 | < 10 μs |
| Zero Allocation | ✓ Garantili |
