

#include "MATCommon.h"
#include "ManderimApplication.h"
#include "MATWindowController.h"


@interface MATApplication : ManderimApplication{
  IBOutlet MATWindowController* windowController;
}

- (NABool)hasShowHelp;
- (NABool)hasShowIdentifier;
- (NABool)hasRowFirstTabOrder;
- (MATCodeStyle)codeStyle;
- (NSString*)statusString:(MATStatus)statusnum retColor:(MATColor*)retcolor;
- (NSColor*)color:(MATColor)colornum;

@end

