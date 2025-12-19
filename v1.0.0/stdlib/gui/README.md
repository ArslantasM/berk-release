# 🎨 BERK GUI Framework

**Profesyonel Seviye GUI Kütüphanesi**

BERK programlama dili için modern, güçlü ve esnek grafik kullanıcı arayüzü framework'ü.

## 📁 Modül Yapısı

```
gui/
├── core/                    # Çekirdek Modüller
│   ├── application.berk     # Uygulama yaşam döngüsü
│   ├── window.berk          # Pencere yönetimi
│   ├── event.berk           # Olay sistemi
│   └── context.berk         # Rendering context
│
├── rendering/               # Render Engine
│   ├── canvas.berk          # 2D çizim API'si
│   ├── painter.berk         # Painter pattern
│   ├── compositor.berk      # Layer compositing
│   └── backend.berk         # Platform backend (OpenGL/Vulkan/DirectX)
│
├── layout/                  # Layout Engine
│   ├── box_model.berk       # CSS-like box model
│   ├── flexbox.berk         # Flexbox layout
│   ├── grid.berk            # Grid layout
│   └── constraints.berk     # Constraint system
│
├── widgets/                 # Widget Library
│   ├── core/                # Temel widgetlar
│   │   ├── widget.berk      # Base widget class
│   │   ├── container.berk   # Container widget
│   │   └── text.berk        # Text widget
│   ├── input/               # Input widgetlar
│   │   ├── button.berk      # Button, IconButton, ToggleButton
│   │   ├── textfield.berk   # TextField, TextArea
│   │   ├── checkbox.berk    # Checkbox, Switch
│   │   ├── radio.berk       # RadioButton, RadioGroup
│   │   ├── slider.berk      # Slider, RangeSlider
│   │   ├── knob.berk        # Rotary knob control
│   │   └── dropdown.berk    # Dropdown, ComboBox
│   ├── display/             # Display widgetlar
│   │   ├── label.berk       # Label, Badge
│   │   ├── image.berk       # Image, Avatar
│   │   ├── progress.berk    # ProgressBar, ProgressRing
│   │   └── icon.berk        # Icon, IconSet
│   ├── container/           # Container widgetlar
│   │   ├── panel.berk       # Panel, Card
│   │   ├── scrollview.berk  # ScrollView
│   │   ├── tabview.berk     # TabView
│   │   └── splitview.berk   # SplitView
│   ├── navigation/          # Navigation widgetlar
│   │   ├── menubar.berk     # MenuBar, ContextMenu
│   │   ├── toolbar.berk     # Toolbar
│   │   └── nav.berk         # NavigationBar, Breadcrumb
│   ├── feedback/            # Feedback widgetlar
│   │   ├── dialog.berk      # Dialog, Modal
│   │   ├── toast.berk       # Toast, Snackbar
│   │   └── tooltip.berk     # Tooltip, Popover
│   ├── data/                # Data widgetlar
│   │   ├── table.berk       # DataGrid, Table
│   │   ├── treeview.berk    # TreeView
│   │   └── listview.berk    # ListView
│   └── specialized/         # Özel widgetlar
│       ├── gauge.berk       # Gauge, Meter
│       ├── vumeter.berk     # VU Meter, Level Meter
│       ├── oscilloscope.berk # Oscilloscope, Waveform
│       ├── led.berk         # LED Indicator
│       └── segment.berk     # 7-Segment Display
│
├── style/                   # Style Engine
│   ├── theme.berk           # Theme system
│   ├── colors.berk          # Color system
│   ├── typography.berk      # Font & text styles
│   ├── shadows.berk         # Shadow system
│   └── presets.berk         # Built-in themes (Dark, Light, etc.)
│
├── materials/               # Material System (Skeuomorphic)
│   ├── material.berk        # Base material
│   ├── metal.berk           # Metal (chrome, brass, brushed)
│   ├── glass.berk           # Glass, Frosted glass
│   ├── plastic.berk         # Plastic
│   └── fabric.berk          # Fabric, Leather
│
├── effects/                 # Visual Effects
│   ├── blur.berk            # Gaussian blur, Motion blur
│   ├── glow.berk            # Inner/Outer glow
│   ├── shadow.berk          # Drop shadow, Box shadow
│   ├── reflection.berk      # Reflection
│   └── lighting.berk        # Lighting engine
│
├── animation/               # Animation Engine
│   ├── tween.berk           # Tweening, Easing
│   ├── spring.berk          # Spring physics
│   ├── keyframe.berk        # Keyframe animation
│   └── transition.berk      # Widget transitions
│
├── a11y/                    # Accessibility
│   ├── aria.berk            # ARIA support
│   ├── focus.berk           # Focus management
│   └── keyboard.berk        # Keyboard navigation
│
└── tools/                   # Developer Tools
    ├── inspector.berk       # Widget inspector
    ├── debugger.berk        # Layout debugger
    └── profiler.berk        # Performance profiler
```

## 🚀 Hızlı Başlangıç

```berk
kullan gui::core::application
kullan gui::core::window
kullan gui::widgets::input::button
kullan gui::widgets::display::label
kullan gui::layout::flexbox
kullan gui::style::theme

fn main() döndür tamsayı:
    // Uygulama oluştur
    değişken app = Application::new("My App")
    
    // Tema ayarla
    app.theme = Theme::dark()
    
    // Ana pencere oluştur
    değişken pencere = Window::new("BERK GUI Demo", 800, 600)
    
    // Layout oluştur
    değişken layout = FlexBox::column()
        .padding(20)
        .gap(10)
    
    // Widgetlar ekle
    layout.add(Label::new("Merhaba BERK GUI!").font_size(24))
    layout.add(Button::new("Tıkla Bana").on_click(fn():
        yazdır("Butona tıklandı!")
    ))
    
    pencere.set_content(layout)
    
    // Uygulamayı çalıştır
    döndür app.run()
```

## 🎨 Skeuomorphic Gauge Örneği

```berk
kullan gui::widgets::specialized::gauge
kullan gui::materials::metal
kullan gui::effects::lighting

fn create_aircraft_gauge() döndür Gauge:
    değişken gauge = Gauge::circular()
        .range(0, 360)
        .value(180)
    
    // Material ekle
    gauge.background = Metal::brushed_aluminum()
    gauge.bezel = Metal::chrome()
    
    // İğne ayarla
    gauge.needle = Needle::new()
        .color(Color::red())
        .shadow(true)
        .glow(true)
    
    // Işıklandırma ekle
    gauge.add_layer(Lighting::ambient(0.3))
    gauge.add_layer(Lighting::directional(angle: 45, intensity: 0.7))
    gauge.add_layer(Reflection::new(angle: 45, intensity: 0.2))
    
    döndür gauge
```

## 🎛️ VU Meter Örneği

```berk
kullan gui::widgets::specialized::vumeter
kullan gui::animation::spring

fn create_vu_meter() döndür VUMeter:
    değişken vu = VUMeter::vintage()
        .scale_db(-20, 3)
        .peak_hold(true)
    
    // Needle physics
    vu.needle_physics = Spring::new()
        .stiffness(200)
        .damping(15)
    
    // Preset uygula
    vu.preset = VUMeterPreset::analog_classic
    
    döndür vu
```

## 📊 Özellik Matrisi

| Özellik | Durum |
|---------|-------|
| Core Window Management | ✅ |
| Event System | ✅ |
| Flexbox Layout | ✅ |
| Grid Layout | ✅ |
| Basic Widgets (20+) | ✅ |
| Specialized Widgets | ✅ |
| Theme Engine | ✅ |
| Material System | ✅ |
| Animation Engine | ✅ |
| Lighting Effects | ✅ |
| Accessibility (A11Y) | ✅ |
| Developer Tools | ✅ |

## 🔧 Backend Desteği

- **Windows**: Win32 + DirectX 11/12
- **Linux**: X11/Wayland + OpenGL/Vulkan
- **macOS**: Cocoa + Metal
- **Web**: WebAssembly + WebGL/WebGPU

## 📚 Daha Fazla Bilgi

Detaylı dokümantasyon için: [BERK GUI Documentation](https://berk-lang.github.io/gui)

---

**BERK GUI Framework v1.0** - Profesyonel GUI Geliştirme için Tasarlandı
