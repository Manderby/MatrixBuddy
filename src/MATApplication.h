

#include "MATCommon.h"
#include "ManderimApplication.h"
#include "MATWindowController.h"



NSString* formatValue(float value);




@interface MATApplication : ManderimApplication{
  IBOutlet MATWindowController* windowController;
}

- (NABool)hasShowHelp;
- (NABool)hasShowIdentifier;
- (NABool)hasRowFirstTabOrder;
- (MATCodeStyle)codeStyle;
- (MATValueAccuracy)valueAccuracy;
- (NSString*)statusString:(MATStatus)statusnum retColor:(MATColor*)retcolor;
- (NSColor*)color:(MATColor)colornum;

@end

