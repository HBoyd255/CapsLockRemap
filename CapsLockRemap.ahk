#NoEnv
#InstallKeybdHook
#SingleInstance, Force
Process, Priority,, H

; Capslock is bound to F13 by changing the registry

shortcut_folder_path := A_ScriptDir . "\Shortcuts"
scripts_folder_path := A_ScriptDir . "\Scripts"

; Buttons

; Shift + Capslock => Capslock
+F13::Run "%scripts_folder_path%\ToggleCapslock\ToggleCapslock.vbs"

; Caps + I => Insert
F13 & i::Send {Insert}

; Macros
; Caps + C => Copy line
F13 & c::Run "%scripts_folder_path%\Macros\copyLine.exe"

; Caps + X => Cut line
F13 & x::Run "%scripts_folder_path%\Macros\cutLine.exe"

; Applications
; Caps + V => Volume mixer
F13 & v::Run "Sndvol.exe"

; Caps + F => Open the current tab in firefox
; By default open the tab in a new window
; If Alt is pressed open it as a new tab
; If Ctrl is pressed open it in chrome
F13 & f::
    send ^l
    send ^c
    If GetKeyState("Ctrl","p")
        Run, python.exe "%scripts_folder_path%\BrowserFromClipboard\chrome_from_clipboard.py"
    Else
        If GetKeyState("alt","p")
            Run, python.exe "%scripts_folder_path%\BrowserFromClipboard\firefox_from_clipboard_reattach.py"
        Else
            Run, python.exe "%scripts_folder_path%\BrowserFromClipboard\firefox_from_clipboard.py"

return

; Navigation
; Caps + arrow key => doc navigation
F13 & up::send {PgUp}
F13 & down::send {PgDn}
F13 & left::send {Home}
F13 & right::send {End}

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

; Functions
; Open a shortcut or url in a given folder based on the first character of its name
OpenFolderFromIndex(Folder, index){
    ; For each shortcut in a given folder
    Loop, Files, %Folder%\*.lnk
    {
        ; If the shortcut matches the given index
        if (SubStr(A_LoopFileName, 1, 1) = index)
        {
            ; Run the shortcut
            Run "%Folder%\%A_LoopFileName%"
            return 0
        }
    }

    ; For each internet shortcut in a given folder
    Loop, Files, %Folder%\*.url
    {
        ; If the internet shortcut matches the given index
        if (SubStr(A_LoopFileName, 1, 1) = index)
        {
            ; Run the internet shortcut
            Run "%Folder%\%A_LoopFileName%"
            return 0
        }
    }
    MsgBox, Sorry, Shortcut not found
}

; Shortcuts
; Caps + 1 => shortcut 1
F13 & 1::OpenFolderFromIndex(shortcut_folder_path, 1)

; Caps + 2 => shortcut 2
F13 & 2::OpenFolderFromIndex(shortcut_folder_path, 2)

; Caps + 3 => shortcut 3
F13 & 3::OpenFolderFromIndex(shortcut_folder_path, 3)

; Caps + 4 => shortcut 4
F13 & 4::OpenFolderFromIndex(shortcut_folder_path, 4)

; Caps + 5 => shortcut 5
F13 & 5::OpenFolderFromIndex(shortcut_folder_path, 5)

; Caps + 6 => shortcut 6
F13 & 6::OpenFolderFromIndex(shortcut_folder_path, 6)

; Caps + 7 => shortcut 7
F13 & 7::OpenFolderFromIndex(shortcut_folder_path, 7)

; Caps + 8 => shortcut 8
F13 & 8::OpenFolderFromIndex(shortcut_folder_path, 8)

; Caps + 9 => shortcut 9
F13 & 9::OpenFolderFromIndex(shortcut_folder_path, 9)

; Caps + 0 => shortcut 0
F13 & 0::OpenFolderFromIndex(shortcut_folder_path, 0)

; Settings
; Caps + k => Open Bluetooth Settings
F13 & k::Run "%scripts_folder_path%\Settings\OpenBluetoothSettings.vbs"

; Caps + P => Open Display settings
F13 & p::Run "%scripts_folder_path%\Settings\OpenDisplaySettings.vbs"

; Caps + T => Open Touchpad settings
F13 & t::Run "%scripts_folder_path%\Settings\OpenTouchpadSettings.vbs"

; Prints
; Caps + G => print "@gmail.com"
F13 & g:: Send, @gmail.com

; Caps + H => prints the current date, DMY
; If Ctrl is pressed send YMD
; If alt is pressed swap / for _
F13 & h::
    If GetKeyState("alt","p")

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
