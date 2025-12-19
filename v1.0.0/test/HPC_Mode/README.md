# BERK-DDS HPC Mode Demos

Bu klasör BERK-DDS'in High Performance Computing (HPC) modunu gösteren demo ve test dosyalarını içerir.

##  HPC Mode Nedir?

BERK-DDS HPC Mode, **dünyada ilk** Hard Real-Time DDS kategorisinde yer alan bir implementasyondur.

### Özellikler

| Özellik | Açıklama |
|---------|----------|
| **Zero Allocation** | Hot path'te heap allocation yok |
| **Zero Memcpy** | Full zero-copy pipeline |
| **Pinned Core Execution** | CPU affinity ile deterministic scheduling |
| **Lock-Free Ring Buffers** | Cache-aligned, wait-free data structures |
| **Deterministic Pacing** | RT scheduler ile öngörülebilir latency |
| **CDR4/CDRX Serializer** | Ultra-fast custom serialization |

### Performans Hedefleri

| Metrik | Hedef | Garanti |
|--------|-------|---------|
| End-to-End Latency | < 10 μs | P99.99 |
| Jitter | < 1 μs | Deterministic |
| Throughput | > 10M msg/sec | Sustained |
| Memory Allocation | 0 | Hard guarantee |
| Cache Misses | < 0.1% | L1 optimized |

##  Dosya Yapısı

```
HPC_Mode/
├── README.md                    # Bu dosya
├── hpc_basic_demo.berk          # Temel HPC demo
├── hpc_pubsub_demo.berk         # Publisher/Subscriber demo
├── hpc_benchmark_demo.berk      # Performans benchmark demo
├── hpc_robot_control.berk       # Robot kontrolü senaryosu
├── hpc_sensor_fusion.berk       # Sensör füzyonu senaryosu
└── hpc_config_profiles.berk     # HPC yapılandırma profilleri
```

##  Çalıştırma

```powershell
# Demo çalıştır
cd C:\Projects\berk\berk-lang
.\target\debug\berk-lang.exe run ..\demos\HPC_Mode\hpc_basic_demo.berk

# Release modda derleme (gerçek performans için)
cargo build --release
.\target\release\berk-lang.exe run ..\demos\HPC_Mode\hpc_benchmark_demo.berk
```

##  Benchmark Sonuçları

### SPSC Ring Buffer (UltraSpscRing)
```
Batch Size vs Throughput:
  1:   16.8 M ops/sec
  8:   89.4 M ops/sec
  32: 134.2 M ops/sec
 128: 307.9 M ops/sec ✓ TARGET ACHIEVED
```

### Batched Atomics
```
Batch Size vs Speedup:
  baseline: 1.00x (221.79 M ops/sec)
  8:        3.45x (765.36 M ops/sec)
  128:      7.85x (1,740.71 M ops/sec) ✓ BEST
```

##  HPC Mode Profilleri

| Profil | Açıklama | Kullanım Alanı |
|--------|----------|----------------|
| `Standard` | Normal DDS operasyonu | Genel amaçlı |
| `LowLatency` | Minimum latency optimizasyonu | Finansal sistemler |
| `HighThroughput` | Maksimum bandwidth | Video streaming |
| `HardRealTime` | Deterministic garantiler | Endüstriyel kontrol |
| `Ultra` | Tüm optimizasyonlar | Kritik sistemler |

##  İlgili Dokümanlar

- [HPC_Mode_performans_optimizasyon.md](../../HPC_Mode_performans_optimizasyon.md)
- [EMBEDDED_SYSTEMS.md](../../EMBEDDED_SYSTEMS.md)
- [DDS API Documentation](../../berk-lang/src/dds/README.md)
