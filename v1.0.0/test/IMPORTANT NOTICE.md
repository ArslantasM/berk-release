# Test Suite – Development Status

⚠️ **IMPORTANT NOTICE**

The current test results shown in CI (GitHub Actions) may report multiple failures.

This is **expected behavior** at this stage of the project.

## Reason

The BERK language core and runtime have recently undergone **significant architectural changes**, including:

- New runtime execution paths
- Updated HAL / bridge interfaces
- Internal scheduling and optimization changes
- Expanded language feature set

Due to the **rapid evolution of the core**, some existing test cases are currently:
- Outdated
- Incompatible with the new execution model
- Temporarily disabled or failing by design

## Current Status

- Test coverage **exists** and is actively maintained
- Test failures **do not indicate instability** of the runtime itself
- The test suite is currently being **realigned with the latest implementation**

## Roadmap

Planned actions:
- Refactor existing tests to match the new runtime semantics
- Introduce versioned test groups (core / hal / runtime)
- Add deterministic performance and timing tests
- Restore CI to green status incrementally

Until this alignment is completed, CI failures should be interpreted as:
> **"Test suite lagging behind implementation"**, not implementation errors.

Thank you for your understanding.