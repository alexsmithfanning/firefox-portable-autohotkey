#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
#SingleInstance, Force ; Not really needed because of #Persistent, but I like to keep it here anyway just to be safe.
#Persistent ; Makes the script persistent.
IsRunningAsLibrary = True ; No not remove this. Ever. This will break a lot of shit you really don't want broken.
FastDownloadMode = True ; Downloads the update to TEMP instead of the normal directory.
DataDirectory = %A_ScriptDir%\Data
DataBackupLocation = %A_ScriptDir%\Backup\DATA_OLD.7Z
FinalInstallerLocation = %A_ScriptDir%\Backup\Update\firefox_update.exe
7Zip = %A_ScriptDir%\Resources\7zG.exe
UpdateDirectory = %A_ScriptDir%\Backup\Update
FirefoxStartup = %DataDirectory%\firefox.exe -profile "Profile"
ResourcesDirectory = %A_ScriptDir%\Resources
BackupDirectory = %A_ScriptDir%\Backup
ConfigurationLocation = %ResourcesDirectory%\configuration.ini
IniRead, FirefoxDownloadURL, %ConfigurationLocation%, GENERAL, FirefoxDownloadURL
Menu, TRAY, NoStandard ; Removes standard AutoHotkey entries.
Menu, TRAY, Tip, Firefox is running

; Hotkeys start.

; Hotkeys end.

If A_Is64bitOS = 0
{
	MsgBox, 16, Error, You are running a 32-bit version of Windows. Only 64-bit versions are currently supported.
	ExitApp
}

IfNotExist, %A_ScriptDir%\Data\firefox.exe
{
	IsFirstRun = True
	GOTO FirefoxUpdate
}
Else
{
	IsFirstRun = False
}

OnExit, SanityCheck ; Prevents Firefox from having any leftover processes after we close.

Menu, TRAY, Add, Open new window, OpenNew
Menu, TRAY, Add
Menu, TRAY, Add, Backup Profile, ProfileBackup
Menu, TRAY, Add, Update Firefox, FirefoxUpdate
Menu, TRAY, Add
Menu, SettingsSubmenu, Add, Change Edition, ChooseEdition
Menu, Tray, Add, Settings, :SettingsSubmenu
Menu, TRAY, Add
Menu, TRAY, Add, Exit, CloseAll
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
ErrorLevel = 0
ExitApp

ProfileBackup:
#Include firefox-profilebackup.ahk
Return

FirefoxUpdate:
#Include firefox-update.ahk
Return

ChooseEdition:
#Include choose-edition.ahk
Return

SettingsDialog:
#Include settings.ahk
Return

CloseAll:
ExitApp