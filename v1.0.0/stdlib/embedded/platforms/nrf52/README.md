# Nordic nRF52 Platform Support

## Overview

Nordic nRF52 series is the industry-leading Bluetooth Low Energy (BLE) platform, dominating the wearables, IoT sensors, and wireless connectivity market. Known for exceptional power efficiency and robust BLE stack.

## Target Markets
- **Wearables**: Fitness trackers, smartwatches (~40% of nRF52 usage)
- **IoT Sensors**: Wireless sensors, beacons, asset tracking (~30%)
- **Medical Devices**: Health monitors, hearing aids (~15%)
- **Consumer Electronics**: Wireless peripherals, audio (~10%)
- **Smart Home**: Door locks, sensors, controllers (~5%)

**Market Share**: ~15% of embedded market (BLE specialist)

## Chip Variants

### nRF52832 (Most Popular)
- **CPU**: ARM Cortex-M4F @ 64 MHz
- **Flash**: 512 KB
- **RAM**: 64 KB
- **BLE**: Bluetooth 5.0 (Long Range, 2 Mbps)
- **Peripherals**: 32 GPIO, UART, SPI, I2C, PWM, ADC
- **Power**: 5.4 mA TX, 5.4 mA RX, <1 µA sleep
- **Price**: ~$2-3 (volume)
- **Use Cases**: General BLE applications, wearables

### nRF52833
- **CPU**: ARM Cortex-M4F @ 64 MHz
- **Flash**: 512 KB
- **RAM**: 128 KB (2x of nRF52832)
- **BLE**: Bluetooth 5.1 (Direction Finding)
- **USB**: Native USB 2.0 FS
- **Thread/Zigbee**: IEEE 802.15.4 support
- **Price**: ~$3-4
- **Use Cases**: Advanced BLE, Thread/Zigbee mesh

### nRF52840 (Flagship)
- **CPU**: ARM Cortex-M4F @ 64 MHz
- **Flash**: 1 MB
- **RAM**: 256 KB
- **BLE**: Bluetooth 5.3 (all features)
- **USB**: Native USB 2.0 FS
- **Thread/Zigbee**: IEEE 802.15.4 radio
- **Crypto**: ARM CryptoCell-310
- **NFC**: NFC-A tag
- **Price**: ~$4-5
- **Use Cases**: Professional BLE, mesh networks, USB dongles

## Architecture

### CPU Core
- ARM Cortex-M4F with FPU
- Single-precision floating point
- 64 MHz maximum frequency
- Ultra-low power modes

### Memory
- Flash: 256 KB - 1 MB
- RAM: 32 KB - 256 KB
- Non-volatile storage for bonding info

### Radio (Key Feature)
- **BLE 5.3**: 2 Mbps PHY, Long Range (125 kbps), Advertising Extensions
- **TX Power**: +8 dBm to -40 dBm (programmable)
- **RX Sensitivity**: -95 dBm (1 Mbps), -103 dBm (Long Range)
- **Antenna Diversity**: Software-controlled switching
- **Proprietary Protocols**: ESB (Enhanced ShockBurst), Gazell

### Low Power Design
- **Active**: 5.4 mA @ 0 dBm TX, 5.4 mA RX
- **System ON Idle**: 2.6 µA
- **System OFF**: 0.4 µA
- **RAM retention**: 61 nA per 4 KB block

## Peripherals

### GPIO
- **Count**: 32 programmable GPIOs (nRF52832), 48 (nRF52840)
- **Drive**: High-drive capable (up to 15 mA per pin)
- **Sensing**: Low-power port sensing for wake-up
- **Task/Event**: GPIOTE with PPI (Programmable Peripheral Interconnect)

### Communication
- **UART**: 2x with EasyDMA, hardware flow control
- **SPI**: 3x master/slave, up to 8 Mbps, EasyDMA
- **I2C**: 2x TWI (Two-Wire Interface), 400 kHz
- **QSPI**: Quad SPI for external flash (nRF52840)
- **I2S**: Digital audio interface

### Timers & PWM
- **TIMER**: 5x 32-bit timers
- **RTC**: 3x Real-Time Counters (32.768 kHz)
- **PWM**: 4x PWM units, 4 channels each (16 total outputs)
- **WDT**: Watchdog Timer

### Analog
- **ADC**: 12-bit SAADC (Successive Approximation)
 - 8 single-ended or 4 differential channels
 - Oversampling up to 16-bit resolution
 - Internal temperature sensor
- **Comparator**: LPCOMP (Low-Power Comparator)
- **PDM**: Pulse Density Modulation microphone interface

### Security
- **AES**: 128-bit AES hardware accelerator
- **ECC**: Elliptic Curve Cryptography (ARM CryptoCell-310 on nRF52840)
- **RNG**: True Random Number Generator
- **ACL**: Access Control List for memory protection

### Special Features
- **NFC**: NFC-A tag (nRF52840, nRF52832 with variant)
- **USB**: USB 2.0 Full-Speed device (nRF52840, nRF52833)
- **PPI**: Programmable Peripheral Interconnect (low-latency task triggering)

## BLE Stack (SoftDevice)

Nordic provides the **SoftDevice** - a production-quality BLE protocol stack:

### SoftDevice S132 (BLE Central/Peripheral)
- Bluetooth 5.3 compliant
- Concurrent roles: Central + Peripheral
- Multiple connections: Up to 20 simultaneous
- L2CAP Connection Oriented Channels
- GATT Server/Client
- Security Manager (LE Secure Connections)
- Flash: ~150 KB, RAM: ~12 KB base + per connection

### SoftDevice S140 (Mesh + BLE)
- All S132 features
- Bluetooth Mesh networking
- Concurrent BLE + Mesh operation
- Flash: ~200 KB, RAM: ~20 KB base

## Development Ecosystem

### Nordic SDK
- **nRF5 SDK**: Complete peripheral drivers, examples
- **nRF Connect SDK**: Zephyr RTOS based (modern choice)
- **SoftDevice API**: BLE stack integration
- **Segger Embedded Studio**: Free IDE

### Tools
- **nRF Connect**: Desktop app for BLE testing
- **nRF Connect for Mobile**: Smartphone BLE scanner/debugger
- **nRF Sniffer**: Protocol analyzer
- **Power Profiler Kit II**: Real-time power measurement

### Programming
- **Bootloader**: Secure DFU (Device Firmware Update) over BLE/USB
- **Debug**: SWD (Serial Wire Debug)
- **Programmer**: nRF52 DK, Segger J-Link

## Pin Configuration Examples

### nRF52832 (QFN48 package)
```
Digital I/O: P0.00 - P0.31 (32 GPIOs)
UART0 (Debug): TX: P0.06, RX: P0.08
I2C0: SDA: P0.26, SCL: P0.27
SPI0: MOSI: P0.23, MISO: P0.24, SCK: P0.25
ADC: AIN0-AIN7: P0.02-P0.05, P0.28-P0.31
PWM: Any GPIO (flexible mapping)
NFC: NFC1: P0.09, NFC2: P0.10 (if enabled)
```

### nRF52840 (QFN73 package)
```
Digital I/O: P0.00 - P0.31, P1.00 - P1.15 (48 GPIOs)
UART0: TX: P0.06, RX: P0.08
I2C0: SDA: P0.26, SCL: P0.27
SPI0: MOSI: P0.23, MISO: P0.24, SCK: P0.25
QSPI: IO0-IO3: P0.20-P0.23, SCK: P0.19, CS: P0.17
USB: D-: P0.24, D+: P0.23 (shared with other functions)
ADC: AIN0-AIN7: P0.02-P0.05, P0.28-P0.31
NFC: NFC1: P0.09, NFC2: P0.10
```

## Power Consumption Examples

### Typical Use Cases
| Scenario | Current | Notes |
|----------|---------|-------|
| BLE advertising (1 Hz) | 10 µA avg | Connectable advertisement |
| BLE connection (100ms) | 15 µA avg | Data exchange every 100ms |
| BLE connection (1s) | 5 µA avg | Data exchange every 1 second |
| Sensor reading (1 Hz) | 20 µA avg | Periodic ADC + BLE send |
| Deep sleep (RAM retention) | 2 µA | Wake on GPIO or RTC |
| System OFF | 0.4 µA | No RAM retention |

### Coin Cell Battery Life
- **CR2032** (225 mAh):
 - BLE beacon (1 Hz): ~2.5 years
 - Sensor node (1 Hz): ~1.5 years
 - Always connected (100ms): ~6 months

## BERK Platform Modules

### Core Peripherals
1. **gpio.berk** - GPIO with port sensing and GPIOTE
2. **i2c.berk** - TWI master/slave with EasyDMA
3. **uart.berk** - UART with hardware flow control
4. **spi.berk** - SPI master/slave up to 8 Mbps
5. **pwm.berk** - 16-channel PWM
6. **adc.berk** - 12-bit SAADC with oversampling

### BLE Stack
7. **ble.berk** - BLE peripheral/central with SoftDevice S132
8. **ble_gatt.berk** - GATT server/client services

### Advanced Features
9. **nfc.berk** - NFC-A tag emulation
10. **usb.berk** - USB device (nRF52840/833)
11. **mesh.berk** - Bluetooth Mesh networking

## Code Examples

### BLE Heart Rate Sensor
```berk
use nrf52::ble;
use nrf52::adc;

let mut ble_peripheral = ble::Peripheral::new("HeartRate");
let mut hr_service = ble_peripheral.add_service(ble::HEART_RATE_SERVICE);
let hr_char = hr_service.add_characteristic(ble::HEART_RATE_MEASUREMENT);

ble_peripheral.start_advertising();

loop {
 let heart_rate = read_heart_rate_sensor();
 hr_char.notify(heart_rate);
 sleep_ms(1000);
}
```

### BLE Beacon
```berk
use nrf52::ble;

let beacon = ble::Beacon::new();
beacon.set_uuid("E2C56DB5-DFFB-48D2-B060-D0F5A71096E0");
beacon.set_major(1);
beacon.set_minor(100);
beacon.set_tx_power(-59);
beacon.start();
```

## Competitive Advantages

### vs ESP32
- **Power**: 10x better power efficiency
- **BLE**: Superior BLE stack and performance
- **Size**: Smaller form factor
- **Battery**: Designed for coin cell operation
- **Cost**: Comparable pricing
- **Trade-off**: No WiFi

### vs STM32 + external BLE
- **Integration**: Single-chip BLE solution
- **Power**: Optimized radio + CPU power management
- **Certification**: Pre-certified BLE stack
- **Ecosystem**: Mature BLE tools and examples
- **Trade-off**: Less general-purpose flexibility

## Target Applications

### Perfect For
- Fitness trackers and health monitors
- Wireless sensors (temperature, motion, etc.)
- Beacons and asset tracking
- Medical devices requiring BLE
- Battery-powered IoT devices
- Wireless audio (BLE Audio/LE Audio)
- Smart home accessories

### Not Ideal For
- WiFi connectivity required
- High processing power needs
- No wireless connectivity needed
- Cost extremely sensitive (< $1)

## Getting Started

### Hardware Requirements
- nRF52 DK (Development Kit) - $39
- Or any nRF52832/833/840 board
- USB cable for programming/debugging

### Software Requirements
- nRF5 SDK or nRF Connect SDK
- Segger Embedded Studio (free) or GCC toolchain
- nRF Command Line Tools
- BERK compiler with nRF52 support

### First Steps
1. Install nRF5 SDK
2. Flash SoftDevice S132/S140
3. Compile BERK program targeting nRF52
4. Flash and debug via SWD

## Additional Resources

- **Nordic Semiconductor**: https://www.nordicsemi.com/
- **nRF52 Product Page**: https://www.nordicsemi.com/Products/nRF52-Series
- **DevZone**: https://devzone.nordicsemi.com/ (support forum)
- **nRF5 SDK**: https://www.nordicsemi.com/Software-and-tools/Software/nRF5-SDK
- **nRF Connect SDK**: https://www.nordicsemi.com/Software-and-tools/Software/nRF-Connect-SDK

---

**Market Position**: BLE specialist, wearables leader (~15% embedded market)
**Sweet Spot**: Battery-powered BLE devices
**Key Advantage**: Best-in-class power efficiency and BLE stack
