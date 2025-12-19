# STM32F4 Platform HAL

STM32F4xx serisi ARM Cortex-M4F mikrodenetleyiciler için BERK HAL implementasyonu. STM32 HAL kütüphanesi bindings.

## 📁 Modüller

| Modül | Satır | Durum | Özellikler |
|-------|-------|-------|------------|
| **gpio.berk** | 320 | ✅ | Pin I/O, EXTI interrupts, multiple ports (A-E) |
| **i2c.berk** | 380 | ✅ | Master mode, hardware CRC, 16-bit registers |
| **uart.berk** | 350 | ✅ | Multi-UART (6 ports), DMA, flow control |
| **pwm.berk** | 420 | ✅ | Advanced timers, servo control, 16-bit resolution |
| **spi.berk** | 340 | ✅ | Master/slave, DMA, up to 42 MHz |
| **adc.berk** | 410 | ✅ | 12-bit SAR ADC, temperature sensor, VREF |
| **can.berk** | 380 | ✅ | bxCAN controller, 1 Mbit/s, 28 filters |
| **usb_cdc.berk** | 250 | ✅ | USB Device CDC (Virtual COM Port) |

**Toplam:** 2850 satır (8/8 modül) ✅ **TIER-1 COMPLETE**

## 🎯 Desteklenen STM32F4 Varyantlar

### STM32F401
- **Core:** ARM Cortex-M4F @ 84MHz
- **Flash:** 256-512KB
- **RAM:** 64-96KB
- **Package:** LQFP64, LQFP100
- **Price:** Budget option
- **Devkit:** STM32F401RE Nucleo

### STM32F407
- **Core:** ARM Cortex-M4F @ 168MHz
- **Flash:** 512KB-1MB
- **RAM:** 192KB (128KB main + 64KB CCM)
- **FPU:** Single precision
- **Peripherals:** 3x SPI, 3x I2C, 6x USART, 2x CAN, USB OTG
- **ADC:** 3x 12-bit (2.4 MSPS)
- **Timers:** 17 (12x 16-bit, 2x 32-bit)
- **GPIO:** 140 pins (LQFP144)
- **Devkit:** STM32F407VG Discovery, STM32F407ZG Nucleo-144
- **Use Case:** General purpose, industrial control

### STM32F429
- **Core:** ARM Cortex-M4F @ 180MHz
- **Flash:** 1-2MB
- **RAM:** 256KB (192KB main + 64KB CCM)
- **LCD:** Chrom-ART Accelerator (DMA2D)
- **Display:** LTDC controller
- **SDRAM:** FMC interface
- **Devkit:** STM32F429I-Discovery (2.4" LCD)
- **Use Case:** GUI applications, graphics

### STM32F446
- **Core:** ARM Cortex-M4F @ 180MHz
- **Flash:** 512KB
- **RAM:** 128KB
- **Audio:** SAI (Serial Audio Interface)
- **USB:** Dual OTG (FS + HS)
- **CAN:** Dual CAN-FD ready
- **QSPI:** Quad-SPI for external flash
- **Devkit:** STM32F446RE Nucleo
- **Use Case:** Audio processing, communications

## ⚡ Performance

| Feature | STM32F407 | STM32F429 | STM32F446 |
|---------|-----------|-----------|-----------|
| **Core Clock** | 168 MHz | 180 MHz | 180 MHz |
| **DMIPS** | 210 | 225 | 225 |
| **CoreMark** | 608 | 636 | 636 |
| **FPU** | Yes | Yes | Yes |
| **DSP** | Yes | Yes | Yes |
| **GPIO Toggle** | 42 MHz | 45 MHz | 45 MHz |
| **ADC Speed** | 2.4 MSPS | 2.4 MSPS | 2.4 MSPS |
| **I2C** | 400 kHz | 400 kHz | 1 MHz |
| **SPI** | 21 Mbps | 22.5 Mbps | 22.5 Mbps |
| **UART** | 10.5 Mbps | 11.25 Mbps | 11.25 Mbps |

## 🔧 Pin Mapping (STM32F407VG)

```
┌─────────────────────────────────────────┐
│         STM32F407VG (LQFP100)           │
├─────────────────────────────────────────┤
│  Power:                                 │
│    VDD: 1.8V - 3.6V                    │
│    VDDA: Analog supply                 │
│    VREF+: ADC reference                │
│                                         │
│  GPIO Ports:                            │
│    GPIOA: PA0-PA15 (ADC, USART, SPI)  │
│    GPIOB: PB0-PB15 (I2C, TIM, CAN)    │
│    GPIOC: PC0-PC15 (ADC, SPI)         │
│    GPIOD: PD0-PD15 (USART, FMC)       │
│    GPIOE: PE0-PE15 (TIM, FMC)         │
│    GPIOH: PH0-PH1  (Crystal)          │
│                                         │
│  Communication:                         │
│    USART1: PA9(TX), PA10(RX)          │
│    USART2: PA2(TX), PA3(RX)           │
│    USART3: PB10(TX), PB11(RX)         │
│    I2C1:   PB6(SCL), PB7(SDA)         │
│    I2C2:   PB10(SCL), PB11(SDA)       │
│    SPI1:   PA5(SCK), PA6(MISO), PA7(MOSI) │
│    SPI2:   PB13(SCK), PB14(MISO), PB15(MOSI) │
│    CAN1:   PB8(RX), PB9(TX)           │
│    USB:    PA11(DM), PA12(DP)         │
│                                         │
│  Timers:                                │
│    TIM1:   Advanced (PA8-PA11)        │
│    TIM2:   General (PA0-PA3)          │
│    TIM3:   General (PA6-PA7, PB0-PB1)│
│    TIM4:   General (PB6-PB9)          │
│                                         │
│  ADC:                                   │
│    ADC1:   PA0-PA7, PB0-PB1, PC0-PC5  │
│    ADC2:   PA0-PA7, PB0-PB1, PC0-PC5  │
│    ADC3:   PA0-PA3, PF6-PF10          │
│                                         │
│  Debug:                                 │
│    SWDIO:  PA13                        │
│    SWCLK:  PA14                        │
│    SWO:    PB3                         │
└─────────────────────────────────────────┘
```

## 🚀 Quick Start

```berk
import "embedded/platforms/stm32f4/gpio" as GPIO
import "embedded/platforms/stm32f4/uart" as UART

fn main() -> i32 {
    // Initialize system clock (168MHz)
    SystemClock.init()
    
    // LED on PA5
    GPIO.init_output(GPIO.Port.A, 5, GPIO.Speed.High)
    
    // UART2 on PA2/PA3
    UART.init(2, 115200)
    UART.println(2, "STM32F4 BERK HAL")
    
    loop {
        GPIO.toggle(GPIO.Port.A, 5)
        time.sleep_ms(500)
    }
}
```

## 📚 API Documentation

### GPIO Module

```berk
// Initialize output pin
GPIO.init_output(port: GPIO.Port, pin: u8, speed: GPIO.Speed)

// Initialize input pin
GPIO.init_input(port: GPIO.Port, pin: u8, pull: GPIO.Pull)

// Read/write
let level = GPIO.read(port: GPIO.Port, pin: u8)
GPIO.write(port: GPIO.Port, pin: u8, level: GPIO.Level)
GPIO.toggle(port: GPIO.Port, pin: u8)

// Interrupts (EXTI)
GPIO.init_interrupt(port: GPIO.Port, pin: u8, trigger: GPIO.Trigger, handler: fn())
GPIO.enable_interrupt(port: GPIO.Port, pin: u8)
GPIO.disable_interrupt(port: GPIO.Port, pin: u8)
```

### I2C Module

```berk
// Initialize I2C master
I2C.init(bus: u8, speed: u32) -> Result<()>

// Read/write
I2C.write(bus: u8, addr: u8, data: &[u8]) -> Result<()>
I2C.read(bus: u8, addr: u8, buffer: &mut [u8]) -> Result<()>

// Register access
I2C.write_register(bus: u8, addr: u8, reg: u8, data: &[u8]) -> Result<()>
I2C.read_register(bus: u8, addr: u8, reg: u8, buffer: &mut [u8]) -> Result<()>
```

### CAN Bus Module (STM32-specific)

```berk
// Initialize CAN bus
CAN.init(bus: u8, bitrate: u32) -> Result<()>

// Configure filters
CAN.add_filter(bus: u8, id: u32, mask: u32) -> Result<()>

// Send/receive
CAN.send(bus: u8, id: u32, data: &[u8]) -> Result<()>
CAN.receive(bus: u8) -> Result<CAN.Message>

// Error handling
CAN.get_error_count(bus: u8) -> (u8, u8)  // (tx_errors, rx_errors)
```

## 🔌 Peripheral Availability

### STM32F407VG

| Peripheral | Count | DMA | Notes |
|------------|-------|-----|-------|
| GPIO | 82 pins | - | 5V tolerant |
| USART | 6 | Yes | Up to 10.5 Mbps |
| I2C | 3 | Yes | Fast mode+ |
| SPI | 3 | Yes | Up to 21 Mbps |
| TIM | 14 | Yes | Advanced/General/Basic |
| ADC | 3 | Yes | 12-bit, 2.4 MSPS |
| DAC | 2 | Yes | 12-bit |
| CAN | 2 | - | CAN 2.0B |
| USB OTG | 2 | Yes | FS + HS |
| SDIO | 1 | Yes | SD/MMC cards |
| RTC | 1 | - | Calendar, alarm |
| CRC | 1 | - | Hardware CRC32 |
| RNG | 1 | - | True random |

## ⚠️ Known Limitations

1. **5V Tolerance:**
   - Most GPIO pins are 5V tolerant
   - Check datasheet for specific pins
   - ADC pins are NOT 5V tolerant

2. **ADC2 Limitations:**
   - ADC2 channels overlap with GPIOA
   - ADC3 has fewer channels (STM32F40x)

3. **USB and CAN Conflicts:**
   - USB and CAN1 share some pins
   - Careful pin planning required

4. **DMA Streams:**
   - Limited DMA streams (8 per controller)
   - Some peripherals share streams
   - Prioritize critical peripherals

5. **CCM RAM:**
   - 64KB CCM RAM not DMA-accessible
   - Use for stack/heap, not buffers
   - Place DMA buffers in main RAM

6. **BOOT pins:**
   - BOOT0: Must be low for normal operation
   - BOOT1: Configurable

## 🛠️ Development Tools

- **IDE:** STM32CubeIDE, Keil MDK, IAR EWARM
- **Debugger:** ST-Link V2/V3, J-Link
- **Bootloader:** STM32 USB DFU, UART bootloader
- **HAL Version:** STM32Cube HAL v1.8.x
- **CMSIS:** ARM CMSIS 5.x

## 📦 Memory Layout

```
STM32F407VG Memory Map:
┌─────────────────────────────────┐
│ 0x0800 0000 - 0x080F FFFF       │ Flash (1MB)
│ 0x2000 0000 - 0x2001 FFFF       │ SRAM1 (112KB)
│ 0x2002 0000 - 0x2002 FFFF       │ SRAM2 (16KB)
│ 0x1000 0000 - 0x1000 FFFF       │ CCM RAM (64KB)
│ 0x4000 0000 - 0x5FFF FFFF       │ Peripherals
│ 0xE000 0000 - 0xE00F FFFF       │ Cortex-M4 Core
└─────────────────────────────────┘
```

## 🎓 Learning Resources

- **STM32F4 Reference Manual (RM0090)**
- **STM32F407 Datasheet**
- **AN4013: STM32 Cross-series timer overview**
- **AN4031: Using the STM32F2/F4/F7 DMA controller**
- **UM1472: STM32CubeMX user manual**

## 🏭 Industrial Applications

STM32F4 is widely used in:
- **Industrial automation** (PLCs, motor control)
- **Automotive** (ECUs, body control modules)
- **Medical devices** (patient monitors)
- **Audio processing** (DSP, effects processors)
- **Building automation** (HVAC, lighting control)
- **Robotics** (motor drivers, sensor fusion)

**Market Share:** 25% of ARM Cortex-M4 market (estimated)

**Manufacturer:** STMicroelectronics
**Production Status:** Active (since 2011)
**Lifetime:** 10+ years guaranteed availability
