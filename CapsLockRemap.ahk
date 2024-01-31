#NoEnv
#InstallKeybdHook
#SingleInstance, Force
Process, Priority,, H

; Capslock is bound to F13 by changing the registry

scripts_folder := A_ScriptDir . "\Scripts"
shortcut_folder := A_ScriptDir . "\Shortcuts"

; Buttons

; Capslock => Right click
F13::Send +{F10}

; Shift + Capslock => Capslock
+F13::Run "%scripts_folder%\ToggleCapslock\ToggleCapslock.vbs"

; Caps + spack => Enter
F13 & Space::Send {Enter}

; Caps + ; => Backspace
F13 & SC027::Send {Backspace}

; Caps + q => Escape
F13 & Q::Send {Escape}

; Macros
; Caps + c => Copy line
F13 & c::Run "%scripts_folder%\Macros\copyLine.ahk"

; Caps + x => Cut line
F13 & x::Run "%scripts_folder%\Macros\cutLine.ahk"

; Applications
; Caps + v => Volume mixer
F13 & v::Run "Sndvol.exe"

; Caps + f => Open the current tab in firefox
; By default open the tab in a new window
; If Alt is pressed open it as a new tab
; If Ctrl is pressed open it in chrome
F13 & f::
    send ^l
    send ^c
    If GetKeyState("Ctrl","p")
        Run, python.exe "%scripts_folder%\BrowserFromClipboard\chrome_from_clipboard.py"
    Else
        If GetKeyState("Alt","p")
            Run, python.exe "%scripts_folder%\BrowserFromClipboard\firefox_from_clipboard_reattach.py"
        Else
            Run, python.exe "%scripts_folder%\BrowserFromClipboard\firefox_from_clipboard.py"

return

; Navigation
; Caps + arrow key => Doc navigation
F13 & up::send {PgUp}
F13 & left::send {Home}
F13 & down::send {PgDn}
F13 & right::send {End}

; Caps + ijkl => Arrow keys
F13 & i::
    modifiers := GetMod()
    Send, %modifiers%{Up}
return
F13 & j::
    modifiers := GetMod()
    Send, %modifiers%{Left}
return
F13 & k::
    modifiers := GetMod()
    Send, %modifiers%{Down}
return
F13 & l::
    modifiers := GetMod()
    Send, %modifiers%{Right}
return
; Media
; Caps + wasd => Media controll
F13 & w::
    If GetKeyState("Ctrl","p")
        send {Volume_Up}
    Else
        send {Media_Play_Pause}
return
F13 & s::
    If GetKeyState("Ctrl","p")
        send {Volume_Down}
return
F13 & a::send {Media_Prev}
F13 & d::send {Media_Next}

callURLWithBrowser(browser_shortcut_file,url_file){
    ; This function take a url file and try to extract the url from it,
    ; and then open the url with the given browser shortcut.

    ; If a url can not be extracted from the url file, then a 1 is returned.

    ; Read the url file line by line.
    Loop, read, %url_file%
    {
        Loop, parse, A_LoopReadLine, %A_Tab%
        {
            ; If the line starts with "URL"
            if (SubStr(A_LoopField, 1, 3) = "URL"){
                ; Extract the url from the line
                url := SubStr(A_LoopField, 5)

                ; Open the url with the given browser shortcut
                Run, "%browser_shortcut_file%" "%url%"
                Return 0
            }

        }
    }
    ; If this function reaches the end, it means that the url_file does not
    ; contain the URL, and sumthing has gone wrong, and thus a 1 is returned
    Return 1
}

; TODO move these functions into their own file
callURL(browser_shortcut_folder,url_file){

    ; If the browser_shortcut_folder does not exist,
    ; then the url_file will be executed directly
    if (FileExist(browser_shortcut_folder)) {

        ; If a shortcut is found(which should be a shortcut to a web browser)
        ; inside browser_shortcut_folder
        ; then the url_file will be executed with the shortcut.
        Loop, Files, %browser_shortcut_folder%\*.lnk
        {
            ; Get the full file path of the web browser shortcut.
            browser_shortcut_file := browser_shortcut_folder . "\" . A_LoopFileName

            ; if callURLWithBrowser was successful, then return 0.
            if ( callURLWithBrowser(browser_shortcut_file,url_file) == 0){
                Return 0
            }
        }
    }

    ; If the web browser shortcut cannot be found, then the url_file will be
    ; executed directly.
    Run, "%url_file%"
}

; Functions
; Open a shortcut or url in a given folder based on the first character of its name
callShortcutFromIndex(shortcut_folder, index){
    ; For each shortcut in a given folder
    Loop, Files, %shortcut_folder%\*.lnk
    {
        ; If the first character shortcut matches the given index
        if (SubStr(A_LoopFileName, 1, 1) = index)
        {
            shortcut_file := shortcut_folder . "\" . A_LoopFileName

            Run "%shortcut_file%"
            return 0
        }
    }

    ; For each internet shortcut in a given folder
    Loop, Files, %shortcut_folder%\*.url
    {
        ; If the first character internet shortcut matches the given index
        if (SubStr(A_LoopFileName, 1, 1) = index)
        {
            browser_shortcut_folder := shortcut_folder . "\" . "BrowserShortcut"

            url_file := shortcut_folder . "\" . A_LoopFileName

            ; Run the internet shortcut
            callURL(browser_shortcut_folder, url_file)
            return 0
        }
    }
    MsgBox, Sorry, Shortcut not found
}

openTerminal(terminal){

    ; Part of this function where provided by ChatGPT

    ; Get the HWND (handle) of the active window
    WinGet, activeHwnd, ID, A
    ; Get the class name of the active window
    WinGetClass, activeWindowClass, ahk_id %activeHwnd%

    ; If the current window is the desktop, then set the window name to
    ; desktop.exe, this is to differentiate between the desktop and the file
    ; explorer.
    if (activeWindowClass = "Progman" or activeWindowClass = "WorkerW") {
        windowName := "desktop.exe"
    }
    ; If the current window is not the desktop, then get the process name of
    ; the active window using its HWND.
    else {
        ; Get the process name of the active window using its HWND
        WinGet, windowName, ProcessName, ahk_id %activeHwnd%
        StringLower, windowName, windowName
    }

    ; If the current window is vscode, then open the terminal using the
    ; vscode key combination Ctrl+Shift+'

    if (windowName = "code.exe") {
        SendInput ^+'

        ; If the terminal is not powershell.exe, then send the terminal name
        ; and enter to open the terminal.
        ; powershell.exe is the default terminal in vscode.
        if(terminal != "powershell.exe"){
            sleep, 500
            Send, %terminal%
            Send, {enter}
        }

    }
    ; If the current window is the file explorer, then open the terminal using
    ; the file explorer key combination Ctrl+L to focus the address bar, and
    ; then send the terminal name and enter to open the terminal.
    else if(windowName = "explorer.exe"){
        SendInput ^l
        sleep, 100
        Send, %terminal%
        Send, {enter}
    }
    ; If the current window is not vscode or file explorer, then open the
    ; terminal in the default terminal emulator wt.exe.
    else {
        ; the call to wt.exe is wrapped in powershell.exe to make sure that
        ; the terminal is opened in the default directory.
        Run, wt.exe powershell.exe %terminal%
    }

}

; Returns which modifier keys are currently pressed.
GetMod(){
    modifiers := ""
    if GetKeyState("Ctrl","p")
        modifiers .= "^"
    if GetKeyState("Alt","p")
        modifiers .= "!"
    if GetKeyState("Shift","p")
        modifiers .= "+"
    Return modifiers
}

; Shortcuts
; Caps + 1 => shortcut 1
F13 & 1::callShortcutFromIndex(shortcut_folder, 1)

; Caps + 2 => shortcut 2
F13 & 2::callShortcutFromIndex(shortcut_folder, 2)

; Caps + 3 => shortcut 3
F13 & 3::callShortcutFromIndex(shortcut_folder, 3)

; Caps + 4 => shortcut 4
F13 & 4::callShortcutFromIndex(shortcut_folder, 4)

; Caps + 5 => shortcut 5
F13 & 5::callShortcutFromIndex(shortcut_folder, 5)

; Caps + 6 => shortcut 6
F13 & 6::callShortcutFromIndex(shortcut_folder, 6)

; Caps + 7 => shortcut 7
F13 & 7::callShortcutFromIndex(shortcut_folder, 7)

; Caps + 8 => shortcut 8
F13 & 8::callShortcutFromIndex(shortcut_folder, 8)

; Caps + 9 => shortcut 9
F13 & 9::callShortcutFromIndex(shortcut_folder, 9)

; Caps + 0 => shortcut 0
F13 & 0::callShortcutFromIndex(shortcut_folder, 0)

; Settings
; Caps + b => Open Bluetooth Settings
F13 & b::Run "%scripts_folder%\Settings\OpenBluetoothSettings.vbs"

; Caps + p => Open Display settings
F13 & p::Run "%scripts_folder%\Settings\OpenDisplaySettings.vbs"

; TODO Come back and finish this.
; Caps + t => Open powershell.exe
; If Ctrl is pressed open wsl.exe
F13 & t::
    If GetKeyState("Ctrl","p")
        openTerminal("wsl.exe")
    Else
        openTerminal("powershell.exe")
return
; Prints
; Caps + g => print "@gmail.com"
F13 & g:: Send, @gmail.com

; Caps + h => prints the current date, DMY
; If Ctrl is pressed send YMD
; If Alt is pressed swap / for _
F13 & h::
    If GetKeyState("Alt","p")

        If GetKeyState("Ctrl","p")
            FormatTime, CurrentDateTime,, yyyy_MM_dd
        Else
            FormatTime, CurrentDateTime,, dd_MM_yyyy

    Else
        If GetKeyState("Ctrl","p")
            FormatTime, CurrentDateTime,, yyyy/MM/dd
        Else
            FormatTime, CurrentDateTime,, dd/MM/yyyy

    SendInput %CurrentDateTime%
return

; Temp
; This part is just to add single use macros to
; F13 & o::
;     Send, {F2}
;     Sleep, 100
;     Send, {Left}
;     Sleep, 100
;     Send, {Delete 4}
;     Sleep, 100
;     Send, {Enter}
;     Sleep, 100
;     Send, {Down}
; return
