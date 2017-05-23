
#import "MATWindowController.h"
#import "MATComputationView.h"

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


#define MAT_DEFAULT_SHOW_HELP @"showHelp"
#define MAT_DEFAULT_SHOW_IDENTIFIERS @"showIdentifiers"
#define MAT_DEFAULT_TAB_ORDER_ROW_FIRST @"useRowFirstTabOrder"
#define MAT_DEFAULT_CODE_STYLE @"codeStyle"
#define MAT_DEFAULT_VALUE_ACCURACY @"valueAccuracy"


@implementation MATWindowController


- (void)awakeFromNib{

  computationView = placeholder;

  NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];

  int showHelpDefault = (int)[userdefaults integerForKey:MAT_DEFAULT_SHOW_HELP];
  if(showHelpDefault == -1){showHelp = NA_FALSE;}
  else if(showHelpDefault == 1){showHelp = NA_TRUE;}
  else{showHelp = NA_TRUE;}

  int showIdentifiersDefault = (int)[userdefaults integerForKey:MAT_DEFAULT_SHOW_IDENTIFIERS];
  if(showIdentifiersDefault == -1){showIdentifiers = NA_FALSE;}
  else if(showIdentifiersDefault == 1){showIdentifiers = NA_TRUE;}
  else{showIdentifiers = NA_TRUE;}

  int hasRowFirstTabOrderDefault = (int)[userdefaults integerForKey:MAT_DEFAULT_TAB_ORDER_ROW_FIRST];
  if(hasRowFirstTabOrderDefault == -1){hasRowFirstTabOrder = NA_FALSE;}
  else if(hasRowFirstTabOrderDefault == 1){hasRowFirstTabOrder = NA_TRUE;}
  else{hasRowFirstTabOrder = NA_TRUE;}

  int codeStyleDefault = (int)[userdefaults integerForKey:MAT_DEFAULT_CODE_STYLE];
  if(codeStyleDefault == -1){codeStyle = MAT_CODE_STYLE_NONE;}
  else if(codeStyleDefault > 0){codeStyle = (MATCodeStyle)codeStyleDefault;}
  else{codeStyle = MAT_CODE_STYLE_C_ROW_FIRST_1D;}

  int valueAccuracyDefault = (int)[userdefaults integerForKey:MAT_DEFAULT_VALUE_ACCURACY];
  if(valueAccuracyDefault == -1){valueAccuracy = MAT_VALUE_ACCURACY_NATURAL;}
  else if(valueAccuracyDefault > 0){valueAccuracy = (MATValueAccuracy)valueAccuracyDefault;}
  else{codeStyle = MAT_CODE_STYLE_C_ROW_FIRST_1D;}
  
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

  views[MAT_COMPUTATION_MMULS * 3 + 0]          = mulM22S;
  views[MAT_COMPUTATION_MMULS * 3 + 1]          = mulM33S;
  views[MAT_COMPUTATION_MMULS * 3 + 2]          = mulM44S;
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
  dimensions = MAT_DIMENSIONS_3;
  
}



- (void)prepareFirstView{
  [self switchComputation:buttonMMulv];
}



- (void)update{
  if([self hasShowHelp]){
    [helpLine setHidden:NO];
    NSString* helpstring;
    switch(computation){
      case MAT_COMPUTATION_VMULS:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpVMulS"          value:nil table:nil]; break;
      case MAT_COMPUTATION_VDIVS:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpVDivS"          value:nil table:nil]; break;
      case MAT_COMPUTATION_VMULCOMPV:       helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpVMulCompV"      value:nil table:nil]; break;
      case MAT_COMPUTATION_VDIVCOMPV:       helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpVDivCompV"      value:nil table:nil]; break;

      case MAT_COMPUTATION_NEGV:            helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpNegV"           value:nil table:nil]; break;
      case MAT_COMPUTATION_VADDV:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpVAddV"          value:nil table:nil]; break;
      case MAT_COMPUTATION_VSUBV:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpVSubV"          value:nil table:nil]; break;
      case MAT_COMPUTATION_VDOTV:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpVDotV"          value:nil table:nil]; break;
      case MAT_COMPUTATION_VCROSSV:         helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpVCrossV"        value:nil table:nil]; break;
      case MAT_COMPUTATION_LENGTHV:         helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpLengthV"        value:nil table:nil]; break;

      case MAT_COMPUTATION_NORMALIZEV:      helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpNormalizeV"     value:nil table:nil]; break;
      case MAT_COMPUTATION_ORTHOGONALIZEV:  helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpOrthogonalizeV" value:nil table:nil]; break;
      case MAT_COMPUTATION_MIRRORV:         helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpMirrorV"        value:nil table:nil]; break;

      case MAT_COMPUTATION_MMULS:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpMMulS"          value:nil table:nil]; break;
      case MAT_COMPUTATION_MDIVS:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpMDivS"          value:nil table:nil]; break;
      case MAT_COMPUTATION_MMULCOMPV:       helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpMMulCompV"      value:nil table:nil]; break;
      case MAT_COMPUTATION_MDIVCOMPV:       helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpMDivCompV"      value:nil table:nil]; break;
      case MAT_COMPUTATION_MMULCOMPM:       helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpMMulCompM"      value:nil table:nil]; break;
      case MAT_COMPUTATION_MDIVCOMPM:       helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpMDivCompM"      value:nil table:nil]; break;
      
      case MAT_COMPUTATION_NEGM:            helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpNegM"           value:nil table:nil]; break;
      case MAT_COMPUTATION_MADDM:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpMAddM"          value:nil table:nil]; break;
      case MAT_COMPUTATION_MSUBM:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpMSubM"          value:nil table:nil]; break;
      case MAT_COMPUTATION_MMULV:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpMMulV"          value:nil table:nil]; break;
      case MAT_COMPUTATION_MMULM:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpMMulM"          value:nil table:nil]; break;

      case MAT_COMPUTATION_DIAGS:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpDiagS"          value:nil table:nil]; break;
      case MAT_COMPUTATION_DIAGV:           helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpDiagV"          value:nil table:nil]; break;
      case MAT_COMPUTATION_TRANSPOSEM:      helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpTransposeM"     value:nil table:nil]; break;
      case MAT_COMPUTATION_INVERTM:         helpstring  = [[NSBundle mainBundle] localizedStringForKey:@"MATHelpInvertM"        value:nil table:nil]; break;
    default:
      helpstring = @"";
    }
    [helpLine setStringValue:helpstring];
  }else{
    [helpLine setHidden:YES];
  }

  for(MATComputation m=0; m<MAT_COMPUTATION_COUNT; m++){
    [buttons[m] setState:NSOffState];
  }
  [buttons[computation] setState:NSOnState];
  [dimensionChooser setSelectedSegment:dimensions];

  [showHelpItem setState:(showHelp?NSOnState:NSOffState)];
  [showIdentifiersItem setState:(showIdentifiers?NSOnState:NSOffState)];

  if(hasRowFirstTabOrder){
    [rowFirstTabOrderItem setState:NSOnState];
    [columnFirstTabOrderItem setState:NSOffState];
  }else{
    [rowFirstTabOrderItem setState:NSOffState];
    [columnFirstTabOrderItem setState:NSOnState];
  }
  
  [codeNoneItem setState:NSOffState];
  [codeCRowFirstItem1D setState:NSOffState];
  [codeCRowFirstItem2D setState:NSOffState];
  [codeCColumnFirstItem1D setState:NSOffState];
  [codeCColumnFirstItem2D setState:NSOffState];
  [codeMathematicaItem setState:NSOffState];
  [codeMatlabItem setState:NSOffState];
  [codeMapleItem setState:NSOffState];
  switch(codeStyle){
  case MAT_CODE_STYLE_NONE: [codeNoneItem setState:NSOnState]; break;
  case MAT_CODE_STYLE_C_ROW_FIRST_1D: [codeCRowFirstItem1D setState:NSOnState]; break;
  case MAT_CODE_STYLE_C_ROW_FIRST_2D: [codeCRowFirstItem2D setState:NSOnState]; break;
  case MAT_CODE_STYLE_C_COLUMN_FIRST_1D: [codeCColumnFirstItem1D setState:NSOnState]; break;
  case MAT_CODE_STYLE_C_COLUMN_FIRST_2D: [codeCColumnFirstItem2D setState:NSOnState]; break;
  case MAT_CODE_STYLE_MATHEMATICA: [codeMathematicaItem setState:NSOnState]; break;
  case MAT_CODE_STYLE_MATLAB: [codeMatlabItem setState:NSOnState]; break;
  case MAT_CODE_STYLE_MAPLE: [codeMapleItem setState:NSOnState]; break;
  }
  
  [valueAccuracyNaturalItem setState:NSOffState];
  [valueAccuracyFloatItem setState:NSOffState];
  switch(valueAccuracy){
  case MAT_VALUE_ACCURACY_NATURAL: [valueAccuracyNaturalItem setState:NSOnState]; break;
  case MAT_VALUE_ACCURACY_FLOAT: [valueAccuracyFloatItem setState:NSOnState]; break;
  }

  NSRect frame = [computationView frame];
  [computationView removeFromSuperview];
  computationView = views[computation * 3 + dimensions];
  [computationView setFrame:frame];
  [[[self window] contentView] addSubview:computationView];
  [computationView valueChanged:self];
  [computationView update];

  // note: when uncommented, the focus changes always. even when just switching
  // the tab order.
//  [[self window] makeFirstResponder:[computationView firstResponder]];
}



- (NABool)hasShowHelp{
  return showHelp;
}
- (NABool)hasShowIdentifiers{
  return showIdentifiers;
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




- (IBAction)switchComputation:(id)sender{
  [buttons[computation] setState:NSOffState];

  for(MATComputation m=0; m<MAT_COMPUTATION_COUNT; m++){
    if(sender == buttons[m]){
      computation = m;
      break;
    }
  }
  
  [buttons[computation] setState:NSOnState];

  [self update];
}


- (IBAction)changeSetting:(id)sender{
  NA_UNUSED(sender);

  NSUserDefaults* userdefaults = [NSUserDefaults standardUserDefaults];

  if(sender == showHelpItem){
    showHelp = !showHelp;
    [userdefaults setInteger:(showHelp?1:-1) forKey:MAT_DEFAULT_SHOW_HELP];
  }else if(sender == showIdentifiersItem){
    showIdentifiers = !showIdentifiers;
    [userdefaults setInteger:(showIdentifiers?1:-1) forKey:MAT_DEFAULT_SHOW_IDENTIFIERS];
  }else if(sender == rowFirstTabOrderItem){
    hasRowFirstTabOrder = NA_TRUE;
    [userdefaults setInteger:1 forKey:MAT_DEFAULT_TAB_ORDER_ROW_FIRST];
  }else if(sender == columnFirstTabOrderItem){
    hasRowFirstTabOrder = NA_FALSE;
    [userdefaults setInteger:-1 forKey:MAT_DEFAULT_TAB_ORDER_ROW_FIRST];
  }else if(sender == codeNoneItem){
    codeStyle = MAT_CODE_STYLE_NONE;
    [userdefaults setInteger:-1 forKey:MAT_DEFAULT_CODE_STYLE];
  }else if(sender == codeCRowFirstItem1D){
    codeStyle = MAT_CODE_STYLE_C_ROW_FIRST_1D;
    [userdefaults setInteger:codeStyle forKey:MAT_DEFAULT_CODE_STYLE];
  }else if(sender == codeCRowFirstItem2D){
    codeStyle = MAT_CODE_STYLE_C_ROW_FIRST_2D;
    [userdefaults setInteger:codeStyle forKey:MAT_DEFAULT_CODE_STYLE];
  }else if(sender == codeCColumnFirstItem1D){
    codeStyle = MAT_CODE_STYLE_C_COLUMN_FIRST_1D;
    [userdefaults setInteger:codeStyle forKey:MAT_DEFAULT_CODE_STYLE];
  }else if(sender == codeCColumnFirstItem2D){
    codeStyle = MAT_CODE_STYLE_C_COLUMN_FIRST_2D;
    [userdefaults setInteger:codeStyle forKey:MAT_DEFAULT_CODE_STYLE];
  }else if(sender == codeMathematicaItem){
    codeStyle = MAT_CODE_STYLE_MATHEMATICA;
    [userdefaults setInteger:codeStyle forKey:MAT_DEFAULT_CODE_STYLE];
  }else if(sender == codeMatlabItem){
    codeStyle = MAT_CODE_STYLE_MATLAB;
    [userdefaults setInteger:codeStyle forKey:MAT_DEFAULT_CODE_STYLE];
  }else if(sender == codeMapleItem){
    codeStyle = MAT_CODE_STYLE_MAPLE;
    [userdefaults setInteger:codeStyle forKey:MAT_DEFAULT_CODE_STYLE];
  }else if(sender == valueAccuracyNaturalItem){
    valueAccuracy = MAT_VALUE_ACCURACY_NATURAL;
    [userdefaults setInteger:valueAccuracy forKey:MAT_DEFAULT_VALUE_ACCURACY];
  }else if(sender == valueAccuracyFloatItem){
    valueAccuracy = MAT_VALUE_ACCURACY_FLOAT;
    [userdefaults setInteger:valueAccuracy forKey:MAT_DEFAULT_VALUE_ACCURACY];
  }else{}
  [self update];
}


- (IBAction)changeDimensions:(id)sender{
  NA_UNUSED(sender);
  dimensions = (MATDimensions)[dimensionChooser selectedSegment];
  [self update];
}


@end


