# BERK Embedded Systems - Backend Abstraction Layer (BAL)

Backend Abstraction Layer (BAL), gömülü sistemler için platform-bağımsız API'ler sağlar. Platform HAL'ları bu arayüzleri implemente eder.

## Dizin Yapısı

```
stdlib/embedded/
├── bal/ # Backend Abstraction Layer
│ ├── gpio.berk # Digital I/O (175 satır)
│ ├── i2c.berk # I2C iletişim (195 satır)
│ ├── spi.berk # SPI iletişim (220 satır)
│ ├── uart.berk # Seri iletişim (240 satır)
│ ├── pwm.berk # PWM sinyalleri (210 satır)
│ ├── adc.berk # Analog okuma (235 satır)
│ ├── timer.berk # Donanım zamanlayıcılar (TBD)
│ └── network.berk # WiFi/Ethernet/BLE (TBD)
├── platforms/ # Platform HAL implementasyonları
│ ├── esp32/ # ESP32 family
│ ├── stm32f4/ # STM32F4 family
│ └── rp2040/ # Raspberry Pi Pico
└── examples/ # Örnek projeler
 ├── blink/
 ├── uart_echo/
 └── sensor_i2c/
```

## BAL Modülleri

### 1. GPIO (gpio.berk) - 175 satır

**Özellikler:**
- Pin mode configuration (Input, Output, Pullup, etc.)
- Digital read/write
- Interrupt handling
- Drive strength control
- High-level convenience functions

**Kullanım:**
```berk
import "embedded/bal/gpio" as GPIO

fn main() {
 // LED pin output olarak ayarla
 GPIO.init_output(13)

 loop {
 GPIO.set_high(13)
 time.sleep_ms(500)
 GPIO.set_low(13)
 time.sleep_ms(500)
 }
}
```

### 2. I2C (i2c.berk) - 195 satır

**Özellikler:**
- Master mode operation
- 7-bit ve 10-bit addressing
- Multiple speed modes (100kHz - 3.4MHz)
- Register read/write helpers
- Bus scanning
- Retry with exponential backoff

**Kullanım:**
```berk
import "embedded/bal/i2c" as I2C

fn main() {
 // I2C başlat (Fast mode - 400kHz)
 I2C.init_default(0, scl: 22, sda: 21)?

 // BME280 sensöründen sıcaklık oku (0x76 adresi)
 let temp_raw = I2C.read_register(0, 0x76, 0xFA)?
 IO.println("Temperature: " + temp_raw.to_string())
}
```

### 3. SPI (spi.berk) - 220 satır

**Özellikler:**
- Master mode operation
- 4 SPI mode (CPOL/CPHA)
- Automatic CS control
- Register read/write helpers
- Bulk transfer support

**Kullanım:**
```berk
import "embedded/bal/spi" as SPI

fn main() {
 // SPI başlat (8MHz)
 SPI.init_default(0, sck: 18, mosi: 23, miso: 19, cs: 5)?

 // SD karttan veri oku
 let mut buffer: [u8; 512] = [0; 512]
 SPI.read_with_cs(0, 5, &mut buffer)?
}
```

### 4. UART (uart.berk) - 240 satır

**Özellikler:**
- Configurable baud rate (9600 - 921600)
- Multiple data formats (5-9 bits, parity, stop bits)
- Buffered I/O
- Line reading with timeout
- AT command helper
- Hex dump for debugging

**Kullanım:**
```berk
import "embedded/bal/uart" as UART

fn main() {
 // UART başlat (115200 8N1)
 UART.init_default(0, tx: 17, rx: 16)?

 // String gönder
 UART.println(0, "Hello from BERK!")?

 // Satır oku (timeout 5 saniye)
 let response = UART.read_line(0, 5000)?
 IO.println("Received: " + response)
}
```

### 5. PWM (pwm.berk) - 210 satır

**Özellikler:**
- Variable frequency (Hz)
- Duty cycle control (0-100%)
- Fade effects
- Servo motor control
- DC motor speed control
- LED brightness control
- Tone generation (buzzer)

**Kullanım:**
```berk
import "embedded/bal/pwm" as PWM

fn main() {
 // PWM başlat
 PWM.init_default(0, pin: 25)?

 // Servo 90 dereceye çevir
 PWM.set_servo_angle(0, 90.0)?

 // LED parlaklık fade
 PWM.fade_in(0, 100.0, 2000)? // 2 saniyede yak
 time.sleep_ms(1000)
 PWM.fade_out(0, 2000)? // 2 saniyede söndür
}
```

### 6. ADC (adc.berk) - 235 satır

**Özellikler:**
- Multiple resolutions (8-16 bit)
- Voltage measurement
- Averaging and median filtering
- Temperature sensor reading
- Battery voltage monitoring
- Light sensor reading
- Threshold detection

**Kullanım:**
```berk
import "embedded/bal/adc" as ADC

fn main() {
 // ADC başlat (12-bit)
 ADC.init_default(0, pin: 34)?

 // Potansiyometre açısını oku
 let angle = ADC.read_potentiometer_angle(0)?
 IO.println("Angle: " + angle.to_string() + "°")

 // Batarya voltajını oku (10kΩ + 10kΩ voltage divider)
 let battery = ADC.read_battery_voltage(0, 10000.0, 10000.0)?
 IO.println("Battery: " + battery.to_string() + "V")
}
```

## Platform HAL Implementasyonu

Platform HAL'ları BAL arayüzlerini implemente eder:

```berk
// stdlib/embedded/platforms/esp32/gpio.berk

import "embedded/bal/gpio" as GPIO

// ESP-IDF bindings
extern "C" {
 fn gpio_set_direction(pin: u32, mode: u32) -> i32
 fn gpio_set_level(pin: u32, level: u32)
 fn gpio_get_level(pin: u32) -> u32
}

// BAL arayüzünü implemente et
impl GPIO.GPIO_HAL for ESP32_GPIO {
 fn init() {
 // ESP32 GPIO clock enable (otomatik)
 }

 fn configure(pin: u8, mode: GPIO.Mode) {
 let esp_mode = match mode {
 GPIO.Mode.Input => 1,
 GPIO.Mode.Output => 2,
 GPIO.Mode.InputPullup => 3,
 }
 gpio_set_direction(pin as u32, esp_mode)
 }

 fn write(pin: u8, level: GPIO.Level) {
 let val = if level == GPIO.Level.High { 1 } else { 0 }
 gpio_set_level(pin as u32, val)
 }

 fn read(pin: u8) -> GPIO.Level {
 if gpio_get_level(pin as u32) != 0 {
 GPIO.Level.High
 } else {
 GPIO.Level.Low
 }
 }

 // ... diğer fonksiyonlar
}
```

## Kod İstatistikleri

| Modül | Satır | Enum | Struct | Interface | Fonksiyon |
|-------|-------|------|--------|-----------|-----------|
| gpio.berk | 175 | 4 | 1 | 1 | 15 |
| i2c.berk | 195 | 3 | 1 | 1 | 12 |
| spi.berk | 220 | 4 | 1 | 1 | 14 |
| uart.berk | 240 | 5 | 1 | 1 | 16 |
| pwm.berk | 210 | 3 | 1 | 1 | 13 |
| adc.berk | 235 | 4 | 1 | 1 | 15 |
| **TOPLAM** | **1275** | **23** | **6** | **6** | **85** |

## Avantajlar

### 1. Platform Bağımsızlığı
```berk
// Aynı kod ESP32, STM32, RP2040'ta çalışır!
import "embedded/bal/gpio" as GPIO

GPIO.init_output(13)
GPIO.set_high(13)
```

### 2. Tip Güvenliği
```berk
// Derleme zamanında tip kontrolü
let mode: GPIO.Mode = GPIO.Mode.Output
let level: GPIO.Level = GPIO.Level.High
```

### 3. Yüksek Seviye API'ler
```berk
// Kompleks işlemler tek satırda
PWM.fade_in(0, 100.0, 2000)? // LED fade
UART.send_at_command(0, "AT", 1000)? // AT command
ADC.read_battery_percentage(0, 10k, 10k)? // Battery %
```

### 4. Error Handling
```berk
// Result<T, Error> ile güvenli hata yönetimi
match I2C.read_register(0, 0x76, 0xFA) {
 Ok(value) => IO.println("Value: " + value.to_string()),
 Err(e) => IO.eprintln("I2C error: " + e.to_string()),
}
```

## Örnek Projeler

### LED Blink
```berk
import "embedded/bal/gpio" as GPIO

fn main() {
 GPIO.init_output(13)
 loop {
 GPIO.toggle(13)
 time.sleep_ms(500)
 }
}
```

### I2C Sensor Reading
```berk
import "embedded/bal/i2c" as I2C

fn main() {
 I2C.init_default(0, 22, 21)?

 loop {
 let temp = I2C.read_register(0, 0x76, 0xFA)?
 IO.println("Temp: " + temp.to_string())
 time.sleep_ms(1000)
 }
}
```

### Servo Motor Control
```berk
import "embedded/bal/pwm" as PWM

fn main() {
 PWM.init_default(0, 25)?

 // 0° → 90° → 180° → 90° → 0°
 loop {
 PWM.set_servo_angle(0, 0.0)?
 time.sleep_ms(1000)
 PWM.set_servo_angle(0, 90.0)?
 time.sleep_ms(1000)
 PWM.set_servo_angle(0, 180.0)?
 time.sleep_ms(1000)
 PWM.set_servo_angle(0, 90.0)?
 time.sleep_ms(1000)
 }
}
```

## Sonraki Adımlar

- [ ] `timer.berk` - Donanım zamanlayıcılar
- [ ] `network.berk` - WiFi/Ethernet/BLE abstraction
- [ ] Platform HAL'ları (ESP32, STM32F4, RP2040)
- [ ] Örnek projeler (blink, sensor, motor control)
- [ ] HAL auto-generator tool implementasyonu
- [ ] Test suite (unit + hardware tests)

## Referanslar

- [HAL Developer Guide](../../../HAL_DEVELOPER_GUIDE.md)
- [ROADMAP.md](../../../ROADMAP.md) - Phase 7: Platform Expansion
- [BERK Embedded Strategy](../../../docs/embedded_strategy.md)

---

**Geliştirici:** ArslantasM-tools 
**Versiyon:** 1.0.0 
**Son Güncelleme:**
