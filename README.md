# 34-Key Layout using ZMK

| [🦀 Ferris Sweep](https://github.com/davidphilipbarr/Sweep) | [🪸 Urchin](https://github.com/duckyb/urchin) | [🧑‍🚀 Forager](https://github.com/carrefinho/forager) |
|-------------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------|

This is my personal [ZMK](https://zmk.dev/) keymap shared across three different 34-key keyboards. It’s drawn using [keymap-drawer](https://github.com/caksoylar/keymap-drawer) and includes configurations for both dongle-based and dongleless setups.

## Layout Philosophy

This layout is highly inspired by [manna-harbour/miryoku](https://github.com/manna-harbour/miryoku).

I don't stick to the "always use both hands" philosophy, as sometimes I find it more efficient/comfortable to use only one hand for things like:
- use media keys
- switch the apps
- control the mouse

---

## Key Features

- **Homerow Mods**
- **`Esc` and `Del` as combos**
    - In the 36-keys layout it will be separate keys, like in the Miryoku layout.
- **No symbols layer**
  - I find it more efficient to have only the _Num_ layer, and use `Shift` for symbols.
  - That way I don't have to switch layers that often when trying to type some combination of numbers and symbols.
- **Multiple ways of control the mouse**
  - Keep the right thumb key pressed and control the mouse with the left hand.
  - Toggle the _LMs+Med_ layer via combo and control the mouse with the left hand alone (helpful when my right hand is busy).
  - Toggle the _RMs_ layer via combo and control the mouse with the right hand alone (rarely used, as I have Kensington Slimblade to the right of my keeb).
- **Separate _AppNav_ layer for app navigation**
    - `Cmd+1-9` shortcuts for quick app switching via LaunchPalette.
    - `Gui+[` and `Gui+]` for history navigation (go back, go forward).
    - `Shift+Gui+[` and `Shift+Gui+]` for tab navigation (prev tab, next tab).
- **Macros for programming in PHP**
    - ThickArrow: `=>`
    - ThinArrow: `->`
---

## Layer Map

<p align="center">
<img src="./keymap-drawer/cradio.svg" alt="My personal keymap" width="1024">
</p>

---

## Firmware Builds

Keyboards support two connection styles:

### Dongle Setup

- `<keyboard_name>_dongle` → Flash to the dongle
- `<keyboard_name>_left_peripheral` → Flash to the left half
- `<keyboard_name>_right` → Flash to the right half

### Dongleless Setup

- `<keyboard_name>_left_central` → Flash to the left half (acting as central)
- `<keyboard_name>_right` → Flash to the right half

---

## Git Hooks - Automatic Keymap Visualization

This repository includes git hooks that automatically generate keymap visualization files after you modify it.

### One-Time Setup

To enable automatic keymap generation for your local development:

```bash
./hooks/install-hooks.sh
```

This will install a pre-commit hook that:
- Detects changes to any files in the `config/` directory
- Automatically runs `./generate-keymaps.sh`
- Adds generated files (`keymap-drawer/*.yaml` and `keymap-drawer/*.svg`) to your commit
- Blocks the commit if keymap generation fails

### Requirements

- [keymap-drawer](https://github.com/caksoylar/keymap-drawer) installed: `pip install keymap-drawer`

---

## Credits

- [MSmaili/zmk-config](https://github.com/MSmaili/zmk-config) and [caksoylar/zmk-config](https://github.com/caksoylar/zmk-config) - for many-keebs-in-1 repository inspiration with automatic keymap generation 
- [manna-harbour/miryoku](https://github.com/manna-harbour/miryoku) — for home-row mod philosophy and layout ideas  
