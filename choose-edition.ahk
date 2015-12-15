#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
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

IniRead, DownloadURLSelector, %ConfigurationLocation%, GENERAL, FirefoxDownloadURL
GUI ChooseEdition: New, -SysMenu, Choose Firefox Edition
GUI ChooseEdition: Margin, 10, 10
GUI ChooseEdition: Color, White
GUI ChooseEdition: Add, Text,, Please choose the edition of Firefox you would like the launcher to use.`n
If DownloadURLSelector = https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US
{
	GUI ChooseEdition: Add, Radio, vFirefoxStableEdition gUserChoseFirefoxStable Checked, Firefox Stable Edition
	StableAlreadySelected = True
}
Else
{
	GUI ChooseEdition: Add, Radio, vFirefoxStableEdition gUserChoseFirefoxStable, Firefox Stable Edition
}
If DownloadURLSelector = https://download.mozilla.org/?product=firefox-beta-latest&os=win64&lang=en-US
{
	GUI ChooseEdition: Add, Radio, vFirefoxBetaEdition gUserChoseFirefoxBeta Checked, Firefox Beta Edition
	BetaAlreadySelected = True
}
Else
{
	GUI ChooseEdition: Add, Radio, vFirefoxBetaEdition gUserChoseFirefoxBeta, Firefox Beta Edition
}
If DownloadURLSelector = https://download.mozilla.org/?product=firefox-aurora-latest-ssl&os=win64&lang=en-US
{
	GUI ChooseEdition: Add, Radio, vFirefoxDeveloperEdition gUserChoseFirefoxDeveloper Checked, Firefox Developer Edition
	DevelopmentAlreadySelected = True
}
Else
{
	GUI ChooseEdition: Add, Radio, vFirefoxDeveloperEdition gUserChoseFirefoxDeveloper, Firefox Developer Edition
}
GUI ChooseEdition: Add, Button, vChooseEditionContinueButton +Disabled gWriteURLSettingsToFile x310 y130 h30 w100, Continue
GUI ChooseEdition: Add, Button, vChooseEditionCancelButton gUserChoseToCancel x200 y130 h30 w100 Default, Cancel
GUI ChooseEdition: Show
Return

UserChoseFirefoxStable:
FirefoxURL = https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US
If StableAlreadySelected = True
{
	GUIControl, Disable, ChooseEditionContinueButton
}
Else
{
	GUIControl, Enable, ChooseEditionContinueButton
}
Return

UserChoseFirefoxBeta:
FirefoxURL = https://download.mozilla.org/?product=firefox-beta-latest&os=win64&lang=en-US
If BetaAlreadySelected = True
{
	GUIControl, Disable, ChooseEditionContinueButton
}
Else
{
	GUIControl, Enable, ChooseEditionContinueButton
}
Return

UserChoseFirefoxDeveloper:
FirefoxURL = https://download.mozilla.org/?product=firefox-aurora-latest-ssl&os=win64&lang=en-US
If DevelopmentAlreadySelected = True
{
	GUIControl, Disable, ChooseEditionContinueButton
}
Else
{
	GUIControl, Enable, ChooseEditionContinueButton
}
Return

WriteURLSettingsToFile:
MsgBox, 8483, Confirm Continue, The update could take as long as fifteen minutes. Are you sure you want to continue?
IfMsgBox, Yes
{
	GUI ChooseEdition: Destroy
	IniWrite, %FirefoxURL%, %ConfigurationLocation%, GENERAL, FirefoxDownloadURL
	IniRead, FirefoxDownloadURL, %ConfigurationLocation%, GENERAL, FirefoxDownloadURL
	UserIsChangingVersions = True
	GoSub, FirefoxUpdate
}
IfMsgBox, No
{
	Return
}
IfMsgBox, Cancel
{
	GUI ChooseEdition: Destroy
}
Return

UserChoseToCancel:
GUI ChooseEdition: Destroy
Return