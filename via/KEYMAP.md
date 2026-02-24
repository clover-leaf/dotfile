# Neo60 Core — Keymap Reference

Dvorak at OS level. VIA sends QWERTY keycodes.
Labels below show Dvorak output (what you see on screen).

## Layer Traversal

```
Layer 0 (Windows) <── TG(2) ──> Layer 2 (macOS)
       │                              │
    MO(1) hold                    MO(3) hold
       │                              │
Layer 1 (Win FN)               Layer 3 (Mac FN)
```

- TG(2) = rightmost bottom key on all layers
- FN keys: `[78]` split right shift extra + `[93]` bottom row

## Layer 0 — Windows Base

```
┌─────┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬──────┐
│CapsL│ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 8 │ 9 │ 0 │ [ │ ] │ Bksp │
├─────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬────┤
│  Tab  │ ' │ , │ . │ P │ Y │ F │ G │ C │ R │ L │ / │ = │  \ │
├───────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴────┤
│  Esc   │ A │ O │ E │ U │ I │ D │ H │ T │ N │ S │ - │ Enter │
├────────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─┬─────┤
│ LShift  │ ; │ Q │ J │ K │ X │ B │ M │ W │ V │ Z │RSft│ FN  │
├────┬────┴┬──┴─┬─┴───┴───┴───┴───┴───┴─┬─┴──┬┴───┼────┼─────┤
│LCtl│LWin │LAlt│         Space          │M(1)│M(0)│ FN │TG(2)│
└────┴─────┴────┴────────────────────────┴────┴────┴────┴─────┘
```

Changes from manufacturer:
- `[0]` Esc → CapsLock (swapped with `[48]`)
- `[48]` CapsLock → Escape (swapped with `[0]`)
- `[94]` RCtrl → TG(2) (toggle to macOS layer)

M(1)/M(0) at RAlt/RWin positions are firmware tri-mode hooks (do not modify).

## Layer 1 — Windows FN (hold FN from Layer 0)

```
┌─────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬──────┐
│  `  │ F1 │ F2 │ F3 │ F4 │ F5 │ F6 │ F7 │ F8 │ F9 │F10 │F11 │F12 │EECLR │
├─────┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬────┤
│  USB  │BLE1│BLE2│BLE3│2.4G│ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │
├───────┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴────┤
│  Caps  │C-a │C-c │C-v │C-x │ ▽  │ ?? │ ←  │ ↓  │ ↑  │ →  │ ▽  │   ▽   │
├────────┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴─┬──────┤
│    ▽    │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │  ▽   │
├────┬────┴┬──┴──┬─┴────┴────┴────┴────┴────┴┬──┴──┬┴───┼────┼─────┤
│ ▽  │WLock│  ▽  │            ▽              │RAlt │RGui│ ▽  │TG(2)│
└────┴─────┴─────┴───────────────────────────┴─────┴────┴────┴─────┘
```

- ▽ = KC_TRNS (transparent, falls through to Layer 0)
- ?? = CUSTOM(11) — undefined in board definition, no-op

Changes from manufacturer:
- `[49]` → LCTL(KC_A) = Ctrl+A (Select All)
- `[50]` → LCTL(KC_C) = Ctrl+C (Copy)
- `[51]` → LCTL(KC_V) = Ctrl+V (Paste) — **replaces BAT (battery query)**
- `[52]` → LCTL(KC_X) = Ctrl+X (Cut)
- `[55]` → KC_LEFT (←)
- `[56]` → KC_DOWN (↓)
- `[57]` → KC_UP (↑)
- `[58]` → KC_RGHT (→)
- `[94]` → TG(2)

Home row mapping (Dvorak label → physical QWERTY → action):

| Dvorak | Physical | VIA keycode  | Action     |
|--------|----------|--------------|------------|
| A      | A        | LCTL(KC_A)   | Select All |
| O      | S        | LCTL(KC_C)   | Copy       |
| E      | D        | LCTL(KC_V)   | Paste      |
| U      | F        | LCTL(KC_X)   | Cut        |
| H      | J        | KC_LEFT      | ←          |
| T      | K        | KC_DOWN      | ↓          |
| N      | L        | KC_UP        | ↑          |
| S      | ;        | KC_RGHT      | →          |

Ctrl shortcuts bypass OS Dvorak remapping, so LCTL(KC_A) = Ctrl+A regardless.

## Layer 2 — macOS Base (toggle via TG(2))

```
┌─────┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬───┬──────┐
│GEsc │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 8 │ 9 │ 0 │ [ │ ] │ Bksp │
├─────┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬────┤
│  Tab  │ ' │ , │ . │ P │ Y │ F │ G │ C │ R │ L │ / │ = │  \ │
├───────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴────┤
│  Caps  │ A │ O │ E │ U │ I │ D │ H │ T │ N │ S │ - │ Enter │
├────────┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴┬──┴─┬─────┤
│ LShift  │ ; │ Q │ J │ K │ X │ B │ M │ W │ V │ Z │RSft│ FN  │
├────┬────┴┬──┴─┬─┴───┴───┴───┴───┴───┴─┬─┴──┬┴───┼────┼─────┤
│LCtl│LAlt │LCmd│         Space          │RCmd│RAlt│ FN │TG(2)│
└────┴─────┴────┴────────────────────────┴────┴────┴────┴─────┘
```

Differences from Layer 0 (Windows):
- `[0]` GEsc = Esc normally, backtick with Shift/Cmd (useful for Cmd+`` ` `` window switching)
- `[48]` CapsLock (NOT swapped — differs from Layer 0)
- `[81]` LAlt (was LWin) — macOS modifier order
- `[82]` LCmd (was LAlt) — macOS modifier order
- `[89]` RCmd (was M(1))
- `[90]` RAlt (was M(0))

Changes from manufacturer:
- `[94]` RCtrl → TG(2) (toggle back to Windows layer)

## Layer 3 — macOS FN (hold FN from Layer 2)

```
┌─────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬────┬──────┐
│  `  │Bri-│Bri+│MCtl│ ⌘F │Siri│ ⌘⇧4│Prev│Play│Next│Mute│Vol-│Vol+│EECLR │
├─────┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬──┴─┬────┤
│  USB  │BLE1│BLE2│BLE3│2.4G│ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │
├───────┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴────┤
│  Caps  │ ▽  │ ▽  │BAT │ ▽  │ ▽  │ ?? │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │   ▽   │
├────────┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴┬───┴─┬──────┤
│    ▽    │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │ ▽  │  ▽   │
├────┬────┴┬──┴──┬─┴────┴────┴────┴────┴────┴┬──┴──┬┴───┼────┼─────┤
│ ▽  │WLock│  ▽  │            ▽              │RCmd │RAlt│ ▽  │TG(2)│
└────┴─────┴─────┴───────────────────────────┴─────┴────┴────┴─────┘
```

- ▽ = KC_TRNS (transparent, falls through to Layer 2)
- ?? = CUSTOM(11) — undefined in board definition, no-op
- BAT = battery status query

macOS media keys:
- Bri-/Bri+ = Screen brightness
- MCtl = Mission Control (Ctrl+Up)
- ⌘F = Cmd+F
- Siri = IOS_SIRI custom keycode
- ⌘⇧4 = Screenshot select area (Cmd+Shift+4)
- Prev/Play/Next = Media controls
- Mute/Vol-/Vol+ = Volume controls
- EECLR = Factory reset EEPROM (use with caution)

Changes from manufacturer:
- `[94]` RCtrl → TG(2) (toggle back to Windows layer)

## VIA Matrix Index Reference

Key indices used in this keymap (matrix = 6x16, index = row*16 + col):

```
Row 0:  [0]                          [17-28] number row  [29] Bksp
Row 1:  [32] Tab    [33-42] alpha    [43-45] [ ] \
Row 2:  [48] Caps   [49-58] alpha    [59] '  [61] Enter
Row 3:  [64] LSft   [66-75] alpha    [77] RSft [78] extra
Row 4:  [80] LCtl   [81] LGui/LAlt  [82] LAlt/LGui
        [85] Space  [89-90] R mods   [93] FN   [94] RCtl/TG(2)
```
