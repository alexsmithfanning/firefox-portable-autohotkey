#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

/*
Coming soon should be the ability to have updates happen without user intervention. The only thing holding me back right now is that I can't find a static URL for the latest version of Firefox. If you find one or find a way to implement this, create an issue or submit a pull request.
*/

STAGEZEROCODE: ; Stage zero code begin.
MsgBox, 4, Information, Firefox must be closed in order to update. Close all Firefox windows before updating or they will be closed by force.`n`nWould you like to continue?
IfMsgBox No
GOTO CANCELOPERATION
Else IfMsgBox Yes
; Stage zero code end.

STAGEONEGUI: ; First stage GUI begin.
GUI FirefoxUpdateGUI: New,, Firefox Updater
GUI FirefoxUpdateGUI: Margin, 10, 10
GUI FirefoxUpdateGUI: Color, White
GUI FirefoxUpdateGUI: -SysMenu
GUI FirefoxUpdateGUI: Font, s10
GUI FirefoxUpdateGUI: Add, Text, vProgressSubtitleText, Firefox is being updated, please wait. This might take a while.
GUI FirefoxUpdateGUI: Add, Progress, h20 w400 -0x00000001 vFirefoxUpdateProgress Range0-60, 10
GUI FirefoxUpdateGUI: Font, Italic
GUI FirefoxUpdateGUI: Font, s7
GUI FirefoxUpdateGUI: Add, Text, cGray vProgressInfoText, Checking for required update files to begin installation...
GUI FirefoxUpdateGUI: Show
; First stage GUI end.

STAGEONECODE: ; First stage code begin.
FileMove, %A_ScriptDir%\Backup\Update\*firefox*setup*.exe, %A_ScriptDir%\Backup\Update\firefox_update.exe
FileMove, %A_ScriptDir%\Backup\Update\*firefox*installer*.exe, %A_ScriptDir%\Backup\Update\firefox_update.exe
IfNotExist, %A_ScriptDir%\Backup\Update\firefox_update.exe
MsgBox, 5, Error, The file required to initiate the update was not found. To update Firefox, you must have "firefox_update.exe" placed in %A_ScriptDir%\Backup\Update.`n`nThis installer must be the latest offline installer available from Mozilla. It can even be Alpha and Developer versions.
IfMsgBox Retry
GOTO STAGEZEROCODE
Else IfMsgBox Cancel
Return
Process, Close, updater.exe
Process, Close, firefox.exe
Process, Close, crashreporter.exe
; First stage code end.

Sleep, 0500

STAGETWOGUI: ; Second stage GUI begin.
GUIControl, Text, ProgressInfoText, Backing up the old installation...
GUIControl,, FirefoxUpdateProgress, 20
; Second stage GUI end.

STAGETWOCODE: ; Second stage code begin.
FileDelete, %A_ScriptDir%\Backup\DATA_OLD
IfExist, %A_ScriptDir%\Data\firefox.exe
RunWait, Resources\7zG.exe a Backup\DATA_OLD.7Z .\Data\* -r0 -t7z -y -mx9 -mhc=on -mmt=on,, Hide
Else
; Second stage code end.

Sleep, 0500

STAGETHREEGUI: ; Third stage GUI begin.
GUIControl, Text, ProgressInfoText, Removing the old installation...
GUIControl,, FirefoxUpdateProgress, 30
; Third stage GUI end.

STAGETHREECODE: ; Third stage code begin.
FileRemoveDir, %A_ScriptDir%\Data, 1
FileCreateDir, %A_ScriptDir%\Data
; Third stage code end.

Sleep, 0500

STAGEFOURGUI: ; Fourth stage GUI begin.
GUIControl, Text, ProgressInfoText, Extracting new data files from the installer...
GUIControl,, FirefoxUpdateProgress, 40
; Fourth stage GUI end.

STAGEFOURCODE: ; Fourth stage code begin.
RunWait, Resources\7zG.exe x .\Backup\Update\firefox_update.exe -y -o%A_ScriptDir%\Backup\Update,, Hide
FileCopyDir, %A_ScriptDir%\Backup\Update\core, %A_ScriptDir%\Data, 1
; Fourth stage code end.

Sleep, 0500

STAGEFIVEGUI: ; Fifth stage GUI begin.
GUIControl, Text, ProgressInfoText, Cleaning up leftover information...
GUIControl,, FirefoxUpdateProgress, 50
; Fifth stage GUI end.

STAGEFIVECODE: ; Fifth stage code begin.
FileRemoveDir, %A_ScriptDir%\Backup\Update, 1
FileCreateDir, %A_ScriptDir%\Backup\Update
; Fifth stage code end.

Sleep, 0500

STAGEFINALGUI: ; Final stage GUI begin.
GUIControl, Text, ProgressSubtitleText, The update is complete. You can close this window.
GUIControl, Text, ProgressInfoText, Operation completed successfully.
GUIControl,, FirefoxUpdateProgress, 60
GUI Destroy
; Final stage GUI end.

STAGEFINALCODE: ; Final stage code begin.
MsgBox, 4, Operation completed successfully, Firefox has been successfully updated. The newest version is installed.`n`nWould you like to launch it now?
IfMsgBox Yes
Reload
Else IfMsgBox No
GOTO PlaceHolderGOTO
; Final stage code end.

CANCELOPERATION:
GUI Destroy
GOTO PlaceHolderGOTO
