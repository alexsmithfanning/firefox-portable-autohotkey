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

## Features and options

### Backup your profile

To backup your profile, just head down and right click the tray icon, then select `Backup Profile`. It'll walk you through the steps needed to backup your profile.

### Fast download mode

Currently the settings for fast download mode are broken. Hopefully they'll be fixed soon.

### Setting Firefox version

If you want to change what version of Firefox to use, simply right click the tray icon and select `Change Edition` and it'll give you a dialog asking you what version of Firefox it should update to. I'll give a basic breakdown of what these different versions are:

| Firefox Version               | Description                                                                                                                                                                                                                              |
| ----------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Firefox Stable Edition        | This version is recommended for users new to the Firefox experience. It's the **most stable** of the versions listed here.                                                                                                               |
| Firefox Beta Edition          | This version is for users who aren't necessarily power users, but want the newer features in a more stable environment. **Some things might be broken** or not work, but is much less buggy than the Developer Edition.                  |
| Firefox Developer Edition     | This special version of Firefox is reserved for **power users only**. It is likely to have many bugs, and comes with a theme that normal users wouldn't be familiar with.                                                                |
| Nightly Edition (unstable)    | This version is the **bleeding edge**. This version might not work at all, it gets built by server bots *every night* regardless of whether or not it works. Only use this if you're completely insane and want people to know it.       |

## Future plans

* ~~Dialog to choose what version you want.~~ **Done!**
* 32-bit & 64-bit versions.
* Configuration file support to store settings data.
* Auto backup of profile data.
* Extensions repository search support.
* Open with portable launcher support.

These will get implemented as I learn more about AutoHotkey and have enough time.

## Contact me

You can contact me by my email address at: alexsmithfanning@gmail.com or on [Google+](https://plus.google.com/+AlexSmithFanning), [Reddit](https://www.reddit.com/u/alexsmithfanning), and [Twitter](https://www.twitter.com/smith464_ASF).

I prefer Google+ since that's what I use the most, but I won't miss it if you contact me on Twitter.

## Useful links

These are some useful links that'll help you get what you rightfully deserve out of your paid education. Like unsenored Internet access.

* For a Virtual Private Network (VPN) I'd very highly recommend [ZenMate](https://www.zenmate.com). They give you best effort speed which is usually around the neighborhood of about ten to twelve megabytes per second. They also allow you to tunnel to six different countries for free.

* [youtube-dl](https://rg3.github.io/youtube-dl/) is a great program for downloading YouTube videos if you *really* don't want to use a VPN. It uses direct to URL download links so the likelyhood of wherever you're at being able to even block one is a really long stretch. Keep in mind though that this is against YouTube's Contect Policy. *This program runs in a terminal!*

* The [ReactOS Project](https://www.reactos.org) has a great collection of reverse engineered software that can thwart whatever measures people have put in place to restrict you using the terminal (Command Prompt, for you layman). Its fully compatible with Windows 2000 and above, mimicking exactly what the terminal looks like, but being different enough that Windows doesn't know it's a terminal.

## License

Copyright © 2015 Alex Smith-Fanning

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but *without any warranty*; without even the implied warranty of *merchantability* or *fitness for a particular purpose*. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program; if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
