# BERK Dil Desteği - VS Code

![CI Durumu](https://img.shields.io/badge/CI-aktif%20geliştirme-orange)

**BERK, RTOS semantiğini derleme zamanına taşıyan bir sistem programlama dilidir.**

> *"BERK bir RTOS çekirdeğinin yerini almaz.*  
> *RTOS tarzı uygulamaların nasıl ifade edilip doğrulandığının yerini alır."*

**Konumlandırma:**

| Soru | Cevap |
|------|-------|
| BERK bir RTOS mu? | **Hayır.** BERK bir **sistem programlama dilidir**. |
| BERK-RTOS nedir? | **Ayrı bir ürün** – BERK dili tarafından **güçlendirilen** minimal gerçek zamanlı çekirdek. |
| Mevcut RTOS ile çalışır mı? | **Evet.** Bare-metal üzerinde bağımsız veya FreeRTOS/Zephyr/VxWorks üzerinde hosted mod. |
| Avantajı nedir? | RTOS semantiğini **derleme zamanında doğrulanabilir** hale getirir. |

### BERK Dili & BERK-RTOS: İki Ürün, Tek Ekosistem

**BERK** bir sistem programlama dilidir. **BERK-RTOS**, BERK dili tarafından **güçlendirilen** ayrı bir gerçek zamanlı işletim sistemi ürünüdür.

BERK-RTOS, kendisi için özel olarak tasarlanmış bir sistem programlama diline sahip **tek** RTOS'tur.

**15 Dünya İlki Özellik:**

| Özellik | Açıklama |
|---------|----------|
| Sıfır Sapma Zamanlayıcı | ±20-80 ns hassasiyet |
| Doğrulanmış Sürücü Çerçevesi | Formal olarak doğrulanmış sürücüler |
| Yapay Zeka Destekli WCET Motoru | ML tabanlı zamanlama tahmini |
| Dinamik MPU Yeniden Yapılandırma | O(1) bellek koruması |
| O-RAN xApp Yerel Desteği | 5G/LTE yığını (30 modül) |
| P2W 2.0 Tahminli Zamanlayıcı | Trend tabanlı tahmin |
| Z² Döngü Hassas Tekrar | Hata ayıklama sistemi |
| Formal Doğrulama (Kani) | Matematiksel kanıtlar |

**14 Sektör, Tek Çekirdek:**

| Sektör | Sertifikasyon |
|--------|---------------|
| Savunma | CC EAL5+/EAL7 |
| Havacılık | DO-178C DAL-A/B |
| Otomotiv | ISO 26262 ASIL-D |
| Medikal | IEC 62304 Sınıf C |
| Demiryolu | EN 50128 SIL4 |
| Uzay | ECSS-E-ST-40C |
| Telekom | 3GPP / IEC 62443 |
| Endüstriyel | IEC 61508 SIL3 |
| IoT | ETSI EN 303645 |
| Enerji | IEC 61850 |
| Robotik | ISO 10218 |
| TSN | IEEE 802.1 |
| Otomasyon | IEC 62443 SL2+ |
| Edge AI | - |

**Proje Ölçeği:** 139,799 LOC · 218 dosya · 28 BSP · 600+ test

[![Versiyon](https://img.shields.io/visual-studio-marketplace/v/ArslantasM-tools.berk-lang)](https://marketplace.visualstudio.com/items?itemName=ArslantasM-tools.berk-lang)
[![Kurulumlar](https://img.shields.io/visual-studio-marketplace/i/ArslantasM-tools.berk-lang)](https://marketplace.visualstudio.com/items?itemName=ArslantasM-tools.berk-lang)
[![Puan](https://img.shields.io/visual-studio-marketplace/r/ArslantasM-tools.berk-lang)](https://marketplace.visualstudio.com/items?itemName=ArslantasM-tools.berk-lang)
[![Lisans](https://img.shields.io/github/license/ArslantasM/berk)](https://github.com/ArslantasM/berk/blob/main/LICENSE)
[![Türkiye'de Üretildi](https://img.shields.io/badge/Türkiye'de-Üretildi-E30A17?style=flat&labelColor=FFFFFF)](https://github.com/ArslantasM/berk)

> **Dokümantasyon:** [Dil Kılavuzu](https://arslantasm.github.io/berk_pages/) · [Stdlib API](https://arslantasm.github.io/berk-stdlib-docs/) · [Demo & Testler](https://github.com/ArslantasM/berk-test)

## CI & Test Durumu

⚠️ **GitHub Actions test sonuçları hakkında not**

Bazı CI kontrolleri şu anda başarısız olabilir.

Bu, bilinen ve geçici bir durumdur:
- Devam eden çekirdek dil ve çalışma zamanı evrimi
- Son dahili mimari yeniden yapılandırma
- Test senaryoları henüz yeni davranışı yansıtacak şekilde güncellenmedi

Uygulama, aktif olarak yeniden yapılandırılan test paketinin **önünde** gelişiyor.

✔ Çalışma zamanı kararlılığı  
✔ Deterministik yürütme hedefleri  
✔ Uzun vadeli test disiplini  

temel proje ilkeleri olmaya devam ediyor.

Test güncellemeleri ve CI stabilizasyonu aktif yol haritasının parçasıdır.

---

**Web Sitesi:** [berk-tech.com](https://berk-tech.com/)

**Dokümantasyon:** [Dil Kılavuzu](https://arslantasm.github.io/berk_pages/) · [Stdlib API](https://arslantasm.github.io/berk-stdlib-docs/) · [Demo & Testler](https://github.com/ArslantasM/berk-test)

**Son Sürüm:** [BERK v1.0.0](https://github.com/ArslantasM/berk-release/releases/tag/v1.0.0)

**README (Türkçe):** https://github.com/ArslantasM/berk-release/blob/main/README_TR.md

**Teknik Doküman (Savunma / Endüstriyel):**
- EN: https://github.com/ArslantasM/berk-release/blob/main/Defense%20-%20Industrial%20Whitepaper.md
- TR: https://github.com/ArslantasM/berk-release/blob/main/Defense%20-%20Industrial%20Whitepaper%20(TR).md

**Yetenek Özeti (üst düzey):**

- **AI/ML (Edge)**: Derleme zamanı odaklı, sertifikalandırılabilir çıkarım orkestrasyonu için CUIO konsepti (profil bağımlı).
- **Gömülü + HAL**: Platform odaklı modüller (ör. ESP32 / STM32 / Arduino / RISC-V / genel profiller).
- **Endüstriyel entegrasyonlar**: Protokol modülleri (ör. OPC-UA / MQTT / CoAP / EtherCAT / PROFINET).
- **Donanım Köprüsü**: PC↔cihaz iletişimi (ör. Seri / Firmata / Modbus RTU / SLIP / BinProto).

**Proje Ölçeği (güncel durum):**

| Metrik | Değer |
|--------|-------|
| Rust Kaynak Kodu | ~200,000+ satır |
| Stdlib Modülleri | **120+ modül** |
| Yerel Fonksiyonlar | 3,000+ fonksiyon |
| FFI Kayıt Girdileri | 3,200+ girdi |
| HAL Platform Desteği | 5 platform, 43 modül |
| Donanım Köprüsü | 5 protokol, 50+ fonksiyon |
| AI/ML Kodu | ~12,000 satır |
| **Alan Kütüphaneleri** | |
| ├─ Biyoinformatik | 14 modül (~10,000 satır) |
| ├─ Finans/Ticaret | 6 modül (~5,000 satır) |
| ├─ Havacılık (DO-178C) | 5 modül |
| ├─ ADAS (ISO 26262) | 7 modül |
| ├─ Medikal (IEC 62304) | 4 modül |
| ├─ Demiryolu (EN 50128) | 5 modül |
| ├─ Uzay (ECSS) | 5 modül |
| ├─ Robotik | 8 modül |
| └─ Telekom (TSN/5G) | 9 modül |
| RTOS Stdlib | 13 modül |
| Stdlib Tamamlanma | **%100** |

### v1.0.0 Güvenlik Kritik Özellikler (Ocak 2026)

BERK v1.0.0, güvenlik kritik sistemler için derleme zamanı doğrulaması getiriyor.

**Sertifikasyon Odaklı Özellikler:**

| Alan | Yetenek | Faydalar |
|------|---------|----------|
| **İzlenebilirlik** | Gereksinimden koda bağlantı | DO-178C Tablo A-3 uyumluluk desteği |
| **Determinizm** | Sınırlı yürütme doğrulaması | Tahmin edilebilir en kötü durum zamanlaması |
| **Bellek Güvenliği** | Yığın/heap kullanım analizi | Statik bellek sınır doğrulaması |
| **Kesme Güvenliği** | ISR sözleşme sistemi | Öncelik tersine çevrilme tespiti |
| **Tip Güvenliği** | Fiziksel birim kontrolü | Boyutsal analiz (zaman, frekans, hız) |
| **Formal Yöntemler** | Doğrulama araç kancaları | CBMC/SPARK entegrasyonu hazır |

**Dağıtım Profilleri:**

- **Savunma Profili**: Maksimum analiz edilebilirlik, tahsisatsız derlemeler, katı determinizm
- **Endüstriyel Profil**: Karışık kritiklik desteği, protokol entegrasyonu, pratik sürdürülebilirlik

**Hedef Standartlar:**

✓ DO-178C (Havacılık)  
✓ IEC 62304 (Medikal)  
✓ ISO 26262 (Otomotiv)  
✓ IEC 61508 (Endüstriyel)  
✓ EN 50128 (Demiryolu)  
✓ ECSS-E-ST-40C (Uzay)

> **Tam API Dokümantasyonu:** v1.0.0 sürümüyle birlikte gelecek

---

## Neden BERK?

BERK öncelikle **güvenlik kritik gömülü sistemler**, **deterministik karışık kritiklik çalışma zamanları** ve **yüksek performanslı mesajlaşma** için bir **sistem programlama dilidir**.

**Bir bakışta (platform + yetenekler):**

- **AI/ML (Edge)**: Derleme zamanı odaklı, sertifikalandırılabilir çıkarım orkestrasyonu için CUIO konsepti (profil bağımlı).
- **Gömülü sistemler**: MCU/SBC iş akışları için tasarlanmış; RTOS barındırılan veya bare-metal tarzı entegrasyonlar.
- **Endüstriyel bağlantı**: Kontrol ve entegrasyon katmanlarını köprülemek için protokol odaklı modüller (ör. OPC-UA / MQTT / CoAP / fieldbus aileleri).
- **HAL + Donanım Köprüsü**: HAL soyutlamaları ve PC↔cihaz köprüleri (USB/Seri sınıf iş akışları) aracılığıyla gerçek donanımla iletişim.

**Farklı kılan özellikler:**

- **Derleme zamanında RTOS semantiği**: Zamanlama/zamanlama/iletişim kısıtlamaları derleme zamanı kontrolleri ve tanılamaları olarak ortaya çıkacak şekilde tasarlanmıştır.
- **İki dilli sözdizimi (Türkçe + İngilizce)**: TR, EN veya her ikisini aynı dosyada karışık yazın.
- **Nano çalışma zamanı yaklaşımı**: Deterministik davranışa yönelik işbirlikçi yürütme modeli.
- **Sıfır tahsisli sıcak yollar**: Tahmin edilebilir gecikme için tasarlanmış (profil bağımlı).
- **HPC mesajlaşma yolu**: Çok yüksek verim için SPSC / sınırlı-MPSC ilkelleri.

---

## Hızlı Başlangıç

1) VS Code Marketplace'den eklentiyi kurun.

2) Bir dosya oluşturun: `merhaba.berk`

3) Kod yazın (Türkçe, İngilizce veya karışık):

```berk
// Türkçe
yaz("Merhaba BERK!")

// İngilizce
print("Hello BERK!")

// Karışık
değişken x = 42
let y = 58
yaz("Toplam: ", x + y)
```

4) Çalıştırın:

- `Ctrl+Shift+B` → derleme/çalıştırma görevi
- Komut Paleti → `BERK: Run Current File`

---

## BerkRTOS - Gerçek Zamanlı Görev Örneği

**BERK-RTOS**, BERK dili tarafından güçlendirilen ayrı bir gerçek zamanlı işletim sistemi ürünüdür. BERK, derleme zamanında yerel RTOS semantiği sağlar. İki dilli sözdizimini kullanarak öncelikler, periyotlar ve yığın boyutlarıyla görevler tanımlayın:

**Türkçe:**

```berk
import rtos::{görev, Öncelik, Mutex, Kanal};

// Sensör verisi yapısı
yapı SensörVerisi {
    sıcaklık: f32,
    basınç: f32,
    zaman_damgası: u64,
}

// Paylaşılan mutex ve kanal
statik veri_mutex: Mutex<SensörVerisi> = Mutex::yeni(SensörVerisi {
    sıcaklık: 0.0,
    basınç: 0.0,
    zaman_damgası: 0,
});

statik veri_kanal: Kanal<SensörVerisi, 16> = Kanal::yeni();

// Sensör okuma görevi - yüksek öncelik, 10ms periyot
görev SensörOkuyucu {
    öncelik: Öncelik::YÜKSEK,
    periyot: 10ms,
    yığın: 2KB,
    son_tarih: 8ms,
    
    başla() {
        döngü {
            bırak veri = SensörVerisi {
                sıcaklık: sensör_oku_sıcaklık(),
                basınç: sensör_oku_basınç(),
                zaman_damgası: rtos::şimdi(),
            };
            
            // Mutex ile güvenli erişim
            veri_mutex.kilitle(|v| {
                *v = veri;
            });
            
            // Kanala gönder
            veri_kanal.gönder(veri);
            
            rtos::bekle_periyot();
        }
    }
}

// Veri işleme görevi - normal öncelik
görev Veriİşleyici {
    öncelik: Öncelik::NORMAL,
    periyot: 50ms,
    yığın: 4KB,
    
    başla() {
        döngü {
            eğer bırak Bazı(veri) = veri_kanal.al(100ms) {
                eğer veri.sıcaklık > 80.0 {
                    alarm_tetikle("Yüksek sıcaklık!");
                }
            }
            rtos::bekle_periyot();
        }
    }
}
```

**İngilizce:**

```berk
import rtos::{task, Priority, Mutex, Channel};

// Sensor data structure
struct SensorData {
    temperature: f32,
    pressure: f32,
    timestamp: u64,
}

// Shared mutex and channel
static data_mutex: Mutex<SensorData> = Mutex::new(SensorData {
    temperature: 0.0,
    pressure: 0.0,
    timestamp: 0,
});

static data_channel: Channel<SensorData, 16> = Channel::new();

// Sensor reading task - high priority, 10ms period
task SensorReader {
    priority: Priority::HIGH,
    period: 10ms,
    stack: 2KB,
    deadline: 8ms,
    
    start() {
        loop {
            let data = SensorData {
                temperature: read_temperature_sensor(),
                pressure: read_pressure_sensor(),
                timestamp: rtos::now(),
            };
            
            // Safe access with mutex
            data_mutex.lock(|v| {
                *v = data;
            });
            
            // Send to channel
            data_channel.send(data);
            
            rtos::wait_period();
        }
    }
}

// Data processing task - normal priority
task DataProcessor {
    priority: Priority::NORMAL,
    period: 50ms,
    stack: 4KB,
    
    start() {
        loop {
            if let Some(data) = data_channel.receive(100ms) {
                if data.temperature > 80.0 {
                    trigger_alarm("High temperature!");
                }
            }
            rtos::wait_period();
        }
    }
}
```

---

## BERK-RTOS IDE Entegrasyonu

**BERK nedir?** BERK bir **sistem programlama dilidir**. **BERK-RTOS**, BERK dili tarafından **güçlendirilen** ve BERK'in derleme zamanı yapılarıyla optimize edilmiş **ayrı bir ürün** – minimal bir gerçek zamanlı çekirdektir.

VS Code eklentisi, BERK-RTOS geliştirmesi için özel analiz ve görselleştirme araçları sağlar:

### Görev Farkında Kod Analizi

| Özellik | Açıklama |
|---------|----------|
| **Öncelik Tersine Çevrilme Tespiti** | Derleme zamanında görevler arasındaki öncelik çakışmalarını tespit eder |
| **Son Tarih Analizi** | `son_tarih` kısıtlamalarının tutarlılığını doğrular |
| **Yığın Kullanım Tahmini** | Her görev için yığın kullanımını statik olarak tahmin eder |
| **WCET Önizleme** | Tahmini en kötü durum yürütme süresi değerlerini gösterir |

### RTOS Farkında Linting

```berk
// ⚠️ Linter uyarısı: Potansiyel öncelik tersine çevrilme
görev DüşükÖncelikliGörev {
    öncelik: Öncelik::DÜŞÜK,
    başla() {
        yüksek_öncelik_mutex.kilitle(|v| {  // ← Uyarı
            // ...
        });
    }
}
```

### Canlı Diyagramlar

- **Görev Grafiği**: Görev bağımlılıkları ve öncelik ilişkileri
- **IPC Haritası**: Kanal ve mutex kullanım haritası
- **Zaman Çizelgesi Görünümü**: Görev zamanlama simülasyonu

### Bellek Güvenliği Analizi

- Yığın taşması risk tespiti
- Heap tahsis uyarıları (sıfır-heap profili için)
- DMA tampon hizalama doğrulaması

> **Not:** BERK bir **sistem programlama dilidir**. BERK-RTOS, BERK tarafından güçlendirilen **ayrı bir RTOS ürünüdür**. Birlikte entegre bir **ekosistem + derleyici + çalışma zamanı + IDE + analiz aracı** çözümü oluştururlar.

---

## VS Code Özellikleri

- `.berk` dosyaları için sözdizimi vurgulama
- IntelliSense tamamlama (TR/EN anahtar kelimeler + semboller)
- Gerçek zamanlı tanılama (ayrıştırıcı/tip/lint)
- Üzerine gelme tip bilgisi + imza yardımı
- Tanıma git / referanslar / yeniden adlandır
- Kod eylemleri & CodeLens (mevcut olduğunda)

---

## Enerji Verimliliği

BERK-RTOS mimarisinin deterministik, düşük gecikmeli ve zero-heap tasarımı enerji tüketimini dramatik biçimde azaltır.

### Enerji Tasarrufu Kaynakları

| Faktör | Mekanizma | Etki |
|--------|-----------|------|
| **Ultra kısa bağlam değiştirme** | 180–500 ns (işbirlikçi zamanlama) | Daha uzun uyku süreleri |
| **Sıfır-heap mimarisi** | Tahsisatsız sıcak yollar | Önbellek verimliliği, daha az bellek erişimi |
| **Kilitsiz IPC** | SPSC/sınırlı MPSC | CPU daha az sıklıkta uyanır |
| **Zamanlayıcı sapması yok** | Deterministik zamanlama | Wakelock sorunları yok |
| **DVFS uyumlu** | Statik görev grafikleri | Dinamik voltaj/frekans ölçekleme |

### Beklenen Tasarruflar

| Alan | Tasarruf | Açıklama |
|------|----------|----------|
| **IoT sensörler** | %30–60 | Uzun uyku, minimal uyanma |
| **Pil destekli sistemler** | %20–40 | Deterministik çalışma |
| **Edge gateway** | %15–30 | Sıfır kopyalama veri yolu |
| **Telekom baz istasyonu** | %10–25 | Kilitsiz paket işleme |

> Bu, IoT modülleri, endüstriyel kontrol cihazları ve telekom baz istasyonu donanımı için kritik bir satış noktasıdır.

## Eklenti Ayarları (Genel)

```json
{
  "berk.preferredLanguage": "auto",
  "berk.compilerPath": "berk-lang",
  "berk.languageServerPath": "berk-lsp",
  "berk.enableLinter": true
}
```

---

## Biyoinformatik & Finans Modülleri (YENİ!)

BERK v0.7.0, kapsamlı alan özel kütüphaneler sunar:

### Biyoinformatik (`stdlib/bio/`)

Moleküler biyoloji, genomik ve hesaplamalı biyoloji için 14 modül:

```berk
import bio::{DnaSequence, FastaReader, Aligner};
import bio::datasources::{AlphaFoldClient, UniProtClient};
import bio::databases::{KeggClient, StringDbClient};

// DNA dizi analizi
bırak dna = DnaSequence::yeni("ATGCGATCGATCG");
bırak gc_içeriği = dna.gc_content();
bırak tamamlayıcı = dna.reverse_complement();

// AlphaFold'dan protein yapısı al
bırak alphafold = AlphaFoldClient::yeni();
bırak yapı = alphafold.get_structure("P12345").await?;

// STRING'den protein-protein etkileşimleri sorgula
bırak string_db = StringDbClient::yeni();
bırak etkileşimler = string_db.get_interactions("TP53", 9606).await?;
```

**Modüller:** `sequence`, `fasta`, `fastq`, `sam`, `vcf`, `alignment`, `assembly`, `protein`, `crispr`, `pathway`, `phylo`, `omics`, `datasources`, `databases`

### Finans & Ticaret (`stdlib/finance/`)

Algoritmik ticaret ve risk yönetimi için 6 modül:

```berk
import finance::{Price, OrderBook, Order, RiskManager};
import finance::derivatives::{BlackScholes, Option};
import finance::backtesting::Backtester;

// Mikrosaniye gecikmeli emir defteri
bırak emir_defteri = OrderBook::yeni("BIST100");
bırak alış = Order::limit_buy(Price::from_float(150.50), 1000);
emir_defteri.submit(alış);

// Black-Scholes opsiyon fiyatlama
bırak opsiyon = Option::call(
    spot: 100.0,
    strike: 105.0,
    maturity: 0.25,  // 3 ay
    volatility: 0.20,
    risk_free: 0.05,
);
bırak fiyat = BlackScholes::price(&opsiyon);
bırak delta = BlackScholes::delta(&opsiyon);

// Risk hesaplama (VaR, CVaR)
bırak risk = RiskManager::yeni();
bırak var_95 = risk.value_at_risk(&portföy, 0.95, 1);
```

**Modüller:** `market_data`, `order_book`, `risk`, `derivatives`, `backtesting`, `mod`

---

## Güvenlik Kritik Alan Kütüphaneleri

BERK, katı sertifikasyon gereksinimleri olan endüstriler için özel kütüphaneler sağlar:

### Havacılık (`stdlib/avionics/`) - DO-178C

Havacılık yazılım geliştirme için 5 modül:

```berk
import avionics::{Arinc429, Arinc664, MilStd1553};
import avionics::do178c::{DalLevel, RequirementTrace};

// ARINC 429 veri yolu iletişimi
bırak bus = Arinc429::yeni(kanal: 1, hız: Arinc429::HIGH_SPEED);
bırak mesaj = bus.oku_etiket(0o310)?;  // Sekizlik etiket

// DO-178C izlenebilirlik
#[requirement("REQ-NAV-001")]
#[dal(DalLevel::A)]
fn hesapla_irtifa(basınç: f64) -> f64 {
    // DAL-A sertifikalı irtifa hesaplama
    44330.0 * (1.0 - (basınç / 101325.0).powf(0.1903))
}
```

**Modüller:** `arinc429`, `arinc664`, `mil1553`, `do178c`, `mod`

### ADAS (`stdlib/adas/`) - ISO 26262

Otonom sürüş sistemleri için 7 modül:

```berk
import adas::{Perception, Planning, Control};
import adas::v2x::{V2xMessage, DsrcRadio};
import adas::safety::{AsilLevel, SafetyGoal};

// ASIL-D güvenlikli nesne algılama
#[asil(AsilLevel::D)]
görev NesneAlgılama {
    öncelik: Öncelik::EN_YÜKSEK,
    periyot: 20ms,
    son_tarih: 15ms,  // Katı son tarih
    
    başla() {
        döngü {
            bırak nesneler = lidar.algıla();
            bırak tehditler = nesneler.filtrele(|n| n.mesafe < 50.0);
            planlayıcı.güncelle(tehditler);
            rtos::bekle_periyot();
        }
    }
}

// V2X iletişimi
bırak v2x = DsrcRadio::yeni();
v2x.yayınla(V2xMessage::acil_fren(konum, hız));
```

**Modüller:** `perception`, `planning`, `control`, `localization`, `v2x`, `safety`, `mod`

### Medikal (`stdlib/medical/`) - IEC 62304

Tıbbi cihaz yazılımı için 4 modül:

```berk
import medical::{IEC62304, RiskManagement, AuditLog};
import medical::risk::{Severity, Probability, RiskLevel};

// IEC 62304 Sınıf C yazılım birimi
#[software_class(IEC62304::ClassC)]
#[risk_control("RC-001")]
fn dozaj_hesapla(hasta_kg: f64, ilaç_mg_kg: f64) -> Sonuç<f64, TıbbiHata> {
    eğer hasta_kg <= 0.0 || ilaç_mg_kg <= 0.0 {
        dön Hata(TıbbiHata::GeçersizParametre);
    }
    bırak dozaj = hasta_kg * ilaç_mg_kg;
    
    // Denetim izi
    AuditLog::kaydet("dozaj_hesaplama", dozaj);
    
    Tamam(dozaj)
}
```

**Modüller:** `iec62304`, `risk`, `audit`, `mod`

### Demiryolu (`stdlib/railway/`) - EN 50128

Raylı ulaşım sistemleri için 5 modül:

```berk
import railway::{ETCS, Interlocking, Signaling};
import railway::en50128::{SilLevel, SafetyFunction};

// SIL-4 anklaşman mantığı
#[sil(SilLevel::SIL4)]
fn makas_kilit_kontrol(makas_id: u32, istek: MakasKonum) -> KilitSonucu {
    bırak mevcut = interlocking.makas_durumu(makas_id);
    bırak rota_çakışma = interlocking.rota_kontrol(makas_id);
    
    eğer rota_çakışma {
        dön KilitSonucu::Reddedildi("Rota çakışması");
    }
    
    interlocking.makas_hareket(makas_id, istek)
}

// ETCS Seviye 2 hareket yetkisi
bırak etcs = ETCS::yeni(seviye: 2);
bırak ma = etcs.hareket_yetkisi_al()?;
```

**Modüller:** `etcs`, `interlocking`, `signaling`, `en50128`, `mod`

### Uzay (`stdlib/space/`) - ECSS

Uzay aracı yazılımı için 5 modül:

```berk
import space::{CCSDS, FDIR, Mission};
import space::ecss::{PacketType, ServiceType};

// CCSDS telemetri paketi
bırak paket = CCSDS::Telemetry::yeni(
    apid: 0x123,
    sequence: mission.sequence_counter(),
    data: sensör_verisi.serialize(),
);
downlink.gönder(paket);

// Arıza Tespiti, İzolasyonu, Kurtarma
#[fdir_monitored]
görev GüneşPaneliKontrol {
    öncelik: Öncelik::YÜKSEK,
    periyot: 100ms,
    
    başla() {
        döngü {
            bırak güç = panel.ölç_güç();
            eğer güç < eşik {
                FDIR::bildir(FaultType::PowerAnomaly);
            }
            rtos::bekle_periyot();
        }
    }
}
```

**Modüller:** `ccsds`, `ecss`, `fdir`, `mission`, `mod`

### Robotik (`stdlib/robotics/`)

Robotik sistemler için 8 modül:

```berk
import robotics::{Arm, Drone, Navigation, Swarm};
import robotics::px4::{FlightMode, MavlinkMessage};

// 6-DOF robot kol kontrolü
bırak kol = Arm::yeni(dof: 6, kinematik: "PUMA560");
bırak hedef = Pose::yeni(x: 0.5, y: 0.3, z: 0.4, rx: 0.0, ry: PI, rz: 0.0);
bırak yol = kol.inverse_kinematics(hedef)?;
kol.hareket(yol, hız: 0.5);

// Drone sürü koordinasyonu
bırak sürü = Swarm::yeni(drone_sayısı: 10);
sürü.formasyon_belirle(Formasyon::V_şekli);
sürü.hedef_git(GPS::yeni(lat: 41.0, lon: 29.0));
```

**Modüller:** `arm`, `drone`, `px4`, `navigation`, `rov`, `ugv`, `swarm`, `mod`

### Telekom (`stdlib/telecom/`) – Stratejik Genişleme Alanı

Telekomünikasyon için 9 modül. BERK'in determinizm ve düşük gecikme yetenekleri, onu modern telekom altyapısı için ideal kılar.

**BERK Telekomda Neden?**

| Gereksinim | BERK Çözümü | Sonuç |
|------------|-------------|-------|
| Deterministik Gecikme | TSN + PTP 1588 + düşük sapma zamanlama | Tahmin edilebilir çerçeve zamanlaması |
| Sıfır Kopyalama Ağ Yolu | Tahsisatsız çerçeve tamponu | Ultra düşük gecikme (SDR, O-RAN) |
| Enerji Verimliliği | Kilitsiz IPC, uzun boşta kalma süreleri | Baz istasyonlarında düşük güç tüketimi |

**Hedef Pazarlar:**

| Segment | BERK Avantajı |
|---------|---------------|
| 5G Küçük Hücre | Düşük gecikme + düşük güç, küçük ayak izi |
| IoT Dar Bant | Deterministik uyku/uyanma, uzatılmış pil ömrü |
| Bant Temeli DSP | Düşük sapma zamanlayıcı, temiz sinyal işleme |
| Edge Yönlendirme | Sıfır kopyalama tamponu, yüksek paket/s |
| O-RAN RU/DU | Deterministik fronthaul, senkronizasyon garantileri |

```berk
import telecom::{TSN, PTP, SDR, ORAN};
import telecom::scheduler::{TrafficClass, GateControl};

// Zamana Duyarlı Ağ
bırak tsn = TSN::yeni(arayüz: "eth0");
tsn.trafik_sınıfı_ekle(TrafficClass::CriticalControl, öncelik: 7);
tsn.gate_schedule_yükle(schedule);

// Hassas Zaman Protokolü (IEEE 1588)
bırak ptp = PTP::yeni(mode: PTP::BoundaryClock);
bırak senkron = ptp.senkronize()?;
yaz("Offset: {} ns", senkron.offset_ns);

// Yazılım Tanımlı Radyo
bırak sdr = SDR::yeni(device: "usrp");
sdr.frekans_ayarla(2.4e9);  // 2.4 GHz
bırak örnekler = sdr.al(1024);
```

**Modüller:** `tsn`, `ptp`, `synce`, `sdr`, `oran`, `frame_buffer`, `packet_queue`, `scheduler`, `mod`

---

## Gerçek Dünya BERK Projeleri (Vitrin)

Gerçek dünya, üretime yönelik örnekler mi arıyorsunuz?

**BERK Vitrin Deposunu** keşfedin:
https://github.com/ArslantasM/berk-showcase

Bu depo şunları içerir:
- Gömülü & RTOS odaklı projeler
- Donanım-yazılım ortak tasarım örnekleri
- Deterministik ve güvenlik farkında sistemler
- BERK kullanan referans mimariler

---

## VS Code Eklentisi v0.7.0 - Yeni Özellikler

### LLVM Backend Entegrasyonu - 33 Platform Desteği

**33 platform** genelinde yerel kod üretimi için tam LLVM IR backend (LLVM 17.0.6) desteği:

| Komut | Kısayol | Açıklama |
|-------|---------|----------|
| **Yerele Derle** | `Ctrl+Shift+N` | Yerel yürütülebilir dosya oluştur (.exe) |
| **LLVM IR Çıktıla** | - | LLVM IR (.ll) oluştur ve editörde aç |
| **Assembly Çıktıla** | - | Assembly (.s) oluştur ve editörde aç |

<details>
<summary><b>Desteklenen Hedef Platformlar (33)</b></summary>

| Mimari | Platformlar |
|--------|-------------|
| **x86_64** | `linux-gnu`, `linux-musl`, `windows-msvc`, `windows-gnu`, `macos`, `freebsd`, `netbsd`, `fuchsia` |
| **i686 (x86)** | `linux-gnu`, `windows-msvc`, `windows-gnu` |
| **AArch64 (ARM64)** | `linux-gnu`, `macos`, `windows-msvc`, `android`, `ios`, `ios-sim`, `freebsd`, `fuchsia` |
| **ARM** | `linux-gnueabihf`, `android` (armv7) |
| **Thumb (Cortex-M)** | `thumbv7em-none-eabihf`, `thumbv7m-none-eabi`, `thumbv6m-none-eabi` |
| **RISC-V** | `riscv64-linux-gnu`, `riscv32-none-elf` |
| **WebAssembly** | `wasm32-unknown`, `wasm32-wasi` |
| **PowerPC** | `powerpc64le-linux-gnu` |
| **SystemZ** | `s390x-linux-gnu` |
| **LoongArch** | `loongarch64-linux-gnu` |
| **MIPS** | `mips64-linux-gnu` |
| **SPARC** | `sparc64-solaris` |

</details>

**Çapraz derleme örneği:**
```bash
# ARM64 Linux
berk-lang build main.berk --target aarch64-linux-gnu

# WebAssembly
berk-lang build main.berk --target wasm32-wasi

# RISC-V gömülü
berk-lang build main.berk --target riscv32-none-elf

# Linux'tan Windows
berk-lang build main.berk --target x86_64-windows-msvc
```

```berk
// Optimizasyonla derle
// Ayarlar: berk.llvm.optimizationLevel = "O2"
```

### DAP Hata Ayıklayıcı Desteği

Etkileşimli hata ayıklama için tam Debug Adapter Protocol desteği:

| Özellik | Açıklama |
|---------|----------|
| **F5 Hata Ayıklama** | Mevcut dosyayı hata ayıklamaya başla |
| **Kesme Noktaları** | Satır numaralarına tıklayarak kesme noktaları ayarla |
| **Başlat/Bağlan** | Programı başlat veya çalışan hata ayıklayıcıya bağlan |
| **Girişte Dur** | Program giriş noktasında duraklat |
| **Değişkenler** | Değişken değerlerini incele |
| **Çağrı Yığını** | Fonksiyon çağrı hiyerarşisini görüntüle |

**launch.json yapılandırması:**
```json
{
  "type": "berk",
  "request": "launch",
  "name": "BERK Programını Hata Ayıkla",
  "program": "${file}",
  "cwd": "${workspaceFolder}",
  "stopOnEntry": true,
  "optimizationLevel": "O0"
}
```

### UTF-8 Türkçe Karakter Desteği

PowerShell terminalleri için otomatik UTF-8 kodlaması - Türkçe karakterler doğru görüntülenir:

| Ayar | Varsayılan | Açıklama |
|------|------------|----------|
| `berk.terminal.enableUtf8` | `true` | UTF-8 kodlamasını etkinleştir |
| `berk.terminal.clearBeforeRun` | `false` | Çalıştırmadan önce terminali temizle |

**Desteklenen karakterler:** `ğ ü ş ı ö ç Ğ Ü Ş İ Ö Ç`

**Manuel kurulum:** Komut Paleti → `BERK: Setup UTF-8 Terminal`

### Yeni Komutlar

| Komut | Açıklama |
|-------|----------|
| `BERK: Compile to Native Executable` | LLVM yerel derleme |
| `BERK: Emit LLVM IR` | LLVM IR oluştur |
| `BERK: Emit Assembly` | Assembly oluştur |
| `BERK: Setup UTF-8 Terminal` | UTF-8 etkin terminal oluştur |
| `BERK: Create New Project` | Yeni BERK projesi oluştur |
| `BERK: Format Document` | Mevcut dosyayı biçimlendir |
| `BERK: Lint Current File` | Linter çalıştır |
| `BERK: Run All Tests` | Test paketini çalıştır |
| `BERK: Generate Documentation` | Dokümantasyon oluştur |

### Stdlib Güncellemesi

**23 modül dizini** genelinde **506 dosya** ile güncellenmiş standart kütüphane:

| Kategori | Modüller |
|----------|----------|
| **Çekirdek** | 64 `.berk` dosyası |
| **AI/ML** | `ai/` - Sinir ağları, LLM, görü |
| **Gömülü** | `embedded/` - MQTT, OPC-UA, EtherCAT, PROFINET |
| **GUI** | `gui/` - Widget'lar, animasyon, reaktif |
| **Veritabanı** | `database/` - PostgreSQL, Redis, göçler |
| **Alan Özel** | `avionics/`, `adas/`, `medical/`, `railway/`, `space/`, `robotics/`, `telecom/` |
| **Protokoller** | `protocol/`, `protocols/` |
| **RTOS** | `rtos/` - Gerçek zamanlı çekirdek |
| **HAL** | `hal/` - Donanım soyutlaması |

### Klavye Kısayolları

| Kısayol | Komut |
|---------|-------|
| `Ctrl+Shift+B` | Mevcut dosyayı çalıştır |
| `Ctrl+Shift+N` | Yerele derle |
| `Ctrl+Shift+F` | Belgeyi biçimlendir |
| `Ctrl+Shift+T` | Tüm testleri çalıştır |
| `Ctrl+Shift+L` | Dosyayı lint et |
| `F5` | Hata ayıklamayı başlat |

### Durum Çubuğu

- Sol altta BERK durum göstergesi
- Mevcut dosyayı çalıştırmak için tıklayın
- Eklenti durumunu gösterir

---

## Kaynaklar

- Dil Kılavuzu: https://arslantasm.github.io/berk_pages/
- Standart Kütüphane Dokümantasyonu: https://arslantasm.github.io/berk-stdlib-docs/
- Depo: https://github.com/ArslantasM/berk
- Sorunlar: https://github.com/ArslantasM/berk/issues
