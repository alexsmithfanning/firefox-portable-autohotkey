#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
DataDirectory = %A_ScriptDir%\Data
DataBackupLocation = %A_ScriptDir%\Backup\DATA_OLD.7Z
FirefoxDownloadURL = https://download.mozilla.org/?product=firefox-beta-latest&os=win64&lang=en-US
FinalInstallerLocation = %A_ScriptDir%\Backup\Update\firefox_update.exe
BackupDirectory = %A_ScriptDir%\Backup
ProfileBackupLocation = %BackupDirectory%\PROFILE.7Z
7Zip = %A_ScriptDir%\Resources\7zG.exe
UpdateDirectory = %A_ScriptDir%\Backup\Update
FirefoxStartup = %DataDirectory%\firefox.exe
ProfileDirectory = %A_ScriptDir%\Profile
#SingleInstance, Force

If IsRunningAsLibrary = 
{
	MsgBox, 8208, Error, You are attempting to directly run this file. Running it directly could cause harm to your system.
	ErrorLevel = 1
	ExitApp
}

MsgBox, 308, Confirm Close, Firefox must be closed in order to backup your profile. Close all Firefox windows before backing up or they will be closed by force.`n`nWould you like to continue?
IfMsgBox No 
{
	Return
}
Else IfMsgBox Yes
{
	Process, Close, updater.exe
	Process, Close, firefox.exe
	Process, Close, crashreporter.exe
}

GUI FirefoxProfileBackupGUI: New,, Backup your profile
GUI FirefoxProfileBackupGUI: Margin, 10, 10
GUI FirefoxProfileBackupGUI: Color, White
GUI FirefoxProfileBackupGUI: -SysMenu
GUI FirefoxProfileBackupGUI: Font, s10
GUI FirefoxProfileBackupGUI: Add, Text, vProfileProgressSubtitleText, Your profile is being backed up, please wait. This might take a while.
GUI FirefoxProfileBackupGUI: Add, Progress, h20 w400 -0x00000001 vProfileBackupProgress Range0-60, 10
GUI FirefoxProfileBackupGUI: Font, Italic
GUI FirefoxProfileBackupGUI: Font, s7
GUI FirefoxProfileBackupGUI: Add, Text, cGray vProfileProgressInfoText, Preparing to backup your profile...
GUI FirefoxProfileBackupGUI: Show
GUIControl, Text, ProfileProgressInfoText, Deleting old backup...
GUIControl,, ProfileBackupProgress, 20
FileDelete, %ProfileBackupLocation%
GUIControl,, ProfileBackupProgress, 30
GUIControl, Text, ProfileProgressInfoText, Backing up your profile...
GUIControl,, ProfileBackupProgress, 40
GUIControl,, ProfileBackupProgress, 50
RunWait, %7Zip% a %ProfileBackupLocation% %ProfileDirectory%\* -r0 -t7z -y -mx9 -mhc=on -mmt=on,, Hide
GUIControl,, ProfileBackupProgress, 60
GUI FirefoxProfileBackupGUI: Destroy
MsgBox, 36, Profile Backup Successful, Your profile has been successfully backed up.`n`nWould you like to relaunch Firefox?
IfMsgBox Yes
{
	ErrorLevel = 0
	Reload
}
Else IfMsgBox No
{
	ErrorLevel = 0
	Return
}