
#import "MATApplication.h"
#import "MATCommonC.h"

#import "MATWindowController.h"

#include "MATBaseController.h"

#include "MATTranslations.h"
#include "MATPreferences.h"

#include "NAUICocoaLegacy.h"



@implementation MATWindowController

- (void)awakeFromNib{

  computationController = NA_NULL;

  showHelp = naGetPreferencesBool(MATPrefs[ShowHelp]);
  showIdentifiers = naGetPreferencesBool(MATPrefs[ShowIdentifiers]);
  showCopyPaste = naGetPreferencesBool(MATPrefs[ShowCopyPaste]);
  hasRowFirstTabOrder = naGetPreferencesBool(MATPrefs[UseRowFirstTabOrder]);
  codeStyle = (MATCodeStyle)naGetPreferencesEnum(MATPrefs[CodeStyle]);
  valueAccuracy = (MATValueAccuracy)naGetPreferencesEnum(MATPrefs[ValueAccuracy]);
  
  gearItem = [[NSMenuItem alloc] initWithTitle:@"M" action:@selector(changeSetting:) keyEquivalent:@""];
  [gearItem setImage:[NSImage imageNamed:NSImageNameSmartBadgeTemplate]];
  
  showHelpItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemShowHelp)] action:@selector(changeSetting:) keyEquivalent:@""];
  showIdentifiersItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemShowIdentifiers)] action:@selector(changeSetting:) keyEquivalent:@""];
  showCopyPasteItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemShowCopyPaste)] action:@selector(changeSetting:) keyEquivalent:@""];
  rowFirstTabOrderItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemRowFirstTabOrder)] action:@selector(changeSetting:) keyEquivalent:@""];
  columnFirstTabOrderItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemColumnFirstTabOrder)] action:@selector(changeSetting:) keyEquivalent:@""];
  codeCRowFirstItem1D = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemCodeCRowFirstItem1D)] action:@selector(changeSetting:) keyEquivalent:@""];
  codeCRowFirstItem2D = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemCodeCRowFirstItem2D)] action:@selector(changeSetting:) keyEquivalent:@""];
  codeCColumnFirstItem1D = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemCodeCColumnFirstItem1D)] action:@selector(changeSetting:) keyEquivalent:@""];
  codeCColumnFirstItem2D = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemCodeCColumnFirstItem2D)] action:@selector(changeSetting:) keyEquivalent:@""];
  codeMathematicaItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemCodeMathematica)] action:@selector(changeSetting:) keyEquivalent:@""];
  codeMatlabItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemCodeMatlab)] action:@selector(changeSetting:) keyEquivalent:@""];
  codeMapleItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemCodeMaple)] action:@selector(changeSetting:) keyEquivalent:@""];
  valueAccuracyNaturalItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemValueAccuracyNatural)] action:@selector(changeSetting:) keyEquivalent:@""];
  valueAccuracyFloatItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemValueAccuracyFloat)] action:@selector(changeSetting:) keyEquivalent:@""];
  
  aboutItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemAbout)] action:@selector(openAbout:) keyEquivalent:@""];
  [helpItem setTarget:NSApp];
  helpItem = [[NSMenuItem alloc] initWithTitle:[NSString stringWithUTF8String:matTranslate(MATMenuItemHelp)] action:@selector(openHelp:) keyEquivalent:@""];
  [helpItem setTarget:NSApp];

  NSMenu* gearMenu = [[NSMenu alloc] init];
  [gearMenu addItem:gearItem];
  [gearMenu addItem:showHelpItem];
  [gearMenu addItem:showIdentifiersItem];
  [gearMenu addItem:[NSMenuItem separatorItem]];
  [gearMenu addItem:showCopyPasteItem];
  [gearMenu addItem:codeCRowFirstItem1D];
  [gearMenu addItem:codeCRowFirstItem2D];
  [gearMenu addItem:codeCColumnFirstItem1D];
  [gearMenu addItem:codeCColumnFirstItem2D];
  [gearMenu addItem:codeMathematicaItem];
  [gearMenu addItem:codeMatlabItem];
  [gearMenu addItem:codeMapleItem];
  [gearMenu addItem:[NSMenuItem separatorItem]];
  [gearMenu addItem:rowFirstTabOrderItem];
  [gearMenu addItem:columnFirstTabOrderItem];
  [gearMenu addItem:[NSMenuItem separatorItem]];
  [gearMenu addItem:valueAccuracyNaturalItem];
  [gearMenu addItem:valueAccuracyFloatItem];
  [gearMenu addItem:[NSMenuItem separatorItem]];
  [gearMenu addItem:aboutItem];
  [gearMenu addItem:helpItem];
  
  [gearButton setMenu:gearMenu];
  NA_COCOA_RELEASE(gearMenu);

  computation = MAT_COMPUTATION_MMULV;
  dimensions = 3;
}



- (void)update{
  [showHelpItem setState:(showHelp?NAStateOn:NAStateOff)];
  [showIdentifiersItem setState:(showIdentifiers?NAStateOn:NAStateOff)];
  [showCopyPasteItem setState:(showCopyPaste?NAStateOn:NAStateOff)];

  if(hasRowFirstTabOrder){
    [rowFirstTabOrderItem setState:NAStateOn];
    [columnFirstTabOrderItem setState:NAStateOff];
  }else{
    [rowFirstTabOrderItem setState:NAStateOff];
    [columnFirstTabOrderItem setState:NAStateOn];
  }
  
  [codeCRowFirstItem1D setState:NAStateOff];
  [codeCRowFirstItem2D setState:NAStateOff];
  [codeCColumnFirstItem1D setState:NAStateOff];
  [codeCColumnFirstItem2D setState:NAStateOff];
  [codeMathematicaItem setState:NAStateOff];
  [codeMatlabItem setState:NAStateOff];
  [codeMapleItem setState:NAStateOff];
  switch(codeStyle){
  case MAT_CODE_STYLE_C_ROW_FIRST_1D: [codeCRowFirstItem1D setState:NAStateOn]; break;
  case MAT_CODE_STYLE_C_ROW_FIRST_2D: [codeCRowFirstItem2D setState:NAStateOn]; break;
  case MAT_CODE_STYLE_C_COLUMN_FIRST_1D: [codeCColumnFirstItem1D setState:NAStateOn]; break;
  case MAT_CODE_STYLE_C_COLUMN_FIRST_2D: [codeCColumnFirstItem2D setState:NAStateOn]; break;
  case MAT_CODE_STYLE_MATHEMATICA: [codeMathematicaItem setState:NAStateOn]; break;
  case MAT_CODE_STYLE_MATLAB: [codeMatlabItem setState:NAStateOn]; break;
  case MAT_CODE_STYLE_MAPLE: [codeMapleItem setState:NAStateOn]; break;
  }
  
  [codeCRowFirstItem1D setAction:showCopyPaste ? @selector(changeSetting:) : nil];
  [codeCRowFirstItem2D setAction:showCopyPaste ? @selector(changeSetting:) : nil];
  [codeCColumnFirstItem1D setAction:showCopyPaste ? @selector(changeSetting:) : nil];
  [codeCColumnFirstItem2D setAction:showCopyPaste ? @selector(changeSetting:) : nil];
  [codeMathematicaItem setAction:showCopyPaste ? @selector(changeSetting:) : nil];
  [codeMatlabItem setAction:showCopyPaste ? @selector(changeSetting:) : nil];
  [codeMapleItem setAction:showCopyPaste ? @selector(changeSetting:) : nil];

  [valueAccuracyNaturalItem setState:NAStateOff];
  [valueAccuracyFloatItem setState:NAStateOff];
  switch(valueAccuracy){
  case MAT_VALUE_ACCURACY_NATURAL: [valueAccuracyNaturalItem setState:NAStateOn]; break;
  case MAT_VALUE_ACCURACY_FLOAT: [valueAccuracyFloatItem setState:NAStateOn]; break;
  }
}



- (NABool)hasShowHelp{
  return showHelp;
}
- (NABool)hasShowIdentifiers{
  return showIdentifiers;
}
- (NABool)hasShowCopyPaste{
  return showCopyPaste;
}
- (NABool)hasRowFirstTabOrder{
  return hasRowFirstTabOrder;
}
- (MATCodeStyle)codeStyle{
  return codeStyle;
}
- (MATValueAccuracy)valueAccuracy{
  return valueAccuracy;
}



- (BOOL)windowShouldClose:(id)sender{
  exit(0);  // Close application when window closes.
  return YES;
}



- (IBAction)changeSetting:(id)sender{
  NA_UNUSED(sender);

  if(sender == showHelpItem){
    showHelp = !showHelp;
    naSetPreferencesBool(MATPrefs[ShowHelp], showHelp);
    if(computationController)
      matUpdateController(computationController);
  }else if(sender == showIdentifiersItem){
    showIdentifiers = !showIdentifiers;
    naSetPreferencesBool(MATPrefs[ShowIdentifiers], showIdentifiers);
    if(computationController)
      matUpdateController(computationController);
  }else if(sender == showCopyPasteItem){
    showCopyPaste = !showCopyPaste;
    naSetPreferencesBool(MATPrefs[ShowCopyPaste], showCopyPaste);
    if(computationController)
      matUpdateController(computationController);
  }else if(sender == rowFirstTabOrderItem){
    hasRowFirstTabOrder = NA_TRUE;
    naSetPreferencesBool(MATPrefs[UseRowFirstTabOrder], hasRowFirstTabOrder);
    if(computationController)
      matUpdateControllerTabOrder(computationController);
  }else if(sender == columnFirstTabOrderItem){
    hasRowFirstTabOrder = NA_FALSE;
    naSetPreferencesBool(MATPrefs[UseRowFirstTabOrder], hasRowFirstTabOrder);
  }else if(sender == codeCRowFirstItem1D){
    codeStyle = MAT_CODE_STYLE_C_ROW_FIRST_1D;
    naSetPreferencesEnum(MATPrefs[CodeStyle], codeStyle);
  }else if(sender == codeCRowFirstItem2D){
    codeStyle = MAT_CODE_STYLE_C_ROW_FIRST_2D;
    naSetPreferencesEnum(MATPrefs[CodeStyle], codeStyle);
  }else if(sender == codeCColumnFirstItem1D){
    codeStyle = MAT_CODE_STYLE_C_COLUMN_FIRST_1D;
    naSetPreferencesEnum(MATPrefs[CodeStyle], codeStyle);
  }else if(sender == codeCColumnFirstItem2D){
    codeStyle = MAT_CODE_STYLE_C_COLUMN_FIRST_2D;
    naSetPreferencesEnum(MATPrefs[CodeStyle], codeStyle);
  }else if(sender == codeMathematicaItem){
    codeStyle = MAT_CODE_STYLE_MATHEMATICA;
    naSetPreferencesEnum(MATPrefs[CodeStyle], codeStyle);
  }else if(sender == codeMatlabItem){
    codeStyle = MAT_CODE_STYLE_MATLAB;
    naSetPreferencesEnum(MATPrefs[CodeStyle], codeStyle);
  }else if(sender == codeMapleItem){
    codeStyle = MAT_CODE_STYLE_MAPLE;
    naSetPreferencesEnum(MATPrefs[CodeStyle], codeStyle);
  }else if(sender == valueAccuracyNaturalItem){
    valueAccuracy = MAT_VALUE_ACCURACY_NATURAL;
    naSetPreferencesEnum(MATPrefs[ValueAccuracy], valueAccuracy);
    if(computationController)
      matUpdateController(computationController);
  }else if(sender == valueAccuracyFloatItem){
    valueAccuracy = MAT_VALUE_ACCURACY_FLOAT;
    naSetPreferencesEnum(MATPrefs[ValueAccuracy], valueAccuracy);
    if(computationController)
      matUpdateController(computationController);
  }else{}
  [self update];
}


@end


