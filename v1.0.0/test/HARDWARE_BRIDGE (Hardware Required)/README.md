# Hardware Bridge Demo Dosyaları

Bu klasör BERK'in **Hardware Bridge** özelliklerini gösteren demo dosyalarını içerir.

##  Dosyalar

| Dosya | Açıklama |
|-------|----------|
| `01_serial.berk` | USB/Serial port iletişimi |
| `02_firmata.berk` | Arduino StandardFirmata protokolü |
| `03_modbus.berk` | Modbus RTU endüstriyel iletişim |
| `04_slip.berk` | RFC 1055 SLIP paket çerçeveleme |
| `05_binproto.berk` | Özel binary protokol framework |
| `06_arduino_led.berk` | Arduino LED kontrolü (tam örnek) |
| `07_sensor_reading.berk` | Sensör okuma (Modbus) |
| `08_robot_arm.berk` | Robot kol servo kontrolü |

##  Gereksinimler

### Donanım
- Arduino Uno/Mega (Firmata örnekleri için)
- USB-Serial adaptör
- Modbus cihazı (isteğe bağlı)

### Yazılım
- Arduino IDE (StandardFirmata yüklemek için)
- CH340/CP2102 sürücüleri (gerekirse)

##  Kullanım

```powershell
# Tek bir demo çalıştır
berk run 01_serial.berk

# Port listesi görüntüle
berk run -e "kullan std::serial; yazdır(serial::list_ports())"
```

##  Not

Bu demolar **gerçek donanım** gerektirir. Donanım bağlı değilse hata mesajları alırsınız.
