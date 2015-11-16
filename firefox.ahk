#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance, Force ; Not really needed because of #Persistent, but I like to keep it here anyway just to be safe.
#Persistent ; Makes the script persistent.
Menu, TRAY, NoStandard ; Removes standard AutoHotkey entries.
Menu, TRAY, Tip, Firefox is running

/*
if not A_Is64bitOS
{
   MsgBox, 0, Error, This version of the script can only run on sixty four bit operating systems. Grab the thirty two bit version from the same place that
   ExitApp
}
*/

; Hotkeys start.

; Hotkeys end.

IfNotExist, %A_ScriptDir%\Data\firefox.exe
GOTO FirefoxSetup
Else

SetEnv, 7ZGUI, %A_ScriptDir%\Resources\7zG.exe
SetEnv, FirefoxStartup, %A_ScriptDir%\Data\firefox.exe -profile "Profile"
EnvSet, COMSPEC, %A_ScriptDir%\Resources\cmd.exe
EnvSet, CMD, %A_ScriptDir%\Resources\cmd.exe
EnvSet, PATH, %A_ScriptDir%\Resources
EnvSet, PATH, %A_ScriptDir%\Data
EnvSet, PATH, %A_ScriptDir%\Profile
EnvSet, PATH, %A_ScriptDir%\Backup

OnExit, SanityCheck ; Prevents Firefox from having any leftover processes after we close.

Menu, TRAY, Add, Open new window, OpenNew
Menu, TRAY, Icon, Open new window, %A_ScriptDir%\Resources\icons.dll, 3, 0
Menu, TRAY, Add
Menu, TRAY, Add, Search, SearchWithFirefox
Menu, TRAY, Icon, Search, %A_ScriptDir%\Resources\icons.dll, 4, 0
Menu, TRAY, Add, Backup Profile, ProfileBackup
Menu, TRAY, Icon, Backup Profile, %A_ScriptDir%\Resources\icons.dll, 1, 0
Menu, TRAY, Add, Update Firefox, FirefoxUpdate
Menu, TRAY, Icon, Update Firefox, %A_ScriptDir%\Resources\icons.dll, 5, 0
Menu, TRAY, Add
Menu, TRAY, Add, Exit, CloseAll
Menu, TRAY, Icon, Exit, %A_ScriptDir%\Resources\icons.dll, 2, 0
Menu, TRAY, Tip, Firefox is running

StartFirefoxNow:
Run, %FirefoxStartup%
Return

OpenNew:
Run, %FirefoxStartup% -new-window
Return

SanityCheck:
Process, Close, updater.exe
Process, Close, firefox.exe
Process, Close, crashreporter.exe
ExitApp

ProfileBackup:
#Include firefox-profilebackup.ahk

FirefoxUpdate:
#Include firefox-update.ahk

SearchWithFirefox:
#Include search.ahk

FirefoxSetup:
#Include firefox-setup.ahk

StartSetup:
MsgBox, 0, Information, In order to start setup, a simple step has to be taken. Go to the Mozilla website and download the latest offline installer for Firefox. Do not run it. Place it in "%A_ScriptDir%\Backup\Updates" and click "OK".
FileMove, %A_ScriptDir%\Backup\Update\*firefox*setup*.exe, %A_ScriptDir%\Backup\Update\firefox_update.exe
FileMove, %A_ScriptDir%\Backup\Update\*firefox*installer*.exe, %A_ScriptDir%\Backup\Update\firefox_update.exe
RunWait, Resources\7zG.exe x .\Backup\Update\firefox_update.exe -y -o%A_ScriptDir%\Backup\Update
FileRemoveDir, %A_ScriptDir%\Data, 1
FileCreateDir, %A_ScriptDir%\Data
FileCopyDir, %A_ScriptDir%\Backup\Update\core, %A_ScriptDir%\Data, 1
FileRemoveDir, %A_ScriptDir%\Backup\Update, 1
FileCreateDir, %A_ScriptDir%\Backup\Update
Sleep, 2000
Reload

PlaceHolderGOTO:
Return

CloseAll:
ExitApp
