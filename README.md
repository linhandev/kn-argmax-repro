# kn-argmax-repro

Reproduction project for Kotlin/Native `GccBasedLinker` ARG_MAX failure on Linux.

## Problem

`GccBasedLinker` passes all library paths as individual command-line arguments to `ld.lld`.
With incremental compilation (`kotlin.incremental.native=true`), large projects generate
thousands of per-file cache archives (`.a`), exceeding Linux's 2MB `ARG_MAX` limit:

```
java.io.IOException: Exec failed, error: 7 (Argument list too long)
```

## Usage

```bash
# 1. Generate source files (default: 15000)
./generate-sources.sh

# 2. Attempt to link (fails on unfixed Kotlin/Native)
./gradlew linkDebugExecutableLinuxX64
```

## Metrics (15,000 source files)

| Metric | Value |
|--------|-------|
| Source files | 15,000 |
| Generated cache archives | ~25,000 |
| Total argument length | ~4 MB |
| Linux `ARG_MAX` | 2 MB |
| Result (unfixed) | `E2BIG` (error 7) |
| Result (fixed) | Success (~14s) |

## Fix

See [linhandev/kotlin#ld-command-too-long](https://github.com/linhandev/kotlin/tree/ld-command-too-long)
which adds response file support (`@file` syntax) to `GccBasedLinker`.
