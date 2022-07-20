

#include "MATCommon.h"
#include "ManderApp.h"
#include "MATWindowController.h"



NSString* formatValue(float value);




@interface MATApplication : NSApplication <NSApplicationDelegate>{
  IBOutlet MATWindowController* windowController;
}

- (IBAction)openAbout:(NSMenuItem*)sender;
- (IBAction)openHelp:(NSMenuItem*)sender;

- (NABool)hasShowHelp;
- (NABool)hasShowIdentifier;
- (NABool)hasShowCopyPaste;
- (NABool)hasRowFirstTabOrder;
- (MATCodeStyle)codeStyle;
- (MATValueAccuracy)valueAccuracy;
- (NSString*)statusString:(MATStatus)statusnum retColor:(MATColor*)retcolor;
- (NSColor*)color:(MATColor)colornum;

- (void)applicationWillFinishLaunching:(NSNotification *)notification;

@end

