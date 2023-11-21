

#include "MATCommon.h"
#include "NAApp/NAApp.h"
#include "MATAboutController.h"
#include "MATWindowController.h"

void matPrepareFirstView(void);

@interface MATApplication : NSApplication <NSApplicationDelegate>{
  MATWindowController* windowController;
  
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

@end

