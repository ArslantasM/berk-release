# BERK v1.0.0 Release

**Release Date:** December 20, 2025

---

## Contents

```
v1.0.0/
├── setup.ps1          # Windows Installer Script
├── bin/               # Executables & Libraries
│   ├── berk-lang.exe  # BERK Compiler & Runtime
│   ├── berk-lsp.exe   # Language Server Protocol
│   ├── berk-repl.exe  # Interactive REPL
│   ├── LLVM-C.dll     # LLVM C API
│   ├── LTO.dll        # Link-Time Optimization
│   ├── libz3.dll      # Z3 Theorem Prover
│   └── Remarks.dll    # LLVM Remarks
├── stdlib/            # Standard Library (188 files, 50+ modules)
└── test/              # Test Suite (62 tests)
```

---

## Installation

### Windows (Recommended)

1. Extract the release archive
2. Run the setup script:
   ```powershell
   .\setup.ps1
   ```
3. Open a new terminal and verify:
   ```powershell
   berk-lang --version
   ```

### Manual Installation

1. Extract the release archive
2. Add the `bin` folder to your PATH:
   ```powershell
   $env:PATH += ";C:\path\to\berk-release\v1.0.0\bin"
   ```
3. Set BERK_HOME (optional):
   ```powershell
   $env:BERK_HOME = "C:\path\to\berk-release\v1.0.0"
   ```

---

## Quick Start

### Run a BERK file
```powershell
berk-lang run hello.berk
```

### Start the REPL
```powershell
berk-repl
```

### Parse and analyze
```powershell
berk-lang parse myfile.berk
berk-lang lint myfile.berk
```

---

## Standard Library Modules

| Category | Modules |
|----------|---------|
| Core | `io`, `fs`, `sys`, `time`, `string`, `fmt` |
| Collections | `collections`, `iter` |
| Math | `math`, `complex`, `linalg`, `stats`, `random`, `optim` |
| Data Formats | `json`, `xml`, `yaml`, `csv`, `encoding` |
| Networking | `network`, `http` |
| Crypto | `crypto`, `compression`, `regex` |
| Concurrency | `async`, `thread` |
| Multimedia | `audio`, `graphics`, `image`, `color`, `gui` |
| 3D/Physics | `cad3d`, `mesh`, `math_3d`, `physics`, `physics2d` |
| Database | `sqlite` |
| Testing | `testing`, `logging`, `result` |
| Embedded | `embedded/*` (HAL modules) |

**Total:** 46 modules, 2900+ functions

---

## VS Code Extension

For the best development experience, install the BERK VS Code extension:

- Marketplace: Search "BERK" in VS Code Extensions
- Features: Syntax highlighting, IntelliSense, LSP integration, linting

---

## Documentation

- Language Guide: https://arslantasm.github.io/berk/
- Stdlib API: https://arslantasm.github.io/berk-stdlib-docs/
- GitHub: https://github.com/ArslantasM/berk

---

## What's New in v1.0.0

### Major Features
- Production-ready compiler with LLVM backend
- Complete standard library (97% coverage)
- Full LSP implementation (9/9 features)
- Hardware Abstraction Layer for 5 platforms
- Hardware Bridge for PC-device communication

### Performance
- SPSC throughput: 1,284M ops/s
- Bounded MPSC: 567M ops/s
- Region memory: 263x faster than malloc/free

### Platforms
- Windows (x64)
- Linux (x64, ARM64)
- macOS (x64, ARM64)
- Embedded: ESP32, STM32, Arduino, RISC-V, Nordic nRF52

---

## License

GPL-3.0 License

---

## Support

- Issues: https://github.com/ArslantasM/berk/issues
- Email: arslantas.m@gmail.com

---

**Made in Türkiye**
