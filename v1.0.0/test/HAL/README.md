# HAL (Hardware Abstraction Layer) Demos

Bu klasör, BERK dilinin **Donanım Soyutlama Katmanı (HAL)** özelliklerini gösteren örnekleri içerir.

## Demo Listesi

### Temel Demolar (01-04)

| # | Demo | Açıklama |
|---|------|----------|
| 01 | `01_arduino.berk` | Arduino GPIO, Digital/Analog I/O, Serial iletişim |
| 02 | `02_esp32.berk` | ESP32 WiFi, Bluetooth, dual-core, deep sleep |
| 03 | `03_stm32.berk` | STM32 GPIO, Clock Tree, Timer/PWM |
| 04 | `04_riscv.berk` | RISC-V mimarisi ve temel HAL |

### Gelişmiş Demolar (05-10)

| # | Demo | Açıklama |
|---|------|----------|
| 05 | `05_sensor_network.berk` | Çoklu sensör ağı: ADC, istatistik, Kalman filter, alarm sistemi |
| 06 | `06_motor_control.berk` | DC Motor, Stepper, Servo kontrolü, PID, Encoder |
| 07 | `07_communication_protocols.berk` | I2C, SPI, UART, OneWire, CAN Bus protokolleri |
| 08 | `08_display_interface.berk` | LCD, OLED (SSD1306), TFT (ILI9341), GUI widget |
| 09 | `09_interrupt_dma.berk` | Interrupt yönetimi, DMA transfer, ADC+DMA, UART+DMA |
| 10 | `10_rtos_integration.berk` | FreeRTOS entegrasyonu: Task, Queue, Semaphore, Mutex |

## Çalıştırma

```powershell
# Türkçe versiyonlar
.\berk-lang.exe run demos\HAL\01_arduino.berk
.\berk-lang.exe run demos\HAL\05_sensor_network.berk

# İngilizce versiyonlar
.\berk-lang.exe run demos\HAL\EN_01_arduino.berk
.\berk-lang.exe run demos\HAL\EN_05_sensor_network.berk
```

## Kapsanan Konular

### Temel HAL
- GPIO yapılandırma ve kontrol
- ADC/DAC dönüşümleri
- PWM sinyal üretimi
- Timer ve Counter
- Serial iletişim (UART)

### İletişim Protokolleri
- **I2C**: Sensor okuma, EEPROM, OLED
- **SPI**: SD kart, TFT ekran, Flash bellek
- **UART**: WiFi modül, GPS, Bluetooth
- **OneWire**: DS18B20 sıcaklık sensörü
- **CAN Bus**: Otomotiv uygulamaları

### Motor Kontrolü
- DC Motor (H-Bridge)
- Stepper Motor (A4988, DRV8825)
- Servo Motor (PWM)
- PID kontrolcü
- Quadrature Encoder

### Sensör İşleme
- ADC -> Fiziksel birim dönüşümü
- Ring buffer veri depolama
- İstatistiksel analiz (mean, std, min/max)
- Kalman filtresi
- Alarm sistemi

### Ekran Arayüzleri
- HD44780 karakter LCD
- SSD1306 OLED (I2C)
- ILI9341 TFT (SPI)
- GUI widget sistemi
- Font rendering

### Interrupt & DMA
- External Interrupt (EXTI)
- Timer Interrupt
- Interrupt öncelik sistemi
- DMA transfer modları
- ADC + DMA entegrasyonu
- UART + DMA (Idle Line Detection)

### RTOS Entegrasyonu
- FreeRTOS Task yönetimi
- Queue (mesaj kuyruğu)
- Semaphore ve Mutex
- Yazılım Timer
- Event Groups
- Task istatistikleri

## Dosya Yapısı

```
HAL/
├── 01_arduino.berk              # Arduino temel HAL
├── 02_esp32.berk                # ESP32 WiFi/BT
├── 03_stm32.berk                # STM32 peripherals
├── 04_riscv.berk                # RISC-V HAL
├── 05_sensor_network.berk       # Sensör ağı (Gelişmiş)
├── 06_motor_control.berk        # Motor kontrolü (Gelişmiş)
├── 07_communication_protocols.berk  # İletişim protokolleri
├── 08_display_interface.berk    # Ekran arayüzleri
├── 09_interrupt_dma.berk        # Interrupt ve DMA
├── 10_rtos_integration.berk     # RTOS entegrasyonu
├── EN_01_arduino.berk           # English version
├── EN_02_esp32.berk             # English version
├── EN_03_stm32.berk             # English version
├── EN_04_riscv.berk             # English version
├── EN_05_sensor_network.berk    # English version
├── EN_06_motor_control.berk     # English version
└── README.md                    # Bu dosya
```

## Hedef Platformlar

| Platform | MCU | Özellikler |
|----------|-----|------------|
| Arduino | ATmega328P | 8-bit, 16 MHz, 32KB Flash |
| ESP32 | Xtensa LX6 | 32-bit dual-core, WiFi/BT, 520KB SRAM |
| STM32 | Cortex-M | 32-bit, 72-400 MHz, zengin peripherals |
| RISC-V | Various | Açık kaynak ISA, ESP32-C3, GD32VF103 |

## İlgili Belgeler

- [EMBEDDED_SYSTEMS.md](../../EMBEDDED_SYSTEMS.md) - Gömülü sistem desteği
- [PLATFORM_SUPPORT.md](../../PLATFORM_SUPPORT.md) - Platform desteği detayları
- [HAL_DEVELOPER_GUIDE.md](../../HAL_DEVELOPER_GUIDE.md) - HAL geliştirici kılavuzu
