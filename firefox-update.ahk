#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force
DetectHiddenWindows, On
DetectHiddenText, On
SetBatchLines, -1
SetTitleMatchMode, RegEx
DataDirectory = %A_ScriptDir%\Data
DataBackupLocation = %A_ScriptDir%\Backup\DATA_OLD.7Z
FirefoxDownloadURL = https://download.mozilla.org/?product=firefox-beta-latest&os=win64&lang=en-US
FinalInstallerLocation = %A_ScriptDir%\Backup\Update\firefox_update.exe
7Zip = %A_ScriptDir%\Resources\7zG.exe
UpdateDirectory = %A_ScriptDir%\Backup\Update


{
	If MainScriptIncluded = True
	{
		If FastDownloadMode = True
		{
			FirefoxDownloadDestination = %A_Temp%\firefox_update.exe
		}
		Else
		{
			FirefoxDownloadDestination = %A_ScriptDir%\Backup\Update\firefox_update.exe
		}
	}
	Else
	{
		Menu, Tray, NoIcon
		FirefoxDownloadDestination = %A_ScriptDir%\Backup\Update\firefox_update.exe
	}
}

UserWarningMessageBox:
MsgBox, 308, Confirm Close, Firefox must be closed in order to update. Close all Firefox windows before updating or they will be closed by force.`n`nWould you like to continue?
	IfMsgBox No 
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
	Else IfMsgBox Yes
	{
		Process, Close, updater.exe
		Process, Close, firefox.exe
		Process, Close, crashreporter.exe
	}

InitialUpdateStage:
GUI FirefoxUpdateGUI: New,, Firefox Updater
GUI FirefoxUpdateGUI: Margin, 10, 10
GUI FirefoxUpdateGUI: Color, White
GUI FirefoxUpdateGUI: -SysMenu
GUI FirefoxUpdateGUI: Font, s10
GUI FirefoxUpdateGUI: Add, Text, vProgressSubtitleText, Firefox is being updated, please wait. This might take a while.
GUI FirefoxUpdateGUI: Add, Progress, h20 w400 -0x00000001 vFirefoxUpdateProgress Range0-60, 10
GUI FirefoxUpdateGUI: Font, Italic
GUI FirefoxUpdateGUI: Font, s7
GUI FirefoxUpdateGUI: Add, Text, cGray vProgressInfoText, Downloading the Mozilla Firefox installer...
GUI FirefoxUpdateGUI: Show

URLDownloadToFile, %FirefoxDownloadURL%, %FirefoxDownloadDestination%
FileMove, %FirefoxDownloadDestination%, %FinalInstallerLocation%
IfNotExist, %FinalInstallerLocation%
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

Sleep, 0500
GUIControl, Text, ProgressInfoText, Backing up the old installation...
GUIControl,, FirefoxUpdateProgress, 20
FileDelete, %DataBackupLocation%
IfExist, %A_ScriptDir%\Data\firefox.exe
{
	RunWait, %7Zip% a %DataBackupLocation% %DataDirectory%\* -r0 -t7z -y -mx9 -mhc=on -mmt=on,, Hide
}
Else
{
	IsFirstRun = True
}

GUIControl, Text, ProgressInfoText, Removing the old installation...
GUIControl,, FirefoxUpdateProgress, 30
FileRemoveDir, %DataDirectory%, 1
FileCreateDir, %DataDirectory%

GUIControl, Text, ProgressInfoText, Extracting new data files from the installer...
GUIControl,, FirefoxUpdateProgress, 40
RunWait, %7Zip% x %FinalInstallerLocation% -y -o%UpdateDirectory%,, Hide
FileCopyDir, %UpdateDirectory%\core, %DataDirectory%, 1

GUIControl, Text, ProgressInfoText, Cleaning up leftover information...
GUIControl,, FirefoxUpdateProgress, 50
FileRemoveDir, %UpdateDirectory%, 1
FileCreateDir, %UpdateDirectory%

MsgBox, 36, Update Successful, Firefox has been successfully updated. The newest version is installed.`n`nWould you like to launch it now?
	IfMsgBox Yes
	{
		Reload
	}
	Else IfMsgBox No
	{
		Return
	}
