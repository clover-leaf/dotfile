# Neo60 Core — Dvorak VIA Keymap

Custom VIA keymap for the Qwertykeys Neo60 Core (tri-mode) with OS-level Dvorak.

## Files

| File | Purpose |
|---|---|
| `neo60.layout.json` | VIA keymap — import into VIA to apply |
| `Neo60Cu_trimode.JSON` | Board definition — load in VIA Design tab |
| `KEYMAP.md` | Visual keymap reference for all 4 layers |

## Layout Overview

| Layer | Mode | Access |
|---|---|---|
| 0 | Windows base | Default |
| 1 | Windows FN (F-keys, nav, wireless) | Hold FN from Layer 0 |
| 2 | macOS base (Cmd/Alt swapped) | TG(2) from Layer 0 |
| 3 | macOS FN (media, wireless) | Hold FN from Layer 2 |

## Layer Traversal

```
Layer 0 (Windows) <── TG(2) ──> Layer 2 (macOS)
       │                              │
    MO(1) hold                    MO(3) hold
       │                              │
Layer 1 (Win FN)               Layer 3 (Mac FN)
```

- **TG(2)** = rightmost bottom key (was RCtrl) on all layers
- **FN** = split right shift extra `[78]` + bottom row `[93]`

## Custom Changes

### Layer 0 — Windows Base
- Esc ↔ CapsLock swapped
- `[94]` RCtrl → TG(2)

### Layer 1 — Windows FN
- Home row left (Dvorak A O E U): Ctrl+A, Ctrl+C, Ctrl+V, Ctrl+X
- Home row right (Dvorak H T N S): ← ↓ ↑ →
- `[94]` RCtrl → TG(2)
- All wireless controls (USB/BLE/2.4G), WLock, EECLR preserved

### Layer 2 — macOS Base
- `[94]` RCtrl → TG(2)
- Everything else manufacturer default (macOS modifier layout)

### Layer 3 — macOS FN
- `[94]` RCtrl → TG(2)
- Everything else manufacturer default (media keys, BAT query)

## Setup

1. Open [VIA](https://usevia.app) in Chrome
2. Load `Neo60Cu_trimode.JSON` in the **Design** tab
3. Connect keyboard, authorize in the **Configure** tab
4. Click the **Load** icon (↑ arrow), select `neo60.layout.json`
5. Done — changes apply instantly and persist on the keyboard

## Notes

- Dvorak is handled at the OS level, not in firmware
- VIA keycodes are QWERTY-based; the OS converts them
- Ctrl shortcuts (Ctrl+C/V etc.) bypass OS Dvorak remapping
- Keymap is stored on keyboard — no driver needed after setup
- Works across USB, Bluetooth, and 2.4GHz
- **Alt+Z (UniKey):** Not currently mapped. Candidate position: split right shift extra key `[78]` on Layer 0 (currently second FN). You still have FN at `[93]`, so `[78]` can be repurposed without losing FN access.
- **Layer 2 note:** Esc/CapsLock is NOT swapped on Layer 2 (uses GEsc instead). Layer 3 has no home row nav keys. These can be added for cross-OS consistency.
- `vendorProductId`: 917516380
