# RP2040 Platform HAL

Raspberry Pi RP2040 için BERK HAL implementasyonu. Pico SDK bindings.

## 📁 Modüller

| Modül | Satır | Durum | Özellikler |
|-------|-------|-------|------------|
| **gpio.berk** | 280 | ✅ | 30 GPIO pins, interrupts, pull-up/down |
| **i2c.berk** | 300 | ✅ | 2× I2C, master/slave, up to 1 MHz |
| **uart.berk** | 280 | ✅ | 2× UART, FIFO, flow control |
| **spi.berk** | 300 | ✅ | 2× SPI, master/slave, up to 62.5 MHz |
| **pwm.berk** | 320 | ✅ | 16 PWM channels, wrap/compare |
| **adc.berk** | 260 | ✅ | 4× 12-bit ADC + temp sensor |
| **pio.berk** | 380 | ✅ | Programmable I/O (unique feature) |
| **usb.berk** | 220 | ✅ | Native USB Device (TinyUSB) |

**Toplam:** 2340 satır (8/8 modül) ✅ **TIER-1 COMPLETE**

## 🎯 RP2040 Specifications

**Core:**
- Dual ARM Cortex-M0+ @ 133 MHz
- 264 KB on-chip SRAM
- No internal flash (uses external QSPI flash: 2-16 MB)
- 16 KB bootrom

**Peripherals:**
- **GPIO:** 30 multi-function pins
- **I2C:** 2× controllers (master/slave, up to 1 MHz)
- **SPI:** 2× controllers (master/slave, up to 62.5 MHz)
- **UART:** 2× controllers with hardware flow control
- **PWM:** 8× slices, 16 channels total
- **ADC:** 4× 12-bit 500 ksps SAR ADC + internal temperature sensor
- **PIO:** 2× Programmable I/O blocks (8 state machines total)
- **USB:** Native USB 1.1 Device (12 Mbit/s)
- **DMA:** 12 channels with ring buffers

**Clock:**
- External crystal: 12 MHz
- PLL: Up to 133 MHz (can overclock to 250+ MHz)
- USB PLL: 48 MHz for USB

**Power:**
- Run: 22-50 mA @ 133 MHz
- Sleep: 2-10 mA
- Dormant: <1 mA

**Package:**
- QFN-56 (7×7 mm)
- Cost: ~$1 USD (qty 1000)

## 🔌 Pin Mapping (Raspberry Pi Pico)

```
                    RP2040 / Raspberry Pi Pico
                    
         GP0 (UART0 TX)  [ 1]    [40]  VBUS (5V)
         GP1 (UART0 RX)  [ 2]    [39]  VSYS (5V)
              GND        [ 3]    [38]  GND
         GP2            [ 4]    [37]  3V3_EN
         GP3            [ 5]    [36]  3V3 OUT
         GP4 (I2C0 SDA) [ 6]    [35]  ADC_VREF
         GP5 (I2C0 SCL) [ 7]    [34]  GP28 (ADC2)
              GND        [ 8]    [33]  GND
         GP6            [ 9]    [32]  GP27 (ADC1)
         GP7            [10]    [31]  GP26 (ADC0)
         GP8            [11]    [30]  RUN
         GP9            [12]    [29]  GP22
              GND        [13]    [28]  GND
         GP10           [14]    [27]  GP21
         GP11           [15]    [26]  GP20
         GP12           [16]    [25]  GP19 (SPI0 TX)
         GP13           [17]    [24]  GP18 (SPI0 SCK)
              GND        [18]    [23]  GND
         GP14           [19]    [22]  GP17 (SPI0 CSn)
         GP15           [20]    [21]  GP16 (SPI0 RX)
```

**Built-in LED:** GP25 (on-board LED)

**Default Peripherals:**
- **UART0:** GP0 (TX), GP1 (RX) - Console
- **I2C0:** GP4 (SDA), GP5 (SCL) - Default
- **I2C1:** GP6 (SDA), GP7 (SCL) - Alternative
- **SPI0:** GP16 (RX), GP17 (CSn), GP18 (SCK), GP19 (TX)
- **SPI1:** GP8 (RX), GP9 (CSn), GP10 (SCK), GP11 (TX)
- **ADC:** GP26 (ADC0), GP27 (ADC1), GP28 (ADC2), GP29 (ADC3)

## ⚡ Performance Metrics

| Peripheral | Max Speed | Resolution | Notes |
|------------|-----------|------------|-------|
| **GPIO** | 50 MHz toggle | 1-bit | Faster with PIO |
| **UART** | 921600 baud | 8-bit | Hardware FIFO (32 bytes) |
| **I2C** | 1 MHz (Fast+) | - | Master or slave mode |
| **SPI** | 62.5 MHz | 8/16-bit | Master mode, DMA |
| **ADC** | 500 ksps | 12-bit | Free-running mode |
| **PWM** | 125 MHz | 16-bit | Per-channel control |
| **PIO** | 133 MHz | - | 32 instructions per SM |
| **USB** | 12 Mbit/s | - | Full Speed Device |

## 🌟 Unique Feature: PIO (Programmable I/O)

RP2040'ın en önemli özelliği **PIO (Programmable I/O)** bloklarıdır:

- **8 State Machine:** Bağımsız I/O işlemcileri
- **32 Instruction Memory:** SM başına
- **Custom Protocols:** I2S, DPI, SDIO, custom serial
- **Parallel Interfaces:** 8-bit parallel LCD, RGB LED matrix
- **High-Speed Sampling:** Logic analyzer, oscilloscope frontend

**PIO ile Neler Yapılabilir:**
- WS2812 RGB LED control (NeoPixel)
- I2S audio input/output
- DVI/HDMI video output
- Quadrature encoder reading
- Manchester encoding/decoding
- Custom UART with odd baud rates

## 🚀 Quick Start

```berk
import "embedded/platforms/rp2040/gpio" as GPIO

fn main() {
    // Initialize built-in LED (GP25)
    GPIO.init_output(25, GPIO.OutputMode.PushPull)
    
    loop {
        GPIO.set_high(25)
        time.sleep_ms(1000)
        GPIO.set_low(25)
        time.sleep_ms(1000)
    }
}
```

## 📦 Development Boards

### Raspberry Pi Pico
- **Price:** $4 USD
- **Flash:** 2 MB QSPI
- **Features:** Basic breakout, on-board LED
- **Target:** Education, prototyping

### Raspberry Pi Pico W
- **Price:** $6 USD
- **Flash:** 2 MB QSPI
- **WiFi:** CYW43439 (802.11n, 2.4 GHz)
- **Bluetooth:** BLE 5.2
- **Target:** IoT projects

### Adafruit Feather RP2040
- **Flash:** 8 MB QSPI
- **Features:** LiPo charger, STEMMA QT I2C
- **Form Factor:** Feather (compatible with shields)

### SparkFun Thing Plus RP2040
- **Flash:** 16 MB QSPI
- **Features:** µSD card slot, Qwiic I2C, LiPo charger

### Pimoroni Pico LiPo
- **Flash:** 4-16 MB QSPI
- **Features:** Built-in LiPo charger, RGB LED

## 🔧 SDK & Tools

**Pico SDK:**
- Official C/C++ SDK from Raspberry Pi
- CMake build system
- TinyUSB for USB
- Hardware libraries for all peripherals

**Tools:**
- **picotool:** Binary info and USB bootloader
- **OpenOCD:** Debugging via SWD
- **UF2 Bootloader:** Drag-and-drop programming

**Flash Programming:**
1. Hold BOOTSEL button
2. Plug USB cable
3. Drag UF2 file to RPI-RP2 drive
4. Release BOOTSEL

## 📚 Example Applications

### Education
- **MicroPython:** Official Python support
- **CircuitPython:** Adafruit's beginner-friendly Python
- **Arduino:** Community Arduino core

### Maker Projects
- RGB LED strips (WS2812)
- LCD displays (I2C, SPI, parallel)
- Motor control (PWM)
- Sensor nodes (I2C/SPI sensors)

### Professional
- USB HID devices (keyboard, mouse, gamepad)
- USB-to-Serial bridges
- Logic analyzers (PIO)
- Audio interfaces (I2S via PIO)

## 🐛 Known Limitations

- **No Hardware FPU:** Cortex-M0+ (use integer math or software FP)
- **No Internal Flash:** Requires external QSPI flash
- **Single Core by Default:** Multicore requires special handling
- **ADC Noise:** ~2-3 LSB noise (can improve with averaging)
- **No CAN Bus:** Must use SPI CAN controller (MCP2515)
- **No Ethernet:** WiFi available on Pico W only

## 💰 Cost Comparison

| Platform | Price | Flash | RAM | Periph Score |
|----------|-------|-------|-----|--------------|
| RP2040 | $1 | 0* | 264 KB | ⭐⭐⭐⭐ |
| ESP32 | $2 | 4 MB | 520 KB | ⭐⭐⭐⭐⭐ |
| STM32F4 | $5 | 512 KB | 192 KB | ⭐⭐⭐⭐⭐ |

*Requires external QSPI flash (adds $0.50-2)

## 🏭 Market Position

**Target Markets:**
- **Education:** Raspberry Pi Foundation focus
- **Maker/Hobby:** Low cost, easy to use
- **Commercial:** Cost-sensitive USB peripherals

**Market Share:** ~5% of Cortex-M0+ market
**Annual Volume:** 10+ million units (Pico family)
**Competitive Edge:** PIO, USB, education ecosystem

**Tier-1 Status:** Third platform for 70% market coverage
