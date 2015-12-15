#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
DetectHiddenWindows, On
DetectHiddenText, On
SetTitleMatchMode, RegEx
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
FirefoxDownloadLocation = %A_TEMP%\firefox_update.exe
ConfigurationLocation = %ResourcesDirectory%\configuration.ini
#SingleInstance, Force
IniRead, FirefoxDownloadURL, %ConfigurationLocation%, GENERAL, FirefoxDownloadURL

If IsRunningAsLibrary =
{
	MsgBox, 8208, Error, You are attempting to directly run this file. Running it directly could cause harm to your system.
	ErrorLevel = 1
	ExitApp
}

If UserIsChangingVersions = True ; Skip the warning dialog if the user just chose a different Firefox version.
{
	Process, Close, updater.exe
	Process, Close, firefox.exe
	Process, Close, crashreporter.exe
	GoSub, InitialUpdateStage
}

UserWarningMessageBox:
MsgBox, 308, Confirm Close, Firefox must be closed in order to update. Close all Firefox windows before updating or they will be closed by force.`n`nWould you like to continue?
IfMsgBox No 
{
	If IsFirstRun = True
	{
		ExitApp
	}
	Else
	{
		Return
	}
	}
Else IfMsgBox Yes
{
	Process, Close, updater.exe
	Process, Close, firefox.exe
	Process, Close, crashreporter.exe
	If IsFirstRun = True
	{
		FileCreateDir, %A_ScriptDir%\Resources
		FileCreateDir, %A_ScriptDir%\Backup
		FileCreateDir, %A_ScriptDir%\Data
		FileCreateDir, %A_ScriptDir%\Backup\Update
		FileCreateDir, %A_ScriptDir%\Profile
	}
}

InitialUpdateStage:
GUI FirefoxUpdateGUI: New,, Firefox Updater
GUI FirefoxUpdateGUI: Margin, 10, 10
GUI FirefoxUpdateGUI: Color, White
GUI FirefoxUpdateGUI: -SysMenu
GUI FirefoxUpdateGUI: Add, Text, vProgressSubtitleText, Firefox is being updated, please wait. This might take a while.
GUI FirefoxUpdateGUI: Add, Progress, h20 w400 -0x00000001 vFirefoxUpdateProgress Range0-60, 10
GUI FirefoxUpdateGUI: Font, Italic
GUI FirefoxUpdateGUI: Add, Text, cGray vProgressInfoText, Downloading the Mozilla Firefox installer...
GUI FirefoxUpdateGUI: Show

URLDownloadToFile, %FirefoxDownloadURL%, %FirefoxDownloadLocation% ; Download the installer from the specified download URL.
FileMove, %FirefoxDownloadLocation%, %FinalInstallerLocation% ; Move the installer from TEMP to the update directory.
IfNotExist, %FinalInstallerLocation% ; If we can't find the file, throw an error.
{
	GUI FirefoxUpdateGUI: Destroy
	
	MsgBox, 21, Error Finding Required File, The file required to initiate the update was not found. To update Firefox`, you must have "firefox_update.exe" placed in %FinalInstallerLocation%.`n`nThis installer must be the latest offline installer available from Mozilla. It can even be Alpha and Developer versions.
	IfMsgBox Retry
	{
		GUI Destroy
		GOTO InitialUpdateStage
	}
	Else IfMsgBox Cancel
	{
		If MainScriptIncluded = True
		{
			Return
		}
		Else
		{
			ExitApp
		}
	}
}

GUIControl, Text, ProgressInfoText, Backing up the old installation...
GUIControl,, FirefoxUpdateProgress, 20
FileDelete, %DataBackupLocation%
IfExist, %A_ScriptDir%\Data\firefox.exe
{
	RunWait, %7Zip% a %DataBackupLocation% %DataDirectory%\* -r0 -t7z -y -mx9 -mhc=on -mmt=on,, Hide ; Only do this if we have something to back up.
}

GUIControl, Text, ProgressInfoText, Removing the old installation...
GUIControl,, FirefoxUpdateProgress, 30
FileRemoveDir, %DataDirectory%, 1
FileCreateDir, %DataDirectory%

ControlMove, ProgressInfoText,,, 400
GUIControl, Text, ProgressInfoText, Extracting new data files from the installer...
GUIControl,, FirefoxUpdateProgress, 40
RunWait, %7Zip% x %FinalInstallerLocation% -y -o%UpdateDirectory%,, Hide ; Extract the installer via 7-Zip's ability to read executables.
FileCopyDir, %UpdateDirectory%\core, %DataDirectory%, 1 ; Copy the extracted installer to the final destination.

GUIControl, Text, ProgressInfoText, Cleaning up leftover information...
GUIControl,, FirefoxUpdateProgress, 50
FileRemoveDir, %UpdateDirectory%, 1
FileCreateDir, %UpdateDirectory%

MsgBox, 36, Update Successful, Firefox has been successfully updated. The newest version is installed.`n`nWould you like to launch it now?
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
