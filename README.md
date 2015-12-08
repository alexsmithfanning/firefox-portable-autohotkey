# Firefox Portable launcher written in AutoHotkey

A much less bloated version of PortableApps.com's portable Firefox launcher.

* Supports backing up of your profile, data, and other settings.
* Doesn't need user intervention to update.
* Hopefully more soon!

## Reason for creation

There's one and only one reason I'm going this far on this project: the launcher provided by PortableApps.com sucks. I want a way that I can just click a menu item and my profile will be backed up, or Firefox will update without me having to hassle with Administrator permissions and a setup installer.

In fact, I use this more than ten times a day. I'm a high school student and (in case you didn't know) they lock everything down like the Internet is nothing but porn and questionable opinions. While this may be true, I'm not going to let my school district deprive me of Firefox. That's where I draw the line.

## Dependencies

In order for semi-automatic updating, you need to have 7-Zip (specifically `7zG.exe`, `7z.exe`, and `7z.dll` from the binaries). An internet connection is required for updating via the menu. Hopefully in the future it won't need any external tools (apart from the libraries that I'm using).

## Setting download URL and download mode

### Fast download mode

The `FastDownloadMode` variable sets whether to use the current computer's temporary directory or to use the default (usually much slower) download directory. **The temporary directory is worlds faster though, so keep that in mind.**

So, in order to disable it, the code would look something like this:

```
FastDownloadMode = False ; Downloads the update to TEMP instead of the normal directory.
```

And don't worry; If you need help I'll gladly help you. Just create an issue and ask me, I'll guide you through the steps needed.

### Download URL
By default the download URL is Mozilla's latest Firefox Beta Channel link. You can use any download URL as long as its an offline installer. I've put together some of the most used URLs below in a nice table:

| Firefox Edition           | URL                                                                                 |
| ------------------------- | ----------------------------------------------------------------------------------- |
| Firefox Stable            | https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US            |
| Firefox Beta (Default)    | https://download.mozilla.org/?product=firefox-beta-latest&os=win64&lang=en-US       |
| Firefox Developer Edition | https://download.mozilla.org/?product=firefox-aurora-latest-ssl&os=win64&lang=en-US |

Changing the download URL is done by changing the `FirefoxDownloadURL` variable to one of the links above, or to one of your choice. In the future you should be able to input a link via a dialog, but this will do for now.

So, the code would look a little something like this:

```
FirefoxDownloadURL = https://download.mozilla.org/?product=firefox-beta-latest&os=win64&lang=en-US
```

This code is contained within `Firefox.ahk`.

## Future plans

* Input a download link dialog on first startup.
* 32-bit & 64-bit versions.
* Configuration file support to store settings data.
* Auto backup of profile data.
* Extensions repository search support.
* Open with portable launcher support.

These will get implemented as I learn more about AutoHotkey and have enough time.

## License

Copyright © 2015 Alex Smith-Fanning

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but *without any warranty*; without even the implied warranty of *merchantability* or *fitness for a particular purpose*. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
