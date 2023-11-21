
#include "MATCommon.h"
#include "MATBaseController.h"


@interface MATWindowController : NSWindowController<NSWindowDelegate>{
  IBOutlet NSButton* gearButton;

  IBOutlet NSMenuItem* gearItem;
  IBOutlet NSMenuItem* showHelpItem;
  IBOutlet NSMenuItem* showIdentifiersItem;
  IBOutlet NSMenuItem* showCopyPasteItem;
  IBOutlet NSMenuItem* rowFirstTabOrderItem;
  IBOutlet NSMenuItem* columnFirstTabOrderItem;
  IBOutlet NSMenuItem* codeCRowFirstItem1D;
  IBOutlet NSMenuItem* codeCRowFirstItem2D;
  IBOutlet NSMenuItem* codeCColumnFirstItem1D;
  IBOutlet NSMenuItem* codeCColumnFirstItem2D;
  IBOutlet NSMenuItem* codeMathematicaItem;
  IBOutlet NSMenuItem* codeMatlabItem;
  IBOutlet NSMenuItem* codeMapleItem;
  IBOutlet NSMenuItem* valueAccuracyNaturalItem;
  IBOutlet NSMenuItem* valueAccuracyFloatItem;
  IBOutlet NSMenuItem* aboutItem;
  IBOutlet NSMenuItem* helpItem;
  
  MATBaseController* computationController;
  MATComputation computation;
  size_t dimensions;
  
}

- (void)update;
- (IBAction)changeSetting:(id)sender;

@end

