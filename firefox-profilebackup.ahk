#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

STAGEZEROCODE_01: ; Stage zero code begin.
MsgBox, 4, Information, Firefox must be closed in order to backup your profile. Close all Firefox windows before backing up or they will be closed by force.`n`nWould you like to continue?
IfMsgBox No
Return
Else IfMsgBox Yes
; Stage zero code end.

STAGEONEGUI_01: ; First stage GUI begin.
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
; First stage GUI end.

STAGEONECODE_01: ; First stage code begin.
Process, Close, updater.exe
; First stage code end.

Sleep, 0500

STAGETWOGUI_01: ; Second stage GUI begin.
GUIControl, Text, ProfileProgressInfoText, Closing Firefox...
GUIControl,, ProfileBackupProgress, 20
; Second stage GUI end.

STAGETWOCODE_01: ; Second stage code begin.
Process, Close, firefox.exe
; Second stage code end.

Sleep, 0500

STAGETHREEGUI_01: ; Third stage GUI begin.
GUIControl, Text, ProfileProgressInfoText, Closing Firefox...
GUIControl,, ProfileBackupProgress, 30
; Third stage GUI end.

STAGETHREECODE_01: ; Third stage code begin.
Process, Close, crashreporter.exe
; Third stage code end.

Sleep, 0500

STAGEFOURGUI_01: ; Fourth stage GUI begin.
GUIControl, Text, ProfileProgressInfoText, Deleting old backup...
GUIControl,, ProfileBackupProgress, 40
; Fourth stage GUI end.

STAGEFOURCODE_01: ; Fourth stage code begin.
FileDelete, %A_ScriptDir%\Backup\PROFILE.7Z
; Fourth stage code end.

Sleep, 0500

STAGEFIVEGUI_01: ; Fifth stage GUI begin.
GUIControl, Text, ProfileProgressInfoText, Backing up your profile...
GUIControl,, ProfileBackupProgress, 50
; Fifth stage GUI end.

STAGEFIVECODE_01: ; Fifth stage code begin.
RunWait, Resources\7zG.exe a Backup\PROFILE.7Z .\Profile\* -r0 -t7z -y -mx9 -mhc=on -mmt=on,, Hide
; Fifth stage code end.

STAGEFINALGUI_01: ; Final stage GUI begin.
GUIControl, Text, ProfileProgressInfoText, The backup is complete. You can close this window.
GUIControl, Text, ProgressInfoText, Operation completed successfully.
GUIControl,, ProfileBackupProgress, 60
GUI Destroy
; Final stage GUI end.

STAGEFINALCODE_01: ; Final stage code begin.
MsgBox, 4, Operation completed successfully, Your profile has been successfully backed up.`n`nWould you like to relaunch Firefox?
IfMsgBox Yes
GOTO StartFirefoxNow
Else IfMsgBox No
Return
; Final stage code end.
