# ESP32 Platform HAL

ESP32 family için BERK HAL implementasyonu. ESP-IDF (Espressif IoT Development Framework) bindings.

## 📁 Modüller

| Modül | Satır | Durum | Özellikler |
|-------|-------|-------|------------|
| **gpio.berk** | 280 | ✅ | Pin I/O, interrupts, deep sleep wakeup |
| **i2c.berk** | 245 | ✅ | Master mode, advanced transactions |
| **uart.berk** | 280 | ✅ | Full duplex, hardware flow control |
| **pwm.berk** | 360 | ✅ | LEDC peripheral, RGB control, fade effects |
| **spi.berk** | 310 | ✅ | Master mode, DMA, LCD/SD card support |
| **adc.berk** | 390 | ✅ | 12-bit ADC with calibration, battery monitor |
| **wifi.berk** | 485 | ✅ | WiFi STA/AP mode, scanning, power save |
| **ble.berk** | 420 | ✅ | Bluetooth LE GATT, iBeacon, advertising |

**Toplam:** 2770 satır (8/8 modül) ✅ **TIER-1 COMPLETE**

## 🎯 Desteklenen ESP32 Varyantlar

### ESP32 Classic
- **Cores:** Dual-core Xtensa LX6 @ 240MHz
- **RAM:** 520KB SRAM
- **Flash:** 4-16MB
- **WiFi:** 802.11 b/g/n
- **Bluetooth:** Classic + BLE 4.2
- **GPIO:** 34 pins (6-11 reserved for flash)
- **ADC:** 2x 12-bit SAR ADC (18 channels)
- **UART:** 3 ports
- **I2C:** 2 ports
- **SPI:** 4 ports
- **Devkit:** ESP32-DevKitC, DOIT ESP32

### ESP32-C3 (RISC-V)
- **Core:** Single-core RISC-V @ 160MHz
- **RAM:** 400KB SRAM
- **Flash:** 4MB
- **WiFi:** 802.11 b/g/n
- **Bluetooth:** BLE 5.0
- **GPIO:** 22 pins
- **USB:** Native USB (no UART bridge needed)
- **Devkit:** ESP32-C3-DevKitM-1

### ESP32-S2 (WiFi Only)
- **Core:** Single-core Xtensa LX7 @ 240MHz
- **RAM:** 320KB SRAM
- **Flash:** 4MB
- **WiFi:** 802.11 b/g/n
- **USB:** Native USB OTG
- **ADC:** 2x 13-bit ADC
- **Devkit:** ESP32-S2-Saola-1

### ESP32-S3 (AI)
- **Cores:** Dual-core Xtensa LX7 @ 240MHz
- **RAM:** 512KB SRAM
- **Flash:** 8-16MB
- **WiFi:** 802.11 b/g/n
- **Bluetooth:** BLE 5.0
- **AI:** Vector instructions
- **USB:** Native USB OTG
- **Devkit:** ESP32-S3-DevKitC-1

## 🚀 Hızlı Başlangıç

### 1. ESP-IDF Kurulumu

```bash
# Linux/macOS
git clone --recursive https://github.com/espressif/esp-idf.git
cd esp-idf
./install.sh esp32

# Windows
git clone --recursive https://github.com/espressif/esp-idf.git
cd esp-idf
install.bat esp32
```

### 2. BERK Projesini Derle

```bash
# BERK kodunu derle
berk build examples/esp32/blink.berk --target esp32 --release

# Flash yap
berk flash --port COM3 output/blink.bin

# Serial monitor
berk monitor --port COM3 --baud 115200
```

### 3. Örnek: LED Blink

```berk
import "embedded/platforms/esp32/gpio" as GPIO

fn main() {
    // GPIO 2 (built-in LED on most boards)
    GPIO.ESP32_GPIO.init()
    GPIO.ESP32_GPIO.configure(2, GPIO.Mode.Output)
    
    loop {
        GPIO.ESP32_GPIO.write(2, GPIO.Level.High)
        time.sleep_ms(500)
        GPIO.ESP32_GPIO.write(2, GPIO.Level.Low)
        time.sleep_ms(500)
    }
}
```

## 📖 API Dokümantasyonu

### GPIO

#### Temel Kullanım
```berk
import "embedded/platforms/esp32/gpio" as GPIO

// Initialize
GPIO.ESP32_GPIO.init()

// Output pin
GPIO.ESP32_GPIO.configure(13, GPIO.Mode.Output)
GPIO.ESP32_GPIO.write(13, GPIO.Level.High)

// Input pin with pullup
GPIO.ESP32_GPIO.configure(14, GPIO.Mode.InputPullup)
let level = GPIO.ESP32_GPIO.read(14)
```

#### Interrupt Kullanımı
```berk
fn button_handler() {
    IO.println("Button pressed!")
}

// Attach interrupt on falling edge
GPIO.ESP32_GPIO.attach_interrupt(0, GPIO.Trigger.FallingEdge, button_handler)
GPIO.ESP32_GPIO.enable_interrupt(0)
```

#### Deep Sleep Wakeup
```berk
// Configure GPIO 0 as wakeup source
GPIO.wakeup_enable(0, GPIO.Level.Low)

// Enter deep sleep
esp.deep_sleep(10_000_000)  // 10 seconds
```

### I2C

#### Sensör Okuma
```berk
import "embedded/platforms/esp32/i2c" as I2C

let config = I2C.Config {
    bus: 0,
    scl_pin: 22,
    sda_pin: 21,
    speed: I2C.Speed.Fast,
    address_mode: I2C.AddressMode.SevenBit,
    timeout_ms: 1000,
}

I2C.ESP32_I2C.init(config)?

// Read temperature from BME280
let temp = I2C.ESP32_I2C.read_register(0, 0x76, 0xFA)?
IO.println("Temperature: " + temp.to_string())
```

#### Bus Scanning
```berk
let devices = I2C.ESP32_I2C.scan(0)?
IO.println("Found " + devices.len().to_string() + " devices:")
for addr in devices {
    IO.println("  0x" + addr.to_hex())
}
```

### UART

#### Seri İletişim
```berk
import "embedded/platforms/esp32/uart" as UART

let config = UART.Config {
    uart: 1,
    tx_pin: 17,
    rx_pin: 16,
    baud_rate: UART.BaudRate.Baud115200,
    data_bits: UART.DataBits.Bits8,
    parity: UART.Parity.None,
    stop_bits: UART.StopBits.One,
    flow_control: UART.FlowControl.None,
    rx_buffer_size: 1024,
    tx_buffer_size: 1024,
}

UART.ESP32_UART.init(config)?

// Send data
UART.ESP32_UART.write_string(1, "Hello ESP32!\r\n")?

// Read line
match UART.read_line(1, 5000) {
    Ok(line) => IO.println("Received: " + line),
    Err(e) => IO.eprintln("Error: " + e.to_string()),
}
```

## 🔧 Pin Mapping

### ESP32-DevKitC V4

```
                     ESP32-DevKitC
                    ┌────────────┐
                3.3V│1        30 │GND
               RESET│2        29 │GPIO23
          (TX) GPIO1│3        28 │GPIO22 (I2C SCL)
          (RX) GPIO3│4        27 │GPIO21 (I2C SDA)
              GPIO15│5        26 │GPIO19 (SPI MISO)
               GPIO2│6        25 │GPIO18 (SPI SCK)
               GPIO0│7        24 │GPIO5  (SPI CS)
               GPIO4│8        23 │GPIO17 (UART2 TX)
              GPIO16│9        22 │GPIO16 (UART2 RX)
              GPIO17│10       21 │GPIO4
               GPIO5│11       20 │GPIO0
              GPIO18│12       19 │GPIO2  (LED)
              GPIO19│13       18 │GPIO15
                  NC│14       17 │GPIO13
               GPIO21│15       16 │GPIO12
                    └────────────┘
```

### Özel Fonksiyonlar

| Pin | Fonksiyon | Notlar |
|-----|-----------|--------|
| GPIO0 | Boot/Flash | LOW = Flash mode |
| GPIO1 | TX0 | Serial monitor TX |
| GPIO2 | LED | Built-in LED (bazı boardlarda) |
| GPIO3 | RX0 | Serial monitor RX |
| GPIO6-11 | Flash | Kullanılmamalı (SPI flash) |
| GPIO12 | MTDI | Strapping pin |
| GPIO15 | MTDO | Strapping pin |
| GPIO34-39 | Input only | Pull-up/down yok |

## 📊 Performans

### GPIO
- **Hız:** ~1MHz toggle (yazılımsal)
- **Interrupt latency:** ~2-5µs
- **Drive strength:** 5-40mA configurable

### I2C
- **Standard mode:** 100kHz
- **Fast mode:** 400kHz  
- **Fast mode plus:** 1MHz
- **Transaction overhead:** ~100µs

### UART
- **Max baud rate:** 5Mbps (teorik)
- **Recommended:** ≤921600 baud
- **FIFO:** 128 bytes TX/RX
- **DMA:** Supported

## 🐛 Bilinen Kısıtlamalar

1. **GPIO 6-11:** SPI flash için ayrılmış, kullanılmamalı
2. **GPIO 34-39:** Yalnızca input, pull-up/down desteklenmiyor
3. **ADC2:** WiFi aktifken kullanılamaz
4. **I2C clock stretching:** Slave mode'da sorunlu olabilir
5. **UART RX interrupt:** ESP-IDF event queue kullanılmalı

## 🔗 ESP-IDF Referansları

- [ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/)
- [GPIO API Reference](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/peripherals/gpio.html)
- [I2C API Reference](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/peripherals/i2c.html)
- [UART API Reference](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-reference/peripherals/uart.html)

## 📝 TODO

- [ ] PWM/LEDC implementation
- [ ] SPI master/slave
- [ ] ADC with calibration
- [ ] WiFi STA/AP mode
- [ ] BLE GATT server/client
- [ ] RMT (IR transmit/receive)
- [ ] CAN bus
- [ ] Ethernet MAC

---

**Platform:** ESP32 Family (ESP32, ESP32-C3, ESP32-S2, ESP32-S3)  
**SDK:** ESP-IDF v5.x  
**BERK Version:** 1.0.0  
**Last Update:** November 21, 2025
