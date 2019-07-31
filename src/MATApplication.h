

#include "MATCommon.h"
#include "ManderApp.h"
#include "MATWindowController.h"



NSString* formatValue(float value);




@interface MATApplication : NSApplication <NSApplicationDelegate>{
  IBOutlet MATWindowController* windowController;
}

- (IBAction)openOnlineHelp:(NSMenuItem*)sender;

- (NABool)hasShowHelp;
- (NABool)hasShowIdentifier;
- (NABool)hasRowFirstTabOrder;
- (MATCodeStyle)codeStyle;
- (MATValueAccuracy)valueAccuracy;
- (NSString*)statusString:(MATStatus)statusnum retColor:(MATColor*)retcolor;
- (NSColor*)color:(MATColor)colornum;

@end

