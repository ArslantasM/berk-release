# BERK Savunma / Endüstri Whitepaper

Sürüm: 0.1
Tarih: 2025-12-18

## Yönetici Özeti

Modern savunma ve endüstriyel sistemler giderek daha fazla; güvenlik-kritik kontrol, heterojen işlem (CPU/GPU/ivmelendiriciler) ve dağıtık haberleşmeyi bir araya getiriyor. Geleneksel yaklaşımlar sorumlulukları bir RTOS çekirdeği, özel amaçlı middleware ve büyük uygulama çerçeveleri arasında bölüyor. Bu parçalanma entegrasyon riskini artırır: zamanlama ve zamanlayıcı (scheduling) özellikleri geç doğrulanır (çoğu zaman entegrasyondan sonra) ve düzeltici aksiyonlar pahalı hale gelir.

BERK, temel değer önerisi olarak RTOS tarzı semantiklerin (görev, öncelik, zamanlama ve iletişim kısıtları) **açık** ve **derleme zamanında doğrulanabilir** olmasını hedefleyen bir sistem programlama dilidir. BERK bir çekirdeğin yerini almaz; RTOS uygulamalarının nasıl ifade edildiğini ve doğrulandığını değiştirir.

Bu whitepaper, BERK yaklaşımını savunma ve endüstriyel alanlar için; determinism, analiz edilebilirlik, sertifikasyon hazırlığı ve yüksek bant genişlikli / düşük gecikmeli mesajlaşma odağında açıklar.

## Kapsam ve Hedef Kitle

Bu belge; savunma/endüstri gömülü sistemlerinde çalışan sistem mimarları, emniyet (safety) mühendisleri, platform liderleri ve entegrasyon ekiplerini hedefler.

Kapsam dışı: editör/IDE özellikleri, marketplace kurulumu ve geliştirici onboarding adımları.

## Profiller

BERK, farklı kısıt ve önceliklere sahip iki dağıtım profili ile en iyi şekilde anlatılır.

### Savunma Profili (Yüksek Güvence / Görev Sistemleri)

Amaç: analiz edilebilirliği, determinismi ve kanıt (evidence) üretilebilirliğini maksimize etmek.

Tipik kısıtlar:

- Güçlü determinism gereksinimleri ve sıkı zaman bütçeleri
- Kısıtlı dinamik davranış (allocation, reflection, deterministik olmayan runtime servisleri)
- Sıkı değişiklik kontrolü ve izlenebilirlik gereksinimleri

Önerilen karakteristikler:

- Sıcak yollarda allocation-sız çalışma (ve sertifikalı build’lerde tercihen program genelinde allocation-sız)
- Muhafazakâr eşzamanlılık topolojileri (SPSC fan-out, bounded kuyruklar)
- Bilinen mühendislik limitlerinin derleyici teşhisleriyle açıkça yüzeye çıkarılması

### Endüstri Profili (Otomasyon / Bağlanabilirlik / Kontrol)

Amaç: entegrasyon hızını ve protokol kapsamını maksimize ederken, kritik yerde deterministik kontrolü korumak.

Tipik kısıtlar:

- Karma kritiklik (hard real-time kontrol döngüsü + best-effort telemetri)
- Endüstriyel fieldbus/SCADA entegrasyon gereksinimleri
- Pratik sürdürülebilirlik ve sahada debug ihtiyacı

Önerilen karakteristikler:

- Bounded kuyruklarla deterministik control-plane görevleri
- Hedefe göre seçilen protokol modülleri (OPC-UA/MQTT/PROFINET/EtherCAT/CoAP)
- Kontrol döngüsü ile bağlanabilirlik/telemetri görevleri arasında net ayrım

## Problem Tanımı

Savunma ve endüstri ürünlerinde tekrarlayan mühendislik riskleri:

- Öncelik terslenmesi (priority inversion) ve zamanlama etkileşimleri genellikle entegrasyon veya saha testinde ortaya çıkar.
- Runtime davranışı allocation, contention veya deterministik olmayan scheduling’e bağlı olduğunda jitter artar.
- Karmaşık yazılım yığınları sertifikasyon kanıtlarını üretmeyi ve sürdürmeyi maliyetli hale getirir.
- Yüksek performanslı veri hareketi (sensör→füzyon, füzyon→kontrol) emniyet kısıtlarıyla yarışır.

Tekrarlayan kök sebep; kritik real-time varsayımların programlama modelince zorlanmak yerine, örtük şekilde (konvansiyonlar, konfig dosyaları, mimari slaytlar) kodlanmasıdır.

## BERK Yaklaşımı

BERK, RTOS semantiğini dil katmanına taşır:

- Görevler, olaylar ve iletişim desenleri birinci sınıf program yapılarıdır.
- Statik analiz; zamanlama ve öncelik riskleri için derleme zamanı teşhisleri üretir.
- Kooperatif bir nano runtime, ağır bir preemptive scheduler olmadan deterministik çalışmayı hedefler.
- Yüksek performanslı mesajlaşma yolu, allocation-sız hot path ile öngörülebilir throughput sunar.

## Mimari Genel Bakış

Yüksek seviyede:

1) Kaynak kod görevleri, olayları ve mesaj akışlarını ifade eder.
2) Derleme zamanı analizleri kısıtları doğrular (öncelik/zamanlama/iletişim riskleri).
3) Kod üretimi ve runtime glue deterministik bir yürütme modeli üretir.

Kavramsal akış:

```text
      BERK Kaynağı
          |
          v
  Derleme Zamanı Analizleri
  - öncelik kuralları
  - zamanlama kuralları
  - contention riskleri
          |
          v
  Nano Runtime + HPC Mesajlaşma
  - kooperatif scheduling
  - allocation-sız hot path
          |
          v
      Hedef Platform
  (MCU / SBC / bare-metal / RTOS-hosted)
```

## Determinism Modeli

BERK deterministik davranışı “tasarımla” güçlendirmeyi hedefler:

- Kooperatif runtime, scheduler kaynaklı nondeterminismi azaltır.
- Hot path’ler dinamik allocation olmadan tasarlanır.
- İletişim primitifleri analiz edilebilir olacak şekilde tasarlanır ve bilinen contention limitlerini görünür kılar.

## Emniyet ve Sertifikasyon Hazırlığı

BERK, arızaları daha erken evreye çekerek sertifikasyon odaklı iş akışlarını desteklemeyi hedefler:

- Derleme zamanı teşhisleri, kanıt zincirinin bir parçası olabilir (program yapılarıyla izlenebilir).
- Runtime küçük tutulur ve analiz edilebilirliğe göre tasarlanır.
- Allocation-sız hot path’ler runtime değişkenliğini azaltır.

Profil notu:

- Savunma Profili, kanıt ve kısıtlara (örn. allocation-sız build) öncelik verir.
- Endüstri Profili, entegrasyon ve bölümlendirmeye (hard real-time döngü, best-effort servislerden ayrılır) öncelik verir.

Not: Gerçek sertifikasyon; hedef programın kapsamına, seçilen profile, tool qualification stratejisine ve sistemin geliştirme sürecine bağlıdır.

## Yüksek Performanslı Mesajlaşma (HPC Modu)

BERK, düşük gecikmeli ve yüksek throughput’lu iletişim için bir HPC mesajlaşma yolu içerir.

Profil rehberi:

- Savunma Profili: contention’ı öngörülebilir tutmak için SPSC fan-out veya bounded kuyrukları tercih edin.
- Endüstri Profili: control-plane için bounded kuyruklar; gerekiyorsa unbounded desenleri kritik olmayan telemetriye ayırın.

### Ölçülen Mikro-Benchmark’lar

Aşağıdaki sonuçlar, mevcut geliştirme makinesinde (release build) ölçülmüş gerçek değerlerdir. Ölçümler mikro-benchmark’tır; CPU, bellek ve sistem yüküne göre değişebilir.

Benchmark yöntemi notları:

- SPSC testi, soğuk etkileri azaltmak için warm-up ve optimizasyonu engellemek için `black_box` kullanır.
- MPSC (4 producer) için cache-line contention sınırlaması beklenir.

| Metrik | Hedef | Ölçülen | Durum | Not |
|--------|-------|---------|-------|-----|
| SPSC Throughput | > 100M ops/s | 1,284M ops/s | Geçti | 12.8x hedefin üstünde |
| SPSC Gecikme (ortalama) | < 10 ns | 0.78 ns | Geçti | Sub-nanosecond |
| Bounded MPSC Throughput | > 50M ops/s | 567M ops/s | Geçti | 11.3x hedefin üstünde |
| Bounded MPSC Gecikme (ortalama) | < 50 ns | 1.76 ns | Geçti | Mükemmel |
| MPSC 4 Producer Throughput | > 50M ops/s (toplam) | 44.89M ops/s | Uyarı | Cache-line contention |
| MPSC Gecikme (ortalama) | < 50 ns | 22.27 ns | Geçti | İyi |
| Dinamik Allocation (hot path) | 0 | 0 | Geçti | Zero-allocation |
| Jitter | Düşük | Minimal | Geçti | Deterministik |

MPSC 4+ producer notu:

Toplam throughput düşüşü beklenen bir cache coherency kısıtıdır; hata değildir. Yüksek fan-in desenlerinde, veri akışına göre bounded MPSC veya SPSC fan-out topolojisi tercih edilmelidir.

### Yaygın Yaklaşımlara Göre Konumlandırma

Gösterim amaçlı karşılaştırma (büyüklük mertebesi rehberi):

| Teknoloji | Tipik Gecikme | Throughput | Not |
|----------|----------------|------------|-----|
| RDMA verbs | 1-7 ns | 200-400M/s | Donanım offload |
| BERK HPC | 0.78-22 ns | 45-1284M/s | Pure Rust, mikro-benchmark |
| DPDK | 5-15 ns | 100-250M/s | Kernel bypass |
| Aeron | 7-20 ns | 50-120M/s | Java + JNI |
| ZeroMQ | 50-200 ns | 10-30M/s | Genel amaçlı |

## Gömülü Platform Desteği

BERK, gömülü ve mixed-criticality ortamları hedefler. Platform entegrasyonu genellikle bir Donanım Soyutlama Katmanı (HAL) ve opsiyonel donanım köprü modülleri üzerinden ifade edilir.

Temsili platform aileleri:

- ESP32
- STM32
- Arduino sınıfı cihazlar
- RISC-V mikrodenetleyiciler ve SoC’lar
- Generic bare-metal profilleri

## Endüstriyel Bağlanabilirlik

Endüstriyel otomasyon çoğu zaman deterministik fieldbus ve telemetri entegrasyonu gerektirir. BERK, yaygın protokolleri desteklemeyi amaçlayan modüller içerir (tam mevcudiyet build profili ve hedefe bağlıdır):

- EtherCAT
- PROFINET
- OPC-UA
- MQTT
- CoAP

Profil notu:

- Savunma Profili genellikle dış bağlantıyı bir sınır (boundary) olarak ele alır ve sertifikalı çekirdekte protokol yüzeyini minimize eder.
- Endüstri Profili genellikle yukarıdaki protokollerden bir veya birkaçını birinci sınıf entegrasyon gereksinimi olarak içerir.

## Emniyet-Kritik AI Orkestrasyonu (CUIO)

BERK, edge dağıtımları için sertifikasyon odaklı bir inference orchestrator konsepti içerir:

- Statik planlanan bellek ve DMA
- Deterministik scheduling
- Pipeline yapısı için derleme zamanı doğrulama kancaları

Bu bölüm niyet ve yönü anlatır; sertifikasyon iddiaları program ve süreç bağımlıdır.

## Dağıtım Desenleri

Sistem seviyesinde yaygın dağıtımlar:

- Statik görev grafikleriyle bare-metal MCU kontrol döngüleri
- BERK’in uygulama-semantiklerini zorladığı RTOS-hosted entegrasyon
- İç pipeline’larda HPC mesajlaşma kullanan SBC/SoC sensör işleme düğümleri

Profil eşleme:

- Savunma Profili: statik görev grafikleri ve sıkı bölümlendirme (kontrol vs haberleşme). Harici I/O çoğunlukla küçük ve denetlenebilir bir boundary üzerinden mediate edilir.
- Endüstri Profili: RTOS-hosted entegrasyon ve protokol odaklı bağlanabilirlik; deterministik kontrol döngüsü telemetri’den izole edilir.

## Risk Kaydı (Mühendislik Gerçekliği)

BERK, bilinen performans ve determinism limitlerini gizlemek yerine görünür kılar:

- 4+ producer MPSC, çoğu cache-coherent CPU’da contention ile sınırlıdır.
- Mikro-benchmark sonuçları platforma bağımlıdır; hedef başına yeniden doğrulanmalıdır.
- Sertifikasyon hazırlığı, tanımlı bir tool qualification ve geliştirme süreci gerektirir.

Profile özel riskler:

- Savunma Profili: kontrolsüz “feature creep” (ek runtime servisleri) kanıt üretimini ve analiz edilebilirliği zedeler.
- Endüstri Profili: telemetri/kolaylık görevlerini kontrol döngüsüne karıştırmak; contention ve backpressure üzerinden jitter’i geri getirebilir.

## Sonuç

BERK, savunma ve endüstriyel sistemlerde entegrasyon riskini azaltmayı; RTOS semantiğini açık ve derleme zamanında doğrulanabilir hale getirerek, küçük deterministik bir runtime ve yüksek throughput’lu bir mesajlaşma yolu sunarak hedefler. Sonuç; hem analiz edilebilirliği hem performansı destekleyen, mühendislik limitlerini en baştan açıkça ifade eden bir programlama modelidir.
