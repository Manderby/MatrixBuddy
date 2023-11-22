
#import <Cocoa/Cocoa.h>
#import "MATNSApplication.h"

@interface MATNSApplication : NSApplication <NSApplicationDelegate>{
}
- (IBAction)openAbout:(NSMenuItem*)sender;
- (IBAction)openHelp:(NSMenuItem*)sender;
@end

