# Nuvoton M0/M4 Platform Support

## Overview

Nuvoton M0/M4 series targets Asia-Pacific markets and industrial IoT applications. Known for competitive pricing and industrial-grade reliability.

**Market Share**: ~3% of embedded market (Asia markets, industrial IoT)

## Target Markets
- **Industrial IoT**: Sensors, controllers (~35%)
- **Asia-Pacific**: Domestic Taiwan/China market (~30%)
- **Motor Control**: BLDC, stepper drivers (~15%)
- **Consumer**: Home appliances (~12%)
- **Security**: Authentication chips (~8%)

## Chip Families

### M031 Series (Cortex-M0)
- **CPU**: ARM Cortex-M0 @ 48/72 MHz
- **Flash**: 16 KB - 128 KB  
- **RAM**: 4 KB - 16 KB
- **Price**: ~$0.30-0.80
- **Use Case**: Ultra-low cost applications

### M032 Series (Cortex-M0)
- **CPU**: ARM Cortex-M0 @ 48/72 MHz
- **Flash**: 32 KB - 256 KB
- **RAM**: 8 KB - 32 KB
- **USB**: USB 2.0 FS device
- **Price**: ~$0.40-1.00
- **Use Case**: USB applications

### M2351 Series (Cortex-M23, Secure)
- **CPU**: ARM Cortex-M23 @ 64 MHz
- **Security**: TrustZone, crypto accelerator
- **Flash**: 256 KB - 512 KB
- **RAM**: 64 KB - 96 KB
- **Price**: ~$1.50-2.50
- **Use Case**: IoT security

### M467 Series (Cortex-M4F)
- **CPU**: ARM Cortex-M4F @ 200 MHz
- **Flash**: 512 KB - 1 MB
- **RAM**: 384 KB
- **Ethernet**: 10/100 Mbps
- **USB**: HS + OTG
- **Price**: ~$2.00-3.50
- **Use Case**: Industrial ethernet, HMI

## Key Features

### Cost-Competitive
- 15-30% cheaper than comparable chips
- Good availability in Asia
- Aggressive volume pricing

### Industrial Grade
- Wide temperature range (-40°C to +105°C)
- ESD protection
- Long-term availability commitment

### Rich Peripherals
- CAN FD support
- Quadrature encoder interface (QEI)
- Enhanced PWM for motor control
- Hardware crypto engines

## BERK Platform Modules

1. **gpio.berk** - Standard GPIO
2. **i2c.berk** - I2C master/slave
3. **uart.berk** - UART/USART
4. **spi.berk** - SPI master/slave
5. **pwm.berk** - Advanced PWM for motors
6. **adc.berk** - 12-bit ADC
7. **qei.berk** - Quadrature encoder (unique)
8. **canfd.berk** - CAN FD support

---

**Market Position**: Asia markets, industrial IoT (~3% market)
**Sweet Spot**: Cost-competitive industrial applications
**Key Advantage**: Industrial reliability + competitive pricing
