#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

SetEnv, FirefoxStartup, %A_ScriptDir%\Data\firefox.exe -profile "Profile"

GUI FirefoxSearchGUI: New,, Search with Firefox
GUI FirefoxSearchGUI: Add, Edit, w300 vFirefoxSearchEdit
GUI FirefoxSearchGUI: Add, Button, Default w75 h25 x235 y35 gFirefoxSearchSubmit, Search
GUI FirefoxSearchGUI: Margin, 10, 10
GUI FirefoxSearchGUI: Color, White
GUI FirefoxSearchGUI: Show
Return

FirefoxSearchSubmit:
GUI FirefoxSearchGUI: Submit, Hide
Run, %FirefoxStartup% -search "%FirefoxSearchEdit%"
Return
