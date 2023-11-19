

#include "MATCommon.h"
#include "MATWindowController.h"
#include "NAApp/NAApp.h"
#include "MATAboutController.h"
#include "MATWindowControllerASDF.h"

NSString* formatValue(float value);


void matPrepareFirstView(void);



@interface MATApplication : NSApplication <NSApplicationDelegate>{
  IBOutlet MATWindowController* windowController;
  MATWindowControllerASDF* windowControllerASDF;
  
@public
  NAFont* mathFont;
  NAFont* helpLineFont;
  NAUIImage* copyImage;
  NAUIImage* pasteImage;
  MATAboutController* aboutController;
}

- (void)prepareFirstView;

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

- (MATWindowController*)getWindowController;

@end

