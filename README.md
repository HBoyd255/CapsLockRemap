# Caps Lock Remap

This AutoHotkey scripts adds additional functionality to the caps lock key by
having it rebound to F13 and then creating an array of F13 shortcuts.

I don't think it makes sense that the caps lock key only has one function,
especially when most of its neighbors all have hundreds of different functions,
and combinations. I set out to address this by assigning 30+ new shortcuts to
the caps lock key.

## Requirements

- AutoHotkey. You can download it from the [official AutoHotkey website]
  (https://www.autohotkey.com/).
- Python. You can download it from the [official Python website]
  (https://www.python.org/downloads/).

- Python module `pyperclip`. You can install it using pip:
  `pip install pyperclip`.

## Getting started

1. Clone or download this repository.
2. Compile `"CapsLockRemap.ahk"` into `"CapsLockRemap.exe"`.
3. Add a shortcut to `"CapsLockRemap.exe"` to your startup folder.
4. Rename Shortcuts_template`"Shortcuts_template"` to `"Shortcuts"`.
5. Populate `"Shortcuts"` with your desired shortcuts. The number in front of
   each shortcut is important, it corresponds with the button pressed to call
   each shortcut.
6. (Optional) Create a backup of your registry.
7. Double-click `"map_capslock_to_f13.reg"` to map the caps lock key to F13.

## Usage

This script gives the following keybindings to the caps lock key:

### Buttons

- Caps => Right click
- Caps + Shift => Caps lock
- Caps + Space => Enter
- Caps + ; => Backspace
- Caps + Q => Escape

### Macros

- Caps + C => Copy line
- Caps + X => Cut line
- Caps + N => Take a screenshot, Email it to myself. This functionality is
  provided by my
  [screenshot-to-email](https://github.com/HBoyd255/screenshot-to-email) script.

### Applications

- Caps + V => Volume Mixer
- Caps + F => Open the current tab in Firefox:
  - By default, opens the tab in a new window.
  - If Alt is pressed, opens it as a new tab.
  - If Ctrl is pressed, opens it in Chrome.
- Caps + T => Opens Powershell.exe
  - If Ctrl is pressed, opens Wsl.exe
  - integrates with explorer.exe and vscode

### Navigation

- Caps + Arrow Key => Document Navigation
- Caps + IJKL => Arrow keys

### Media

- Caps + WASD => Media Control

### Shortcuts

- Caps + 1 to 9, and 0 => Open specific shortcuts or URLs based on the first
  character of their names. For example, if you have a shortcut named
  "5_GitHub.url", pressing Caps + 5 will open it.
- Additionally, if you place a shortcut to a web browser in
  `Shortcuts\BrowserShortcut`, any URL will be opened in that browser. The
  reason for this feature is so I can call my shortcuts using my Firefox
  redirector, as seen on
  [my Github](https://github.com/H-Boyd/FirefoxRedirector).

### Settings

- Caps + B => Bluetooth Settings
- Caps + P => Display Settings

### Prints

- Caps + G => Print "@gmail.com", if ctrl is pressed, prints my full email
  address.
- Caps + H => Prints a signature, containing my name, email, the current date.

### Temp

This section includes temporary single-use macros. Uncomment and modify as
needed.

## Customization

You can customize the keybindings and functionality by modifying the script
CapsLockRemap.ahk. Refer to the AutoHotkey documentation for syntax and
available commands.

## Future Plans

- Explore the creation of a dedicated keyboard that directly outputs the F13
  signal in place of Capslock. This would allow users to harness the
  capabilities of this project without the need to modify their system registry.

## Credit

Credit for map_capslock_to_f13.reg goes to
http://www.grismar.net/ventrilocapsfix/

## Disclaimer

This script is provided as-is, without any warranty or guarantee. Use it at your
own risk.
