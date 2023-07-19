# Caps lock Remap

This AutoHotkey scripts adds additional functionality to the caps lock key by
having it rebound to F13 and then creating an array of F13 shortcuts.

I don't think it makes sense that the caps lock key only has one function,
especially when most of its neighbors all have hundreds of different
functions, and combinations. I set out to address this by assigning 30+
new shortcuts to the caps lock key.

## Requirements

- AutoHotkey. You can download it from the [official AutoHotkey website](https://www.autohotkey.com/).
- Python. You can download it from the [official Python website](https://www.python.org/downloads/).

## Getting started

1. Clone or download this repository.
2. Compile `"CapsLockRemap.ahk"` into `"CapsLockRemap.exe"`.
3. Add a shortcut to `"CapsLockRemap.exe"` to your startup folder.
4. Rename Shortcuts_template`"Shortcuts_template"` to `"Shortcuts"`.
5. Populate `"Shortcuts"` with your desired shortcuts. The number in front of each shortcut is important, it corresponds with the button pressed to call each shortcut.
6. (Optional) Create a backup of your registry.
7. Double-click `"map_capslock_to_f13.reg"` to map the caps lock key to F13.

## Usage

This script gives the following keybindings to the caps lock key:

### Buttons

- Capslock => Right Click
- Shift + Capslock => Capslock
- Caps + I => Insert

### Macros

- Caps + C => Copy line
- Caps + X => Cut line

### Applications

- Caps + V => Volume Mixer
- Caps + F => Open the current tab in Firefox:
  - By default, opens the tab in a new window.
  - If Alt is pressed, opens it as a new tab.
  - If Ctrl is pressed, opens it in Chrome.

### Navigation

- Caps + Arrow Key => Document Navigation

### Media

- Caps + WASD => Media Control

### Shortcuts

- Caps + 1 to 9, and 0 => Open specific shortcuts or URLs based on the first character of their names.

### Settings

- Caps + K => Bluetooth Settings
- Caps + P => Display Settings
- Caps + T => Touchpad Settings

### Prints

- Caps + G => Print "@gmail.com"
- Caps + H => Prints the current date in DMY format. If Ctrl is pressed, send YMD. If Alt is pressed, swap "/" for "_".
- Caps + H => Prints the current date
  - By default, prints dd/MM/yyyy
  - If Ctrl is pressed, prints dd/MM/yyyy
  - If Alt is pressed, prints dd_MM_yyyy
  - If Alt and Ctrl are pressed, prints yyyy_MM_dd

### Temp

This section includes temporary single-use macros. Uncomment and modify as needed.

## Customization

You can customize the keybindings and functionality by modifying the script file 
CapsLockRemap.ahk. Refer to the AutoHotkey documentation for syntax and available commands.

## Credit

Credit for map_capslock_to_f13.reg goes to http://www.grismar.net/ventrilocapsfix/

## Disclaimer

This script is provided as-is, without any warranty or guarantee. Use it at your own risk.