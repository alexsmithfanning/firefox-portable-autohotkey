#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
DataDirectory = %A_ScriptDir%\Data
ResourcesDirectory = %A_ScriptDir%\Resources
DataBackupLocation = %A_ScriptDir%\Backup\DATA_OLD.7Z
FinalInstallerLocation = %A_ScriptDir%\Backup\Update\firefox_update.exe
BackupDirectory = %A_ScriptDir%\Backup
ProfileBackupLocation = %BackupDirectory%\PROFILE.7Z
7Zip = %A_ScriptDir%\Resources\7zG.exe
UpdateDirectory = %A_ScriptDir%\Backup\Update
FirefoxStartup = %DataDirectory%\firefox.exe
ProfileDirectory = %A_ScriptDir%\Profile
ConfigurationLocation = %ResourcesDirectory%\configuration.ini
#SingleInstance, Force

If IsRunningAsLibrary = 
{
	MsgBox, 8208, Error, You are attempting to directly run this file. Running it directly could cause harm to your system.
	ErrorLevel = 1
	ExitApp
}

GUI Settings: New, , Settings
GUI Settings: Margin, 10, 10
GUI Settings: Color, White
GUI Settings: Add, Checkbox, vFastDownloadModeCheckbox, Fast Download Mode
GUI Settings: Add, Button, vSettingsOkayButton gGetCheckedStateAndApplySettings y50 x140 w100 h30, OK
; GUI Settings: Add, Button, vSettingsCancelButton y50 x200 w100 h30, Cancel
GUI Settings: Show
Return

GetCheckedStateAndApplySettings:
If FastDownloadModeCheckbox =
{
	IniWrite, False, %ConfigurationLocation%, GENERAL, FastDownloadMode
}
Else
{
	IniWrite, True, %ConfigurationLocation%, GENERAL, FastDownloadMode
}
Return

