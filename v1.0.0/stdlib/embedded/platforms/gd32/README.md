# GigaDevice GD32 Platform Support

## Overview

GigaDevice GD32 is a cost-optimized ARM Cortex-M microcontroller series, designed as a pin-compatible alternative to STM32. Dominates cost-sensitive markets, particularly in Asia.

**Market Share**: ~7% of embedded market (STM32-compatible, cost-sensitive)

## Target Markets
- **Consumer Electronics**: Cost-sensitive appliances (~35%)
- **Industrial Control**: Budget automation (~25%)
- **Asia-Pacific**: Domestic Chinese market (~20%)
- **Education**: Budget development boards (~10%)
- **Replacement**: STM32 shortage alternative (~10%)

## Key Advantages

### Pin-Compatible with STM32
- Drop-in replacement for many STM32F1/F3/F4 chips
- Reuse existing PCB designs
- Compatible peripheral registers (mostly)
- Same packaging options

### Cost Leadership
- **20-40% cheaper** than equivalent STM32
- Target: $0.50 - $2.00 per chip
- Aggressive pricing strategy
- High volume availability

### Performance Match
- Same ARM Cortex-M cores
- Comparable clock speeds (up to 200 MHz)
- Similar peripheral set
- Compatible CMSIS support

## Chip Families

### GD32F103 (STM32F1 equivalent)
- **CPU**: ARM Cortex-M3 @ 108 MHz
- **Flash**: 64 KB - 1 MB
- **RAM**: 20 KB - 96 KB
- **Price**: ~$0.50-1.50
- **Use Case**: STM32F103 replacement

### GD32F3X0 (STM32F030 equivalent)
- **CPU**: ARM Cortex-M4F @ 120 MHz
- **Flash**: 16 KB - 256 KB
- **RAM**: 4 KB - 32 KB
- **Price**: ~$0.40-1.00
- **Use Case**: Entry-level applications

### GD32F4XX (STM32F4 equivalent)
- **CPU**: ARM Cortex-M4F @ 168-200 MHz
- **Flash**: 512 KB - 3 MB
- **RAM**: 128 KB - 512 KB
- **Peripherals**: USB OTG, Ethernet, CAN
- **Price**: ~$1.50-3.00
- **Use Case**: High-performance, cost-sensitive

## BERK Platform Modules

Since GD32 is STM32-compatible, we can reuse most STM32 modules:

1. **gpio.berk** - Compatible with STM32 HAL
2. **i2c.berk** - Same I2C peripheral
3. **uart.berk** - Compatible USART
4. **spi.berk** - Same SPI interface
5. **pwm.berk** - TIM compatibility
6. **adc.berk** - Similar ADC architecture
7. **can.berk** - bxCAN compatible

## Compatibility Notes

GD32 modules will be lightweight wrappers pointing to STM32 implementations with minor adjustments for GD32-specific differences.

---

**Market Position**: STM32 alternative, cost leader (~7% market)
**Sweet Spot**: Cost-sensitive, high-volume production
**Key Advantage**: 20-40% cost savings, pin-compatible
