# Firefox Portable launcher written in AutoHotkey
A much less bloated version of PortableApps.com's portable Firefox launcher.

* Supports backing up of your profile, data, and other settings.
* Doesn't need user intervention to update.
* Hopefully more soon!

## Dependencies
In order for backup compression and restoration, you need to have 7-Zip (specifically `7zG.exe`, `7z.exe`, and `7z.dll` from the binaries). An internet connection is required for updating via the menu.

## Setting download URL and download mode
### Fast download mode
The `FastDownloadMode` variable sets whether to use the current computer's temporary directory or to use the default (usually much slower) download directory.

### Download URL
By default the download URL is Mozilla's latest Firefox Beta Channel link. You can use any download URL as long as its an offline installer. I've put together some of the most used URLs below in a nice table:

| Firefox Edition | URL |
| ----------------- | ------------------ |
| Firefox Stable | https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US |
| Firefox Beta | https://download.mozilla.org/?product=firefox-beta-latest&os=win64&lang=en-US |
| Firefox Devloper Edition | https://download.mozilla.org/?product=firefox-aurora-latest-ssl&os=win64&lang=en-US |

Changing the download URL is done by changeing the `FirefoxDownloadURL` variable to one of the links above, or to one of your choice. In the future you should be able to input a link via a dialog, but this will do for now.

## Future plans
* Input a download link dialog on first startup.
* 32-bit & 64-bit versions.
* Configuration file support to store settings data.
* Auto backup of profile data.
* Extensions repository search support.
* Open with portable launcher support.

These will get implemented as I learn more about AutoHotkey and have enough time.
