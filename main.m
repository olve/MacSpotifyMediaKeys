#import <Cocoa/Cocoa.h>
#import <IOKit/hidsystem/ev_keymap.h>

int spotifyAction(NSAppleScript *action) {
  NSDictionary<NSString *, id> *error;
  NSAppleEventDescriptor *result = [action executeAndReturnError: &error];
  if (result == nil) {
    return 1;
  }
  return 0;
}

CGEventRef callback(CGEventTapProxy proxy, CGEventType type, CGEventRef event, void *refcon) {
  
  if (type != NX_SYSDEFINED) {
    return event;
  }

  NSEvent *e = [NSEvent eventWithCGEvent:event];

  if ([e subtype] == 8) {
    
    int keycode = (([e data1] & 0xFFFF0000) >> 16);
    BOOL keyUp = !(([e data1] & 0x0000ff00) == 0x00000a00);
    
    if (keycode == NX_KEYTYPE_PLAY && keyUp) {
      NSAppleScript *playpause = [[NSAppleScript alloc] initWithSource:
              @"tell application \"Spotify\"\n"
              @"    playpause\n"
              @"end tell"];
      spotifyAction(playpause);
    } else if (keycode == NX_KEYTYPE_FAST && keyUp) {
      NSAppleScript *next = [[NSAppleScript alloc] initWithSource:
              @"tell application \"Spotify\"\n"
              @"    next track\n"
              @"end tell"];
      spotifyAction(next);
    } else if (keycode == NX_KEYTYPE_REWIND && keyUp) {
      NSAppleScript *prev = [[NSAppleScript alloc] initWithSource:
              @"tell application \"Spotify\"\n"
              @"    previous track\n"
              @"end tell"];
      spotifyAction(prev);
    }
  }
  
  return event;
}

int main() {
  CFMachPortRef eventTap;
  CFRunLoopSourceRef runLoopSource;

  eventTap = CGEventTapCreate(kCGSessionEventTap, kCGHeadInsertEventTap, 0, CGEventMaskBit(NX_SYSDEFINED), callback, NULL);
  runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0);
  CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
  CGEventTapEnable(eventTap, true);
  CFRunLoopRun();
}
