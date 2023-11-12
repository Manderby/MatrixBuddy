
#import "MATApplication.h"
#import "MATCommonC.h"

#import "MATWindowController.h"
#import "MATComputationView.h"

#include "MATBaseController.h"

#import "MATVMulS.h"
#import "MATVDivS.h"
#import "MATVMulCompV.h"
#import "MATVDivCompV.h"

#import "MATNegV.h"
#import "MATVAddV.h"
#import "MATVSubV.h"
#import "MATVDotV.h"
#import "MATVCrossV.h"
#import "MATLengthV.h"

#import "MATNormalizeV.h"
#import "MATOrthogonalizeV.h"
#import "MATMirrorV.h"

#import "MATMMulS.h"
#import "MATMDivS.h"
#import "MATMMulCompV.h"
#import "MATMDivCompV.h"
#import "MATMMulCompM.h"
#import "MATMDivCompM.h"

#import "MATNegM.h"
#import "MATMAddM.h"
#import "MATMSubM.h"
#import "MATMMulV.h"
#import "MATMMulM.h"

#import "MATDiagS.h"
#import "MATDiagV.h"
#import "MATTransposeM.h"
#import "MATInvertM.h"

#include "MATTranslations.h"
#include "MATPreferences.h"

#include "NAUICocoaLegacy.h"



@implementation MATWindowController

- (void)awakeFromNib{

  computationView = placeholder;
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


  buttons[MAT_COMPUTATION_VMULS]          = buttonVMulS;
  buttons[MAT_COMPUTATION_VDIVS]          = buttonVDivS;
  buttons[MAT_COMPUTATION_VMULCOMPV]      = buttonVMulCompV;
  buttons[MAT_COMPUTATION_VDIVCOMPV]      = buttonVDivCompV;

  buttons[MAT_COMPUTATION_NEGV]           = buttonNegV;
  buttons[MAT_COMPUTATION_VADDV]          = buttonVAddV;
  buttons[MAT_COMPUTATION_VSUBV]          = buttonVSubV;
  buttons[MAT_COMPUTATION_VDOTV]          = buttonVDotV;
  buttons[MAT_COMPUTATION_VCROSSV]        = buttonVCrossV;
  buttons[MAT_COMPUTATION_LENGTHV]        = buttonLengthV;

  buttons[MAT_COMPUTATION_NORMALIZEV]     = buttonNormalizeV;
  buttons[MAT_COMPUTATION_ORTHOGONALIZEV] = buttonOrthogonalizeV;
  buttons[MAT_COMPUTATION_MIRRORV]        = buttonMirrorV;

  buttons[MAT_COMPUTATION_MMULS]          = buttonMMulS;
  buttons[MAT_COMPUTATION_MDIVS]          = buttonMDivS;
  buttons[MAT_COMPUTATION_MMULCOMPV]      = buttonMMulCompV;
  buttons[MAT_COMPUTATION_MDIVCOMPV]      = buttonMDivCompV;
  buttons[MAT_COMPUTATION_MMULCOMPM]      = buttonMMulCompM;
  buttons[MAT_COMPUTATION_MDIVCOMPM]      = buttonMDivCompM;
  
  buttons[MAT_COMPUTATION_NEGM]           = buttonNegM;
  buttons[MAT_COMPUTATION_MADDM]          = buttonMAddM;
  buttons[MAT_COMPUTATION_MSUBM]          = buttonMSubM;
  buttons[MAT_COMPUTATION_MMULV]          = buttonMMulv;
  buttons[MAT_COMPUTATION_MMULM]          = buttonMMulM;

  buttons[MAT_COMPUTATION_DIAGS]          = buttonDiagS;
  buttons[MAT_COMPUTATION_DIAGV]          = buttonDiagV;
  buttons[MAT_COMPUTATION_TRANSPOSEM]     = buttonTransposeM;
  buttons[MAT_COMPUTATION_INVERTM]        = buttonInvertM;

  views[MAT_COMPUTATION_VMULS * 3 + 0]          = mulV2S;
  views[MAT_COMPUTATION_VMULS * 3 + 1]          = mulV3S;
  views[MAT_COMPUTATION_VMULS * 3 + 2]          = mulV4S;
  views[MAT_COMPUTATION_VDIVS * 3 + 0]          = divV2S;
  views[MAT_COMPUTATION_VDIVS * 3 + 1]          = divV3S;
  views[MAT_COMPUTATION_VDIVS * 3 + 2]          = divV4S;
  views[MAT_COMPUTATION_VMULCOMPV * 3 + 0]      = mulCompV2V2;
  views[MAT_COMPUTATION_VMULCOMPV * 3 + 1]      = mulCompV3V3;
  views[MAT_COMPUTATION_VMULCOMPV * 3 + 2]      = mulCompV4V4;
  views[MAT_COMPUTATION_VDIVCOMPV * 3 + 0]      = divCompV2V2;
  views[MAT_COMPUTATION_VDIVCOMPV * 3 + 1]      = divCompV3V3;
  views[MAT_COMPUTATION_VDIVCOMPV * 3 + 2]      = divCompV4V4;

  views[MAT_COMPUTATION_NEGV * 3 + 0]           = negV2;
  views[MAT_COMPUTATION_NEGV * 3 + 1]           = negV3;
  views[MAT_COMPUTATION_NEGV * 3 + 2]           = negV4;
  views[MAT_COMPUTATION_VADDV * 3 + 0]          = addV2V2;
  views[MAT_COMPUTATION_VADDV * 3 + 1]          = addV3V3;
  views[MAT_COMPUTATION_VADDV * 3 + 2]          = addV4V4;
  views[MAT_COMPUTATION_VSUBV * 3 + 0]          = subV2V2;
  views[MAT_COMPUTATION_VSUBV * 3 + 1]          = subV3V3;
  views[MAT_COMPUTATION_VSUBV * 3 + 2]          = subV4V4;
  views[MAT_COMPUTATION_VDOTV * 3 + 0]          = dotV2V2;
  views[MAT_COMPUTATION_VDOTV * 3 + 1]          = dotV3V3;
  views[MAT_COMPUTATION_VDOTV * 3 + 2]          = dotV4V4;
  views[MAT_COMPUTATION_VCROSSV * 3 + 0]        = crossV3V3;
  views[MAT_COMPUTATION_VCROSSV * 3 + 1]        = crossV3V3;
  views[MAT_COMPUTATION_VCROSSV * 3 + 2]        = crossV3V3;
  views[MAT_COMPUTATION_LENGTHV * 3 + 0]        = lengthV2;
  views[MAT_COMPUTATION_LENGTHV * 3 + 1]        = lengthV3;
  views[MAT_COMPUTATION_LENGTHV * 3 + 2]        = lengthV4;

  views[MAT_COMPUTATION_NORMALIZEV * 3 + 0]     = normalizeV2;
  views[MAT_COMPUTATION_NORMALIZEV * 3 + 1]     = normalizeV3;
  views[MAT_COMPUTATION_NORMALIZEV * 3 + 2]     = normalizeV4;
  views[MAT_COMPUTATION_ORTHOGONALIZEV * 3 + 0] = orthogonalizeV2;
  views[MAT_COMPUTATION_ORTHOGONALIZEV * 3 + 1] = orthogonalizeV3;
  views[MAT_COMPUTATION_ORTHOGONALIZEV * 3 + 2] = orthogonalizeV4;
  views[MAT_COMPUTATION_MIRRORV * 3 + 0]        = mirrorV2;
  views[MAT_COMPUTATION_MIRRORV * 3 + 1]        = mirrorV3;
  views[MAT_COMPUTATION_MIRRORV * 3 + 2]        = mirrorV4;

  matM22SController = matAllocMulMSController(2);
  matM33SController = matAllocMulMSController(3);
  matM44SController = matAllocMulMSController(4);
//  views[MAT_COMPUTATION_MMULS * 3 + 0]          = mulM22S;
//  views[MAT_COMPUTATION_MMULS * 3 + 1]          = mulM33S;
//  views[MAT_COMPUTATION_MMULS * 3 + 2]          = mulM44S;
  views[MAT_COMPUTATION_MDIVS * 3 + 0]          = divM22S;
  views[MAT_COMPUTATION_MDIVS * 3 + 1]          = divM33S;
  views[MAT_COMPUTATION_MDIVS * 3 + 2]          = divM44S;
  views[MAT_COMPUTATION_MMULCOMPV * 3 + 0]      = mulCompM22V2;
  views[MAT_COMPUTATION_MMULCOMPV * 3 + 1]      = mulCompM33V3;
  views[MAT_COMPUTATION_MMULCOMPV * 3 + 2]      = mulCompM44V4;
  views[MAT_COMPUTATION_MDIVCOMPV * 3 + 0]      = divCompM22V2;
  views[MAT_COMPUTATION_MDIVCOMPV * 3 + 1]      = divCompM33V3;
  views[MAT_COMPUTATION_MDIVCOMPV * 3 + 2]      = divCompM44V4;
  views[MAT_COMPUTATION_MMULCOMPM * 3 + 0]      = mulCompM22M22;
  views[MAT_COMPUTATION_MMULCOMPM * 3 + 1]      = mulCompM33M33;
  views[MAT_COMPUTATION_MMULCOMPM * 3 + 2]      = mulCompM44M44;
  views[MAT_COMPUTATION_MDIVCOMPM * 3 + 0]      = divCompM22M22;
  views[MAT_COMPUTATION_MDIVCOMPM * 3 + 1]      = divCompM33M33;
  views[MAT_COMPUTATION_MDIVCOMPM * 3 + 2]      = divCompM44M44;
  
  views[MAT_COMPUTATION_NEGM * 3 + 0]           = negM22;
  views[MAT_COMPUTATION_NEGM * 3 + 1]           = negM33;
  views[MAT_COMPUTATION_NEGM * 3 + 2]           = negM44;
  views[MAT_COMPUTATION_MADDM * 3 + 0]          = addM22M22;
  views[MAT_COMPUTATION_MADDM * 3 + 1]          = addM33M33;
  views[MAT_COMPUTATION_MADDM * 3 + 2]          = addM44M44;
  views[MAT_COMPUTATION_MSUBM * 3 + 0]          = subM22M22;
  views[MAT_COMPUTATION_MSUBM * 3 + 1]          = subM33M33;
  views[MAT_COMPUTATION_MSUBM * 3 + 2]          = subM44M44;
  views[MAT_COMPUTATION_MMULV * 3 + 0]          = mulM22v2;
  views[MAT_COMPUTATION_MMULV * 3 + 1]          = mulM33v3;
  views[MAT_COMPUTATION_MMULV * 3 + 2]          = mulM44v4;
  views[MAT_COMPUTATION_MMULM * 3 + 0]          = mulM22M22;
  views[MAT_COMPUTATION_MMULM * 3 + 1]          = mulM33M33;
  views[MAT_COMPUTATION_MMULM * 3 + 2]          = mulM44M44;

  views[MAT_COMPUTATION_DIAGS * 3 + 0]          = diagSM22;
  views[MAT_COMPUTATION_DIAGS * 3 + 1]          = diagSM33;
  views[MAT_COMPUTATION_DIAGS * 3 + 2]          = diagSM44;
  views[MAT_COMPUTATION_DIAGV * 3 + 0]          = diagV2M22;
  views[MAT_COMPUTATION_DIAGV * 3 + 1]          = diagV3M33;
  views[MAT_COMPUTATION_DIAGV * 3 + 2]          = diagV4M44;
  views[MAT_COMPUTATION_TRANSPOSEM * 3 + 0]     = transposeM22;
  views[MAT_COMPUTATION_TRANSPOSEM * 3 + 1]     = transposeM33;
  views[MAT_COMPUTATION_TRANSPOSEM * 3 + 2]     = transposeM44;
  views[MAT_COMPUTATION_INVERTM * 3 + 0]        = invertM22;
  views[MAT_COMPUTATION_INVERTM * 3 + 1]        = invertM33;
  views[MAT_COMPUTATION_INVERTM * 3 + 2]        = invertM44;

  computation = MAT_COMPUTATION_MMULV;
  dimensions = 3;
}



- (void)prepareFirstView{
  //[self switchComputation:buttonMMulv];
  [self switchComputation:buttonMMulS];
  
  [buttons[MAT_COMPUTATION_VMULS]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVMulS)]];
  [buttons[MAT_COMPUTATION_VDIVS]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVDivS)]];
  [buttons[MAT_COMPUTATION_VMULCOMPV]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVMulCompV)]];
  [buttons[MAT_COMPUTATION_VDIVCOMPV]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVDivCompV)]];
     
  [buttons[MAT_COMPUTATION_NEGV]           setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonNegV)]];
  [buttons[MAT_COMPUTATION_VADDV]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVAddV)]];
  [buttons[MAT_COMPUTATION_VSUBV]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVSubV)]];
  [buttons[MAT_COMPUTATION_VDOTV]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVDotV)]];
  [buttons[MAT_COMPUTATION_VCROSSV]        setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVCrossV)]];
  [buttons[MAT_COMPUTATION_LENGTHV]        setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonLengthV)]];

  [buttons[MAT_COMPUTATION_NORMALIZEV]     setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonNormalizeV)]];
  [buttons[MAT_COMPUTATION_ORTHOGONALIZEV] setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonOrthogonalizeV)]];
  [buttons[MAT_COMPUTATION_MIRRORV]        setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMirrorV)]];

  [buttons[MAT_COMPUTATION_MMULS]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMMulS)]];
  [buttons[MAT_COMPUTATION_MDIVS]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMDivS)]];
  [buttons[MAT_COMPUTATION_MMULCOMPV]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMMulCompV)]];
  [buttons[MAT_COMPUTATION_MDIVCOMPV]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMDivCompV)]];
  [buttons[MAT_COMPUTATION_MMULCOMPM]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMMulCompM)]];
  [buttons[MAT_COMPUTATION_MDIVCOMPM]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMDivCompM)]];

  [buttons[MAT_COMPUTATION_NEGM]           setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonNegM)]];
  [buttons[MAT_COMPUTATION_MADDM]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMAddM)]];
  [buttons[MAT_COMPUTATION_MSUBM]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMSubM)]];
  [buttons[MAT_COMPUTATION_MMULV]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMMulV)]];
  [buttons[MAT_COMPUTATION_MMULM]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMMulM)]];

  [buttons[MAT_COMPUTATION_DIAGS]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonDiagS)]];
  [buttons[MAT_COMPUTATION_DIAGV]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonDiagV)]];
  [buttons[MAT_COMPUTATION_TRANSPOSEM]     setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonTransposeM)]];
  [buttons[MAT_COMPUTATION_INVERTM]        setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonInvertM)]];

}



- (void)update{
  if([self hasShowHelp]){
    [helpLine setHidden:NO];
    NSString* helpstring;
    switch(computation){
      case MAT_COMPUTATION_VMULS:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVMulS)]; break;
      case MAT_COMPUTATION_VDIVS:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVDivS)]; break;
      case MAT_COMPUTATION_VMULCOMPV:       helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVMulCompV)]; break;
      case MAT_COMPUTATION_VDIVCOMPV:       helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVDivCompV)]; break;

      case MAT_COMPUTATION_NEGV:            helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpNegV)]; break;
      case MAT_COMPUTATION_VADDV:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVAddV)]; break;
      case MAT_COMPUTATION_VSUBV:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVSubV)]; break;
      case MAT_COMPUTATION_VDOTV:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVDotV)]; break;
      case MAT_COMPUTATION_VCROSSV:         helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVCrossV)]; break;
      case MAT_COMPUTATION_LENGTHV:         helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpLengthV)]; break;

      case MAT_COMPUTATION_NORMALIZEV:      helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpNormalizeV)]; break;
      case MAT_COMPUTATION_ORTHOGONALIZEV:  helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpOrthogonalizeV)]; break;
      case MAT_COMPUTATION_MIRRORV:         helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMirrorV)]; break;

      case MAT_COMPUTATION_MMULS:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMMulS)]; break;
      case MAT_COMPUTATION_MDIVS:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMDivS)]; break;
      case MAT_COMPUTATION_MMULCOMPV:       helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMMulCompV)]; break;
      case MAT_COMPUTATION_MDIVCOMPV:       helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMDivCompV)]; break;
      case MAT_COMPUTATION_MMULCOMPM:       helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMMulCompM)]; break;
      case MAT_COMPUTATION_MDIVCOMPM:       helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMDivCompM)]; break;
      
      case MAT_COMPUTATION_NEGM:            helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpNegM)]; break;
      case MAT_COMPUTATION_MADDM:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMAddM)]; break;
      case MAT_COMPUTATION_MSUBM:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMSubM)]; break;
      case MAT_COMPUTATION_MMULV:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMMulV)]; break;
      case MAT_COMPUTATION_MMULM:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMMulM)]; break;

      case MAT_COMPUTATION_DIAGS:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpDiagS)]; break;
      case MAT_COMPUTATION_DIAGV:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpDiagV)]; break;
      case MAT_COMPUTATION_TRANSPOSEM:      helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpTransposeM)]; break;
      case MAT_COMPUTATION_INVERTM:         helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpInvertM)]; break;
    default:
      helpstring = @"";
    }
    [helpLine setStringValue:helpstring];
  }else{
    [helpLine setHidden:YES];
  }

  for(MATComputation m=0; m<MAT_COMPUTATION_COUNT; m++){
    [buttons[m] setState:NAStateOff];
  }
  [buttons[computation] setState:NAStateOn];
  [dimension2Radio setState:dimensions == 2 ? NAStateOn : NAStateOff];
  [dimension3Radio setState:dimensions == 3 ? NAStateOn : NAStateOff];
  [dimension4Radio setState:dimensions == 4 ? NAStateOn : NAStateOff];

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

  NSRect frame;
  if(computationView){
    frame = [computationView frame];
    [computationView removeFromSuperview];
  }else{
    NSView* nsView = naGetUIElementNativePtr(naGetControllerSpace(computationController));
    frame = [nsView frame];
    [nsView removeFromSuperview];
  }
  
  computationView = NA_NULL;
  computationController = NA_NULL;
  
  if(computation == MAT_COMPUTATION_MMULS){
    switch(dimensions){
    case 2: computationController = matM22SController; break;
    case 3: computationController = matM33SController; break;
    case 4: computationController = matM44SController; break;
    }
    const NASpace* computationSpace = naGetControllerSpace(computationController);
    NSView* nativeView = naGetUIElementNativePtrConst(computationSpace);
    matUpdateControllerTabOrder(computationController);
    [nativeView setFrame:frame];
    [[[self window] contentView] addSubview:nativeView];
  }else{
    computationView = views[computation * 3 + (dimensions - 2)];
    [computationView setFrame:frame];
    [[[self window] contentView] addSubview:computationView];
    [computationView valueChanged:self];
    [computationView update];
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



- (IBAction)switchComputation:(id)sender{
  [buttons[computation] setState:NAStateOff];

  for(MATComputation m=0; m<MAT_COMPUTATION_COUNT; m++){
    if(sender == buttons[m]){
      computation = m;
      break;
    }
  }
  
  [buttons[computation] setState:NAStateOn];

  [self update];
}


- (IBAction)changeSetting:(id)sender{
  NA_UNUSED(sender);

  if(sender == showHelpItem){
    showHelp = !showHelp;
    naSetPreferencesBool(MATPrefs[ShowHelp], showHelp);
  }else if(sender == showIdentifiersItem){
    showIdentifiers = !showIdentifiers;
    naSetPreferencesBool(MATPrefs[ShowIdentifiers], showIdentifiers);
  }else if(sender == showCopyPasteItem){
    showCopyPaste = !showCopyPaste;
    naSetPreferencesBool(MATPrefs[ShowCopyPaste], showCopyPaste);
    if(computationController)
      matUpdateControllerTabOrder(computationController);
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
  }else if(sender == valueAccuracyFloatItem){
    valueAccuracy = MAT_VALUE_ACCURACY_FLOAT;
    naSetPreferencesEnum(MATPrefs[ValueAccuracy], valueAccuracy);
  }else{}
  [self update];
}


- (IBAction)changeDimensions:(id)sender{
  NA_UNUSED(sender);
  if(sender == dimension2Radio){dimensions = 2;}
  if(sender == dimension3Radio){dimensions = 3;}
  if(sender == dimension4Radio){dimensions = 4;}
  [self update];
}


@end


