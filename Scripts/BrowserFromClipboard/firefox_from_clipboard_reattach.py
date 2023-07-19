"""
chrome_from_clipboard.py

This is a very simple script to get the contents of the clipboard, and search
for it in chrome.

"""

import os
import pyperclip

os.system("start firefox " + pyperclip.paste())
