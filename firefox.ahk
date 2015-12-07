#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance, Force ; Not really needed because of #Persistent, but I like to keep it here anyway just to be safe.
#Persistent ; Makes the script persistent.
MainScriptIncluded = True ; No not remove this. Ever.
FastDownloadMode = True ; Downloads the update to TEMP instead of the normal directory.
DataDirectory = %A_ScriptDir%\Data
DataBackupLocation = %A_ScriptDir%\Backup\DATA_OLD.7Z
FirefoxDownloadURL = https://download.mozilla.org/?product=firefox-beta-latest&os=win64&lang=en-US
FinalInstallerLocation = %A_ScriptDir%\Backup\Update\firefox_update.exe
7Zip = %A_ScriptDir%\Resources\7zG.exe
UpdateDirectory = %A_ScriptDir%\Backup\Update
FirefoxStartup = %DataDirectory%\firefox.exe
Menu, TRAY, NoStandard ; Removes standard AutoHotkey entries.
Menu, TRAY, Tip, Firefox is running
SetBatchLines, -1

; Hotkeys start.

; Hotkeys end.

IfNotExist, %A_ScriptDir%\Data\firefox.exe
{
	GOTO FirefoxSetup
	IsFirstRun = True
}
Else
{
	IsFirstRun = False
}

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

FirefoxSetup:
#Include firefox-setup.ahk

PlaceHolderGOTO:
Return

CloseAll:
ExitApp
