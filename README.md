# MacSpotifyMediaKeys
Bypass iTunes mediakey hijacking to control Spotify.


##The problem MacSpotifyMediaKeys solves

iTunes overrides media keys even while not running; Spotify never receives the event and does not react.
* http://lifehacker.com/5531707/free-your-macs-media-keys-from-itunes-grasp

* http://apple.stackexchange.com/questions/58234/override-itunes-media-keys-play-pause-etc-for-spotify

* http://apple.stackexchange.com/questions/143146/control-spotify-with-media-keys


##How MacSpotifyMediaKeys circumvents this problem
1. Listen globally for mediakey events
2. When a mediakey is pressed, use Spotify AppleScript API method corresponding to the pressed key (eg. tell "Spotify" playpause)

##Notes
* Return null in event-handler to block events (prevent other applications from also handling mediakeys)
* must be run as root
* compile with -framework Cocoa flag, eg. ```clang main.m -o MacSpotifyMediaKeys -framework Cocoa```
