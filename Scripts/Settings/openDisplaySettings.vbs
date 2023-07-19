Set WshShell = CreateObject("WScript.Shell")

cmds=WshShell.RUN("C:\Windows\explorer.exe ms-settings:display", 0, True)

Set WshShell = Nothing