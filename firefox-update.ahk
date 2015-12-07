#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

FirefoxSetupFirstStep:
GUI FirefoxInstallGUI: New,, Firefox Installer
GUI FirefoxInstallGUI: Margin, 10, 10
GUI FirefoxInstallGUI: Color, White
GUI FirefoxInstallGUI: -SysMenu
GUI FirefoxInstallGUI: Font, s10
GUI FirefoxInstallGUI: Add, Link, vFirefoxSetupInstructions, In order to start setup, a few steps have to be completed:`n`n1. Go to the Mozilla website and download the latest <a href="https://www.mozilla.org/en-US/firefox/all/#en-US">offline installer for Firefox</a>.`n2. Place it in "%A_ScriptDir%\Backup\Updates" then click "Next".
GUI FirefoxInstallGUI: Add, Button, Default gFirefoxSetupNextButton_01 vFirefoxSetupNextButtonVariable_01 w100 x360, Next
GUI FirefoxInstallGUI: Show
Return

FirefoxSetupRetryButton_01:
GUIControl, Show, FirefoxSetupNextButtonVariable_01
GUIControl, Hide, FirefoxSetupRetryButtonVariable_01
FirefoxSetupNextButton_01:
GUIControl, Disable, FirefoxSetupNextButtonVariable_01
GUIControl, Hide, FirefoxSetupInstructions
GUI FirefoxInstallGUI: Add, Text, x10 y10 vSearchingInfoMainText, Please wait. We are searching for the installer.
GUI FirefoxInstallGUI: Font, Italic
GUI FirefoxInstallGUI: Font, s10
GUI FirefoxInstallGUI: Add, Text, x10 y90 cGray vSearchingInfoSubtext, Searching for installer...
GUI FirefoxInstallGUI: Add, Progress, x10 y45 w450 h20 hwndMARQ4 -0x00000001 +0x00000008 vSearchingInfoProgressBar, 50
DllCall("User32.dll\SendMessage", "Ptr", MARQ4, "Int", 0x00000400 + 10, "Ptr", 1, "Ptr", 10)
Sleep, 5000
IfExist, C:\Users\%A_UserName%\Downloads\*firefox*setup*.exe
{
FileMove, C:\Users\%A_UserName%\Downloads\*firefox*setup*.exe, %A_ScriptDir%\Backup\Update\firefox_update.exe, 1
SetEnv, InstallerLocation, C:\Users\%A_UserName%\Downloads
GOTO FoundInstaller
}
Else
IfExist, C:\Users\%A_UserName%\Downloads\*firefox*installer*.exe
{
FileMove, C:\Users\%A_UserName%\Downloads\*firefox*installer*.exe, %A_ScriptDir%\Backup\Update\firefox_update.exe, 1
SetEnv, InstallerLocation, C:\Users\%A_UserName%\Downloads
GOTO FoundInstaller
}
Else
IfExist, %A_ScriptDir%\Backup\Update\*firefox*setup*.exe
{
FileMove, %A_ScriptDir%\Backup\Update\*firefox*setup*.exe, %A_ScriptDir%\Backup\Update\firefox_update.exe, 1
SetEnv, InstallerLocation, %A_ScriptDir%\Backup\Update\
GOTO FoundInstaller
}
Else
IfExist, %A_ScriptDir%\Backup\Update\*firefox*installer*.exe
{
FileMove, %A_ScriptDir%\Backup\Update\*firefox*installer*.exe, %A_ScriptDir%\Backup\Update\firefox_update.exe, 1
SetEnv, InstallerLocation, %A_ScriptDir%\Backup\Update\
GOTO FoundInstaller
}
Else
IfExist, %A_Desktop%\*firefox*setup*.exe
{
FileMove, %A_Desktop%\*firefox*setup*.exe, %A_ScriptDir%\Backup\Update\firefox_update.exe, 1
SetEnv, InstallerLocation, %A_Desktop%\
GOTO FoundInstaller
}
Else
IfExist, %A_Desktop%\*firefox*installer*.exe
{
FileMove, %A_Desktop%\*firefox*installer*.exe, %A_ScriptDir%\Backup\Update\firefox_update.exe, 1
SetEnv, InstallerLocation, %A_Desktop%\
GOTO FoundInstaller
}
Else
GOTO ErrorInstallerNotFound

FoundInstaller:
GUI FirefoxInstallGUI: Destroy
SetTimer, ChangeContinueDialogButtonName, 0
MsgBox, 0, Continue Installation, We found the installer located in: %InstallerLocation%.`n`nPress Continue to continue the installation.`n`nNote: Do not be concerned that it says update instead of install. The installer just uses the same process that the updater does.
SetEnv, InstallMode, 0
SetTimer, InformationAutoClose, 0
GOTO FirefoxUpdate

ChangeContinueDialogButtonName:
IfWinNotExist, Continue Installation
    Return  ; Keep waiting.
SetTimer, ChangeContinueDialogButtonName, OFF
WinActivate
ControlSetText, Button1, Continue
Return

InformationAutoClose:
SetKeyDelay, -1
IfWinNotExist, Information
Return
SetTimer, InformationAutoClose, OFF
WinActivate
ControlSend, ahk_parent, {Enter}, Information,,,,
Return

ErrorInstallerNotFound:
GUI FirefoxInstallGUI: Destroy
MsgBox, 5, Error, The installer could not be found. Remember to place it in "%A_ScriptDir%\Backup\Updates\".`n`nYou could also place it in the following other locations:`n`n1. "%A_Desktop%".`n2. "C:\Users\%A_UserName%\Downloads".`n`nPress Cancel to kill the application or press Retry to try to locate the installer again.
IfMsgBox, Cancel
ExitApp
IfMsgBox, Retry
GOTO FirefoxSetupFirstStep
