
#include "MATCommon.h"

@class MATComputationView;

@class MATMulV2S;
@class MATMulV3S;
@class MATMulV4S;
@class MATDivV2S;
@class MATDivV3S;
@class MATDivV4S;
@class MATMulCompV2V2;
@class MATMulCompV3V3;
@class MATMulCompV4V4;
@class MATDivCompV2V2;
@class MATDivCompV3V3;
@class MATDivCompV4V4;

@class MATNegV2;
@class MATNegV3;
@class MATNegV4;
@class MATAddV2V2;
@class MATAddV3V3;
@class MATAddV4V4;
@class MATSubV2V2;
@class MATSubV3V3;
@class MATSubV4V4;
@class MATDotV2V2;
@class MATDotV3V3;
@class MATDotV4V4;
@class MATCrossV3V3;
@class MATLengthV2;
@class MATLengthV3;
@class MATLengthV4;

@class MATNormalizeV2;
@class MATNormalizeV3;
@class MATNormalizeV4;
@class MATOrthogonalizeV2;
@class MATOrthogonalizeV3;
@class MATOrthogonalizeV4;
@class MATMirrorV2;
@class MATMirrorV3;
@class MATMirrorV4;

@class MATMulM22S;
@class MATMulM33S;
@class MATMulM44S;
@class MATDivM22S;
@class MATDivM33S;
@class MATDivM44S;
@class MATMulCompM22V2;
@class MATMulCompM33V3;
@class MATMulCompM44V4;
@class MATDivCompM22V2;
@class MATDivCompM33V3;
@class MATDivCompM44V4;
@class MATMulCompM22M22;
@class MATMulCompM33M33;
@class MATMulCompM44M44;
@class MATDivCompM22M22;
@class MATDivCompM33M33;
@class MATDivCompM44M44;

@class MATNegM22;
@class MATNegM33;
@class MATNegM44;
@class MATAddM22M22;
@class MATAddM33M33;
@class MATAddM44M44;
@class MATSubM22M22;
@class MATSubM33M33;
@class MATSubM44M44;
@class MATMulM22V2;
@class MATMulM33V3;
@class MATMulM44V4;
@class MATMulM22M22;
@class MATMulM33M33;
@class MATMulM44M44;

@class MATDiagSM22;
@class MATDiagSM33;
@class MATDiagSM44;
@class MATDiagV2M22;
@class MATDiagV3M33;
@class MATDiagV4M44;
@class MATTransposeM22;
@class MATTransposeM33;
@class MATTransposeM44;
@class MATInvertM22;
@class MATInvertM33;
@class MATInvertM44;


@interface MATWindowController : NSWindowController{
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
  IBOutlet NSMenuItem* helpItem;
  
  NABool showHelp;
  NABool showIdentifiers;
  NABool showCopyPaste;
  NABool hasRowFirstTabOrder;
  MATCodeStyle codeStyle;
  MATValueAccuracy valueAccuracy;
  
  IBOutlet NSTextField* helpLine;

  MATComputationView* computationView;
  MATComputation computation;
  MATDimensions dimensions;
  
  IBOutlet NSButton* dimension2Radio;
  IBOutlet NSButton* dimension3Radio;
  IBOutlet NSButton* dimension4Radio;

  IBOutlet NSButton* buttonVMulS;
  IBOutlet NSButton* buttonVDivS;
  IBOutlet NSButton* buttonVMulCompV;
  IBOutlet NSButton* buttonVDivCompV;

  IBOutlet NSButton* buttonNegV;
  IBOutlet NSButton* buttonVAddV;
  IBOutlet NSButton* buttonVSubV;
  IBOutlet NSButton* buttonVDotV;
  IBOutlet NSButton* buttonVCrossV;
  IBOutlet NSButton* buttonLengthV;

  IBOutlet NSButton* buttonNormalizeV;
  IBOutlet NSButton* buttonOrthogonalizeV;
  IBOutlet NSButton* buttonMirrorV;

  IBOutlet NSButton* buttonMMulS;
  IBOutlet NSButton* buttonMDivS;
  IBOutlet NSButton* buttonMMulCompV;
  IBOutlet NSButton* buttonMDivCompV;
  IBOutlet NSButton* buttonMMulCompM;
  IBOutlet NSButton* buttonMDivCompM;
  
  IBOutlet NSButton* buttonNegM;
  IBOutlet NSButton* buttonMAddM;
  IBOutlet NSButton* buttonMSubM;
  IBOutlet NSButton* buttonMMulv;
  IBOutlet NSButton* buttonMMulM;

  IBOutlet NSButton* buttonDiagS;
  IBOutlet NSButton* buttonDiagV;
  IBOutlet NSButton* buttonTransposeM;
  IBOutlet NSButton* buttonInvertM;

  NSButton* buttons[MAT_COMPUTATION_COUNT];
  
  IBOutlet MATComputationView* placeholder;

  IBOutlet MATMulV2S*           mulV2S;
  IBOutlet MATMulV3S*           mulV3S;
  IBOutlet MATMulV4S*           mulV4S;
  IBOutlet MATDivV2S*           divV2S;
  IBOutlet MATDivV3S*           divV3S;
  IBOutlet MATDivV4S*           divV4S;
  IBOutlet MATMulCompV2V2*      mulCompV2V2;
  IBOutlet MATMulCompV3V3*      mulCompV3V3;
  IBOutlet MATMulCompV4V4*      mulCompV4V4;
  IBOutlet MATDivCompV2V2*      divCompV2V2;
  IBOutlet MATDivCompV3V3*      divCompV3V3;
  IBOutlet MATDivCompV4V4*      divCompV4V4;

  IBOutlet MATNegV2*            negV2;
  IBOutlet MATNegV3*            negV3;
  IBOutlet MATNegV4*            negV4;
  IBOutlet MATAddV2V2*          addV2V2;
  IBOutlet MATAddV3V3*          addV3V3;
  IBOutlet MATAddV4V4*          addV4V4;
  IBOutlet MATSubV2V2*          subV2V2;
  IBOutlet MATSubV3V3*          subV3V3;
  IBOutlet MATSubV4V4*          subV4V4;
  IBOutlet MATDotV2V2*          dotV2V2;
  IBOutlet MATDotV3V3*          dotV3V3;
  IBOutlet MATDotV4V4*          dotV4V4;
  IBOutlet MATCrossV3V3*        crossV3V3;
  IBOutlet MATLengthV2*         lengthV2;
  IBOutlet MATLengthV3*         lengthV3;
  IBOutlet MATLengthV4*         lengthV4;

  IBOutlet MATNormalizeV2*      normalizeV2;
  IBOutlet MATNormalizeV3*      normalizeV3;
  IBOutlet MATNormalizeV4*      normalizeV4;
  IBOutlet MATOrthogonalizeV2*  orthogonalizeV2;
  IBOutlet MATOrthogonalizeV3*  orthogonalizeV3;
  IBOutlet MATOrthogonalizeV4*  orthogonalizeV4;
  IBOutlet MATMirrorV2*         mirrorV2;
  IBOutlet MATMirrorV3*         mirrorV3;
  IBOutlet MATMirrorV4*         mirrorV4;

  IBOutlet MATMulM22S*          mulM22S;
  IBOutlet MATMulM33S*          mulM33S;
  IBOutlet MATMulM44S*          mulM44S;
  IBOutlet MATDivM22S*          divM22S;
  IBOutlet MATDivM33S*          divM33S;
  IBOutlet MATDivM44S*          divM44S;
  IBOutlet MATMulCompM22V2*     mulCompM22V2;
  IBOutlet MATMulCompM33V3*     mulCompM33V3;
  IBOutlet MATMulCompM44V4*     mulCompM44V4;
  IBOutlet MATDivCompM22V2*     divCompM22V2;
  IBOutlet MATDivCompM33V3*     divCompM33V3;
  IBOutlet MATDivCompM44V4*     divCompM44V4;
  IBOutlet MATMulCompM22M22*    mulCompM22M22;
  IBOutlet MATMulCompM33M33*    mulCompM33M33;
  IBOutlet MATMulCompM44M44*    mulCompM44M44;
  IBOutlet MATDivCompM22M22*    divCompM22M22;
  IBOutlet MATDivCompM33M33*    divCompM33M33;
  IBOutlet MATDivCompM44M44*    divCompM44M44;
  
  IBOutlet MATNegM22*           negM22;
  IBOutlet MATNegM33*           negM33;
  IBOutlet MATNegM44*           negM44;
  IBOutlet MATAddM22M22*        addM22M22;
  IBOutlet MATAddM33M33*        addM33M33;
  IBOutlet MATAddM44M44*        addM44M44;
  IBOutlet MATSubM22M22*        subM22M22;
  IBOutlet MATSubM33M33*        subM33M33;
  IBOutlet MATSubM44M44*        subM44M44;
  IBOutlet MATMulM22V2*         mulM22v2;
  IBOutlet MATMulM33V3*         mulM33v3;
  IBOutlet MATMulM44V4*         mulM44v4;
  IBOutlet MATMulM22M22*        mulM22M22;
  IBOutlet MATMulM33M33*        mulM33M33;
  IBOutlet MATMulM44M44*        mulM44M44;

  IBOutlet MATDiagSM22*         diagSM22;
  IBOutlet MATDiagSM33*         diagSM33;
  IBOutlet MATDiagSM44*         diagSM44;
  IBOutlet MATDiagV2M22*        diagV2M22;
  IBOutlet MATDiagV3M33*        diagV3M33;
  IBOutlet MATDiagV4M44*        diagV4M44;
  IBOutlet MATTransposeM22*     transposeM22;
  IBOutlet MATTransposeM33*     transposeM33;
  IBOutlet MATTransposeM44*     transposeM44;
  IBOutlet MATInvertM22*        invertM22;
  IBOutlet MATInvertM33*        invertM33;
  IBOutlet MATInvertM44*        invertM44;

  MATComputationView* views[MAT_COMPUTATION_COUNT * 3];
}

- (void)prepareFirstView;
- (void)update;
- (NABool)hasShowHelp;
- (NABool)hasShowIdentifiers;
- (NABool)hasShowCopyPaste;
- (NABool)hasRowFirstTabOrder;
- (MATCodeStyle)codeStyle;
- (MATValueAccuracy)valueAccuracy;
- (IBAction)switchComputation:(id)sender;
- (IBAction)changeSetting:(id)sender;
- (IBAction)changeDimensions:(id)sender;

@end

