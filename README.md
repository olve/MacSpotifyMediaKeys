# MacSpotifyMediaKeys
Bypass iTunes mediakey hijacking and control Spotify instead.

http://lifehacker.com/5531707/free-your-macs-media-keys-from-itunes-grasp

http://apple.stackexchange.com/questions/58234/override-itunes-media-keys-play-pause-etc-for-spotify

http://apple.stackexchange.com/questions/143146/control-spotify-with-media-keys



MacSpotifyMediaKeys listens globally for mediakey events, and interacts with Spotify using it's AppleScript API.
To prevent other applications from receiving said events once MacSpotifyMediaKeys has used it, return null in the event-handler.

must be compiled with -framework Cocoa, eg. ```clang main.m -o MacSpotifyMediaKeys -framework Cocoa```
must be run as root.
