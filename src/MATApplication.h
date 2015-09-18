

#include "MATCommon.h"
#include "ManderimApplication.h"
#include "MATWindowController.h"

@class HelpViewer;


@interface MATApplication : ManderimApplication{
  IBOutlet MATWindowController* windowController;
  IBOutlet HelpViewer* helpviewer;
}

- (IBAction) showHelpWindow:(id)sender;

- (NABool)hasShowHelp;
- (NABool)hasShowIdentifier;
- (NABool)hasRowFirstTabOrder;
- (MATCodeStyle)codeStyle;
- (NSString*)statusString:(MATStatus)statusnum retColor:(MATColor*)retcolor;
- (NSColor*)color:(MATColor)colornum;

@end

