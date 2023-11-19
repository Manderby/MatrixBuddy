
#import "MATApplication.h"
#import "MATCommonC.h"

#import "MATWindowController.h"
#import "MATComputationView.h"

#include "MATBaseController.h"

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

  buttons[MAT_COMPUTATION_VNEG]           = buttonNegV;
  buttons[MAT_COMPUTATION_VADDV]          = buttonVAddV;
  buttons[MAT_COMPUTATION_VSUBV]          = buttonVSubV;
  buttons[MAT_COMPUTATION_VDOTV]          = buttonVDotV;
  buttons[MAT_COMPUTATION_VCROSSV]        = buttonVCrossV;
  buttons[MAT_COMPUTATION_VLENGTH]        = buttonLengthV;

  buttons[MAT_COMPUTATION_VNORMALIZE]     = buttonNormalizeV;
  buttons[MAT_COMPUTATION_VORTHO]         = buttonVOrtho;
  buttons[MAT_COMPUTATION_VMIRROR]        = buttonVMirror;

  buttons[MAT_COMPUTATION_MMULS]          = buttonMMulS;
  buttons[MAT_COMPUTATION_MDIVS]          = buttonMDivS;
  buttons[MAT_COMPUTATION_MMULCOMPV]      = buttonMMulCompV;
  buttons[MAT_COMPUTATION_MDIVCOMPV]      = buttonMDivCompV;
  buttons[MAT_COMPUTATION_MMULCOMPM]      = buttonMMulCompM;
  buttons[MAT_COMPUTATION_MDIVCOMPM]      = buttonMDivCompM;
  
  buttons[MAT_COMPUTATION_MNEG]           = buttonMNeg;
  buttons[MAT_COMPUTATION_MADDM]          = buttonMAddM;
  buttons[MAT_COMPUTATION_MSUBM]          = buttonMSubM;
  buttons[MAT_COMPUTATION_MMULV]          = buttonMMulV;
  buttons[MAT_COMPUTATION_MMULM]          = buttonMMulM;

  buttons[MAT_COMPUTATION_DIAGS]          = buttonDiagS;
  buttons[MAT_COMPUTATION_DIAGV]          = buttonDiagV;
  buttons[MAT_COMPUTATION_MTRANSPOSE]     = buttonMTranspose;
  buttons[MAT_COMPUTATION_MINVERT]        = buttonMInvert;

  controllers[MAT_COMPUTATION_VMULS * 3 + 0]      = matAllocVMulSController(2);
  controllers[MAT_COMPUTATION_VMULS * 3 + 1]      = matAllocVMulSController(3);
  controllers[MAT_COMPUTATION_VMULS * 3 + 2]      = matAllocVMulSController(4);
  controllers[MAT_COMPUTATION_VDIVS * 3 + 0]      = matAllocVDivSController(2);
  controllers[MAT_COMPUTATION_VDIVS * 3 + 1]      = matAllocVDivSController(3);
  controllers[MAT_COMPUTATION_VDIVS * 3 + 2]      = matAllocVDivSController(4);
  controllers[MAT_COMPUTATION_VMULCOMPV * 3 + 0]  = matAllocVMulCompVController(2);
  controllers[MAT_COMPUTATION_VMULCOMPV * 3 + 1]  = matAllocVMulCompVController(3);
  controllers[MAT_COMPUTATION_VMULCOMPV * 3 + 2]  = matAllocVMulCompVController(4);
  controllers[MAT_COMPUTATION_VDIVCOMPV * 3 + 0]  = matAllocVDivCompVController(2);
  controllers[MAT_COMPUTATION_VDIVCOMPV * 3 + 1]  = matAllocVDivCompVController(3);
  controllers[MAT_COMPUTATION_VDIVCOMPV * 3 + 2]  = matAllocVDivCompVController(4);

  controllers[MAT_COMPUTATION_VNEG * 3 + 0]       = matAllocVNegController(2);
  controllers[MAT_COMPUTATION_VNEG * 3 + 1]       = matAllocVNegController(3);
  controllers[MAT_COMPUTATION_VNEG * 3 + 2]       = matAllocVNegController(4);
  controllers[MAT_COMPUTATION_VADDV * 3 + 0]      = matAllocVAddVController(2);
  controllers[MAT_COMPUTATION_VADDV * 3 + 1]      = matAllocVAddVController(3);
  controllers[MAT_COMPUTATION_VADDV * 3 + 2]      = matAllocVAddVController(4);
  controllers[MAT_COMPUTATION_VSUBV * 3 + 0]      = matAllocVSubVController(2);
  controllers[MAT_COMPUTATION_VSUBV * 3 + 1]      = matAllocVSubVController(3);
  controllers[MAT_COMPUTATION_VSUBV * 3 + 2]      = matAllocVSubVController(4);
  controllers[MAT_COMPUTATION_VDOTV * 3 + 0]      = matAllocVDotVController(2);
  controllers[MAT_COMPUTATION_VDOTV * 3 + 1]      = matAllocVDotVController(3);
  controllers[MAT_COMPUTATION_VDOTV * 3 + 2]      = matAllocVDotVController(4);
  controllers[MAT_COMPUTATION_VCROSSV * 3 + 0]    = matAllocVCrossVController(3);
  controllers[MAT_COMPUTATION_VCROSSV * 3 + 1]    = matAllocVCrossVController(3);
  controllers[MAT_COMPUTATION_VCROSSV * 3 + 2]    = matAllocVCrossVController(3);
  controllers[MAT_COMPUTATION_VLENGTH * 3 + 0]    = matAllocVLengthController(2);
  controllers[MAT_COMPUTATION_VLENGTH * 3 + 1]    = matAllocVLengthController(3);
  controllers[MAT_COMPUTATION_VLENGTH * 3 + 2]    = matAllocVLengthController(4);

  controllers[MAT_COMPUTATION_VNORMALIZE * 3 + 0] = matAllocVNormalizeController(2);
  controllers[MAT_COMPUTATION_VNORMALIZE * 3 + 1] = matAllocVNormalizeController(3);
  controllers[MAT_COMPUTATION_VNORMALIZE * 3 + 2] = matAllocVNormalizeController(4);
  controllers[MAT_COMPUTATION_VORTHO * 3 + 0]     = matAllocVOrthoController(2);
  controllers[MAT_COMPUTATION_VORTHO * 3 + 1]     = matAllocVOrthoController(3);
  controllers[MAT_COMPUTATION_VORTHO * 3 + 2]     = matAllocVOrthoController(4);
  controllers[MAT_COMPUTATION_VMIRROR * 3 + 0]    = matAllocVMirrorController(2);
  controllers[MAT_COMPUTATION_VMIRROR * 3 + 1]    = matAllocVMirrorController(3);
  controllers[MAT_COMPUTATION_VMIRROR * 3 + 2]    = matAllocVMirrorController(4);

  controllers[MAT_COMPUTATION_MMULS * 3 + 0]      = matAllocMMulSController(2);
  controllers[MAT_COMPUTATION_MMULS * 3 + 1]      = matAllocMMulSController(3);
  controllers[MAT_COMPUTATION_MMULS * 3 + 2]      = matAllocMMulSController(4);
  controllers[MAT_COMPUTATION_MDIVS * 3 + 0]      = matAllocMDivSController(2);
  controllers[MAT_COMPUTATION_MDIVS * 3 + 1]      = matAllocMDivSController(3);
  controllers[MAT_COMPUTATION_MDIVS * 3 + 2]      = matAllocMDivSController(4);
  controllers[MAT_COMPUTATION_MMULCOMPV * 3 + 0]  = matAllocMMulCompVController(2);
  controllers[MAT_COMPUTATION_MMULCOMPV * 3 + 1]  = matAllocMMulCompVController(3);
  controllers[MAT_COMPUTATION_MMULCOMPV * 3 + 2]  = matAllocMMulCompVController(4);
  controllers[MAT_COMPUTATION_MDIVCOMPV * 3 + 0]  = matAllocMDivCompVController(2);
  controllers[MAT_COMPUTATION_MDIVCOMPV * 3 + 1]  = matAllocMDivCompVController(3);
  controllers[MAT_COMPUTATION_MDIVCOMPV * 3 + 2]  = matAllocMDivCompVController(4);
  controllers[MAT_COMPUTATION_MMULCOMPM * 3 + 0]  = matAllocMMulCompMController(2);
  controllers[MAT_COMPUTATION_MMULCOMPM * 3 + 1]  = matAllocMMulCompMController(3);
  controllers[MAT_COMPUTATION_MMULCOMPM * 3 + 2]  = matAllocMMulCompMController(4);
  controllers[MAT_COMPUTATION_MDIVCOMPM * 3 + 0]  = matAllocMDivCompMController(2);
  controllers[MAT_COMPUTATION_MDIVCOMPM * 3 + 1]  = matAllocMDivCompMController(3);
  controllers[MAT_COMPUTATION_MDIVCOMPM * 3 + 2]  = matAllocMDivCompMController(4);
  
  controllers[MAT_COMPUTATION_MNEG * 3 + 0]       = matAllocMNegController(2);
  controllers[MAT_COMPUTATION_MNEG * 3 + 1]       = matAllocMNegController(3);
  controllers[MAT_COMPUTATION_MNEG * 3 + 2]       = matAllocMNegController(4);
  controllers[MAT_COMPUTATION_MADDM * 3 + 0]      = matAllocMAddMController(2);
  controllers[MAT_COMPUTATION_MADDM * 3 + 1]      = matAllocMAddMController(3);
  controllers[MAT_COMPUTATION_MADDM * 3 + 2]      = matAllocMAddMController(4);
  controllers[MAT_COMPUTATION_MSUBM * 3 + 0]      = matAllocMSubMController(2);
  controllers[MAT_COMPUTATION_MSUBM * 3 + 1]      = matAllocMSubMController(3);
  controllers[MAT_COMPUTATION_MSUBM * 3 + 2]      = matAllocMSubMController(4);
  controllers[MAT_COMPUTATION_MMULV * 3 + 0]      = matAllocMMulVController(2);
  controllers[MAT_COMPUTATION_MMULV * 3 + 1]      = matAllocMMulVController(3);
  controllers[MAT_COMPUTATION_MMULV * 3 + 2]      = matAllocMMulVController(4);
  controllers[MAT_COMPUTATION_MMULM * 3 + 0]      = matAllocMMulMController(2);
  controllers[MAT_COMPUTATION_MMULM * 3 + 1]      = matAllocMMulMController(3);
  controllers[MAT_COMPUTATION_MMULM * 3 + 2]      = matAllocMMulMController(4);

  controllers[MAT_COMPUTATION_DIAGS * 3 + 0]      = matAllocMDiagSController(2);
  controllers[MAT_COMPUTATION_DIAGS * 3 + 1]      = matAllocMDiagSController(3);
  controllers[MAT_COMPUTATION_DIAGS * 3 + 2]      = matAllocMDiagSController(4);
  controllers[MAT_COMPUTATION_DIAGV * 3 + 0]      = matAllocMDiagVController(2);
  controllers[MAT_COMPUTATION_DIAGV * 3 + 1]      = matAllocMDiagVController(3);
  controllers[MAT_COMPUTATION_DIAGV * 3 + 2]      = matAllocMDiagVController(4);
  controllers[MAT_COMPUTATION_MTRANSPOSE * 3 + 0] = matAllocMTransposeController(2);
  controllers[MAT_COMPUTATION_MTRANSPOSE * 3 + 1] = matAllocMTransposeController(3);
  controllers[MAT_COMPUTATION_MTRANSPOSE * 3 + 2] = matAllocMTransposeController(4);
  controllers[MAT_COMPUTATION_MINVERT * 3 + 0]    = matAllocMInvertController(2);
  controllers[MAT_COMPUTATION_MINVERT * 3 + 1]    = matAllocMInvertController(3);
  controllers[MAT_COMPUTATION_MINVERT * 3 + 2]    = matAllocMInvertController(4);

  computation = MAT_COMPUTATION_MMULV;
  dimensions = 3;
}

- (void)cleanCStructures{
  matDeallocMMulSController(controllers[MAT_COMPUTATION_MMULS * 3 + 0]);
  matDeallocMMulSController(controllers[MAT_COMPUTATION_MMULS * 3 + 1]);
  matDeallocMMulSController(controllers[MAT_COMPUTATION_MMULS * 3 + 2]);
  matDeallocMDivSController(controllers[MAT_COMPUTATION_MDIVS * 3 + 0]);
  matDeallocMDivSController(controllers[MAT_COMPUTATION_MDIVS * 3 + 1]);
  matDeallocMDivSController(controllers[MAT_COMPUTATION_MDIVS * 3 + 2]);
}



- (void)prepareFirstView{
  [self switchComputation:buttonMMulV];
  
  [buttons[MAT_COMPUTATION_VMULS]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVMulS)]];
  [buttons[MAT_COMPUTATION_VDIVS]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVDivS)]];
  [buttons[MAT_COMPUTATION_VMULCOMPV]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVMulCompV)]];
  [buttons[MAT_COMPUTATION_VDIVCOMPV]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVDivCompV)]];
     
  [buttons[MAT_COMPUTATION_VNEG]           setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonNegV)]];
  [buttons[MAT_COMPUTATION_VADDV]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVAddV)]];
  [buttons[MAT_COMPUTATION_VSUBV]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVSubV)]];
  [buttons[MAT_COMPUTATION_VDOTV]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVDotV)]];
  [buttons[MAT_COMPUTATION_VCROSSV]        setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVCrossV)]];
  [buttons[MAT_COMPUTATION_VLENGTH]        setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVLength)]];

  [buttons[MAT_COMPUTATION_VNORMALIZE]     setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVNormalize)]];
  [buttons[MAT_COMPUTATION_VORTHO] setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVOrtho)]];
  [buttons[MAT_COMPUTATION_VMIRROR]        setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonVMirror)]];

  [buttons[MAT_COMPUTATION_MMULS]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMMulS)]];
  [buttons[MAT_COMPUTATION_MDIVS]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMDivS)]];
  [buttons[MAT_COMPUTATION_MMULCOMPV]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMMulCompV)]];
  [buttons[MAT_COMPUTATION_MDIVCOMPV]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMDivCompV)]];
  [buttons[MAT_COMPUTATION_MMULCOMPM]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMMulCompM)]];
  [buttons[MAT_COMPUTATION_MDIVCOMPM]      setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMDivCompM)]];

  [buttons[MAT_COMPUTATION_MNEG]           setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMNeg)]];
  [buttons[MAT_COMPUTATION_MADDM]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMAddM)]];
  [buttons[MAT_COMPUTATION_MSUBM]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMSubM)]];
  [buttons[MAT_COMPUTATION_MMULV]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMMulV)]];
  [buttons[MAT_COMPUTATION_MMULM]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMMulM)]];

  [buttons[MAT_COMPUTATION_DIAGS]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMDiagS)]];
  [buttons[MAT_COMPUTATION_DIAGV]          setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMDiagV)]];
  [buttons[MAT_COMPUTATION_MTRANSPOSE]     setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMTranspose)]];
  [buttons[MAT_COMPUTATION_MINVERT]        setTitle:[NSString stringWithUTF8String:matTranslate(MATButtonMInvert)]];

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

      case MAT_COMPUTATION_VNEG:            helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVNeg)]; break;
      case MAT_COMPUTATION_VADDV:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVAddV)]; break;
      case MAT_COMPUTATION_VSUBV:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVSubV)]; break;
      case MAT_COMPUTATION_VDOTV:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVDotV)]; break;
      case MAT_COMPUTATION_VCROSSV:         helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVCrossV)]; break;
      case MAT_COMPUTATION_VLENGTH:         helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVLength)]; break;

      case MAT_COMPUTATION_VNORMALIZE:      helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVNormalize)]; break;
      case MAT_COMPUTATION_VORTHO:  helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVOrtho)]; break;
      case MAT_COMPUTATION_VMIRROR:         helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpVMirror)]; break;

      case MAT_COMPUTATION_MMULS:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMMulS)]; break;
      case MAT_COMPUTATION_MDIVS:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMDivS)]; break;
      case MAT_COMPUTATION_MMULCOMPV:       helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMMulCompV)]; break;
      case MAT_COMPUTATION_MDIVCOMPV:       helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMDivCompV)]; break;
      case MAT_COMPUTATION_MMULCOMPM:       helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMMulCompM)]; break;
      case MAT_COMPUTATION_MDIVCOMPM:       helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMDivCompM)]; break;
      
      case MAT_COMPUTATION_MNEG:            helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMNeg)]; break;
      case MAT_COMPUTATION_MADDM:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMAddM)]; break;
      case MAT_COMPUTATION_MSUBM:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMSubM)]; break;
      case MAT_COMPUTATION_MMULV:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMMulV)]; break;
      case MAT_COMPUTATION_MMULM:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMMulM)]; break;

      case MAT_COMPUTATION_DIAGS:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMDiagS)]; break;
      case MAT_COMPUTATION_DIAGV:           helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMDiagV)]; break;
      case MAT_COMPUTATION_MTRANSPOSE:      helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMTranspose)]; break;
      case MAT_COMPUTATION_MINVERT:         helpstring  = [NSString stringWithUTF8String:matTranslate(MATHelpMInvert)]; break;
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
  
  if(computation >= MAT_COMPUTATION_VMULS && computation <= MAT_COMPUTATION_MINVERT){
    computationController = controllers[computation * 3 + (dimensions - 2)];
    const NASpace* computationSpace = naGetControllerSpace(computationController);
    NSView* nativeView = naGetUIElementNativePtrConst(computationSpace);
    matUpdateController(computationController);
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


- (IBAction)changeDimensions:(id)sender{
  NA_UNUSED(sender);
  if(sender == dimension2Radio){dimensions = 2;}
  if(sender == dimension3Radio){dimensions = 3;}
  if(sender == dimension4Radio){dimensions = 4;}
  [self update];
}


@end


