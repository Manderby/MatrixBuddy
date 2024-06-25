
#include "MATWindowController.h"
#include "ComputationControllers/MATBaseController.h"
#include "MATPreferences.h"
#include "MATApplication.h"
#include "NAApp/NAApp.h"

struct MATWindowController{
  NAWindow* window;
  
  NASpace* radioSpace;
  NARadio* radio2;
  NARadio* radio3;
  NARadio* radio4;
  
  NASpace* buttonsSpace;
  NAButton* buttons[MAT_COMPUTATION_COUNT];
  MATBaseController* controllers[MAT_COMPUTATION_COUNT * 3];
  MATBaseController* currentController;
  size_t dimensions;
  MATComputation computation;
  
  NAButton* settingsButton;
  NAMenu* settingsMenu;
  NAMenuItem* showHelpItem;
  NAMenuItem* showIdentifiersItem;
  NAMenuItem* showCopyPasteItem;
  NAMenuItem* codeCRowFirst1DItem;
  NAMenuItem* codeCRowFirst2DItem;
  NAMenuItem* codeCColumnFirst1DItem;
  NAMenuItem* codeCColumnFirst2DItem;
  NAMenuItem* codeMathematicaItem;
  NAMenuItem* codeMatlabItem;
  NAMenuItem* codeMapleItem;
  NAMenuItem* rowFirstTabOrderItem;
  NAMenuItem* columnFirstTabOrderItem;
  NAMenuItem* valueAccuracyNaturalItem;
  NAMenuItem* valueAccuracyFloatItem;
  NAMenuItem* aboutItem;
  NAMenuItem* helpItem;
};



void matDimensionsChanged(NAReaction reaction){
  MATWindowController* con = (MATWindowController*)reaction.controller;
  
  if(reaction.uiElement == con->radio2){
    con->dimensions = 2;
  }else if(reaction.uiElement == con->radio3){
    con->dimensions = 3;
  }else if(reaction.uiElement == con->radio4){
    con->dimensions = 4;
  }
  
  matUpdateWindowController(con);
}



void matComputationChanged(NAReaction reaction){
  MATWindowController* con = (MATWindowController*)reaction.controller;

  for(int computation = 0; computation < MAT_COMPUTATION_COUNT; ++computation){
    if(reaction.uiElement == con->buttons[computation]){
      con->computation = computation;
      break;
    }
  }

  matUpdateWindowController(con);
}



void matOpenSettings(NAReaction reaction){
  MATWindowController* con = (MATWindowController*)reaction.controller;

  NASpace* space = naGetWindowContentSpace(con->window);
  NARect rect = naGetUIElementRectAbsolute(con->settingsButton);
  NAPos menuPos = rect.pos;
  menuPos.x += rect.size.width;
  menuPos.y += rect.size.height;
  naPresentMenu(con->settingsMenu, menuPos, space);
}



void matSettingsMenuItemSelected(NAReaction reaction){
  MATWindowController* con = (MATWindowController*)reaction.controller;

  if(reaction.uiElement == con->showHelpItem){
    matToggleShowHelp();
  }else if(reaction.uiElement == con->showIdentifiersItem){
    matToggleShowIdentifiers();
  }else if(reaction.uiElement == con->showCopyPasteItem){
    matToggleShowCopyPaste();
  }else if(reaction.uiElement == con->codeCRowFirst1DItem){
    matSetCodeStyle(MAT_CODE_STYLE_C_ROW_FIRST_1D);
  }else if(reaction.uiElement == con->codeCRowFirst2DItem){
    matSetCodeStyle(MAT_CODE_STYLE_C_ROW_FIRST_2D);
  }else if(reaction.uiElement == con->codeCColumnFirst1DItem){
    matSetCodeStyle(MAT_CODE_STYLE_C_COLUMN_FIRST_1D);
  }else if(reaction.uiElement == con->codeCColumnFirst2DItem){
    matSetCodeStyle(MAT_CODE_STYLE_C_COLUMN_FIRST_2D);
  }else if(reaction.uiElement == con->codeMathematicaItem){
    matSetCodeStyle(MAT_CODE_STYLE_MATHEMATICA);
  }else if(reaction.uiElement == con->codeMatlabItem){
    matSetCodeStyle(MAT_CODE_STYLE_MATLAB);
  }else if(reaction.uiElement == con->codeMapleItem){
    matSetCodeStyle(MAT_CODE_STYLE_MAPLE);
  }else if(reaction.uiElement == con->rowFirstTabOrderItem){
    matSetUseRowFirstTabOrder(NA_TRUE);
  }else if(reaction.uiElement == con->columnFirstTabOrderItem){
    matSetUseRowFirstTabOrder(NA_FALSE);
  }else if(reaction.uiElement == con->valueAccuracyNaturalItem){
    matSetValueAccuracy(MAT_VALUE_ACCURACY_NATURAL);
  }else if(reaction.uiElement == con->valueAccuracyFloatItem){
    matSetValueAccuracy(MAT_VALUE_ACCURACY_FLOAT);
  }else if(reaction.uiElement == con->aboutItem){
    matShowApplicationAbout();
  }else if(reaction.uiElement == con->helpItem){
    matShowApplicationHelp();
  }
  matUpdateWindowController(con);
}


void matCloseWindow(NAReaction reaction){
  NA_UNUSED(reaction);
  
  naStopApplication();
}



void matAddComputationButton(
  MATWindowController* con,
  MATComputation computation,
  NAPos pos,
  double width)
{
  MATTranslation translationIndex = MATButtonVMulS + computation;
  con->buttons[computation] = naNewTextStateButton(matTranslate(translationIndex), NA_NULL, width);
  naAddUIReaction(con->buttons[computation], NA_UI_COMMAND_PRESSED, matComputationChanged, con);
  naAddSpaceChild(con->buttonsSpace, con->buttons[computation], pos);
}



void matAddSettingsMenuItem(
  MATWindowController* con,
  NAMenuItem** menuItem,
  MATTranslation translation)
{
  *menuItem = naNewMenuItem(matTranslate(translation));
  naAddUIReaction(*menuItem, NA_UI_COMMAND_PRESSED, matSettingsMenuItemSelected, con);
  naAddMenuItem(con->settingsMenu, *menuItem, NA_NULL);
}



MATWindowController* matAllocWindowController(){
  MATWindowController* con = naAlloc(MATWindowController);
  
  con->window = naNewWindow("Matrix Buddy", naMakeRectS(100, 100, 1105, 340), 0, 0);
  naAddUIReaction(con->window, NA_UI_COMMAND_CLOSES, matCloseWindow, con);
  NASpace* space = naGetWindowContentSpace(con->window);
  
  con->radio2 = naNewRadio("2D", 50);
  con->radio3 = naNewRadio("3D", 50);
  con->radio4 = naNewRadio("4D", 50);
  naAddUIReaction(con->radio2, NA_UI_COMMAND_PRESSED, matDimensionsChanged, con);
  naAddUIReaction(con->radio3, NA_UI_COMMAND_PRESSED, matDimensionsChanged, con);
  naAddUIReaction(con->radio4, NA_UI_COMMAND_PRESSED, matDimensionsChanged, con);
  con->radioSpace = naNewSpace(naMakeSize(100, 75));
  naAddSpaceChild(con->radioSpace, con->radio2, naMakePos(0, 50));
  naAddSpaceChild(con->radioSpace, con->radio3, naMakePos(0, 25));
  naAddSpaceChild(con->radioSpace, con->radio4, naMakePos(0, 0));
  naAddSpaceChild(space, con->radioSpace, naMakePos(10, 250));
  
  con->buttonsSpace = naNewSpace(naMakeSize(850, 75));
  naZeron(con->buttons, MAT_COMPUTATION_COUNT * sizeof(NAButton*));
  matAddComputationButton(con, MAT_COMPUTATION_VMULS,      naMakePos(0, 50), 50);
  matAddComputationButton(con, MAT_COMPUTATION_VDIVS,      naMakePos(60, 50), 50);
  matAddComputationButton(con, MAT_COMPUTATION_VMULCOMPV,  naMakePos(120, 50), 50);
  matAddComputationButton(con, MAT_COMPUTATION_VDIVCOMPV,  naMakePos(180, 50), 50);
  matAddComputationButton(con, MAT_COMPUTATION_VNEG,       naMakePos(0, 25), 50);
  matAddComputationButton(con, MAT_COMPUTATION_VADDV,      naMakePos(60, 25), 50);
  matAddComputationButton(con, MAT_COMPUTATION_VSUBV,      naMakePos(120, 25), 50);
  matAddComputationButton(con, MAT_COMPUTATION_VDOTV,      naMakePos(180, 25), 50);
  matAddComputationButton(con, MAT_COMPUTATION_VCROSSV,    naMakePos(240, 25), 50);
  matAddComputationButton(con, MAT_COMPUTATION_VLENGTH,    naMakePos(300, 25), 50);
  matAddComputationButton(con, MAT_COMPUTATION_VNORMALIZE, naMakePos(0, 0), 110);
  matAddComputationButton(con, MAT_COMPUTATION_VORTHO,     naMakePos(120, 0), 140);
  matAddComputationButton(con, MAT_COMPUTATION_VMIRROR,    naMakePos(270, 0), 80);
  matAddComputationButton(con, MAT_COMPUTATION_MMULS,      naMakePos(400, 50), 50);
  matAddComputationButton(con, MAT_COMPUTATION_MDIVS,      naMakePos(460, 50), 50);
  matAddComputationButton(con, MAT_COMPUTATION_MMULCOMPV,  naMakePos(520, 50), 50);
  matAddComputationButton(con, MAT_COMPUTATION_MDIVCOMPV,  naMakePos(580, 50), 50);
  matAddComputationButton(con, MAT_COMPUTATION_MMULCOMPM,  naMakePos(640, 50), 50);
  matAddComputationButton(con, MAT_COMPUTATION_MDIVCOMPM,  naMakePos(700, 50), 50);
  matAddComputationButton(con, MAT_COMPUTATION_MNEG,       naMakePos(400, 25), 50);
  matAddComputationButton(con, MAT_COMPUTATION_MADDM,      naMakePos(460, 25), 50);
  matAddComputationButton(con, MAT_COMPUTATION_MSUBM,      naMakePos(520, 25), 50);
  matAddComputationButton(con, MAT_COMPUTATION_MMULV,      naMakePos(580, 25), 50);
  matAddComputationButton(con, MAT_COMPUTATION_MMULM,      naMakePos(640, 25), 50);
  matAddComputationButton(con, MAT_COMPUTATION_MDIAGS,     naMakePos(400, 0), 80);
  matAddComputationButton(con, MAT_COMPUTATION_MDIAGV,     naMakePos(490, 0), 80);
  matAddComputationButton(con, MAT_COMPUTATION_MTRANSPOSE, naMakePos(580, 0), 110);
  matAddComputationButton(con, MAT_COMPUTATION_MINVERT,    naMakePos(700, 0), 110);
  naAddSpaceChild(space, con->buttonsSpace, naMakePos(120, 250));

  naZeron(con->controllers, MAT_COMPUTATION_COUNT * 3 * sizeof(MATBaseController*));
  con->currentController = NA_NULL;
  con->dimensions = 3;
  con->computation = MAT_COMPUTATION_VMULS;
  
  con->settingsButton = naNewIconPushButton(matGetSettingsImage(), 30);
  naAddUIReaction(con->settingsButton, NA_UI_COMMAND_PRESSED, matOpenSettings, con);
  naAddSpaceChild(space, con->settingsButton, naMakePos(950, 300));
  con->settingsMenu = naNewMenu();
  matAddSettingsMenuItem(con, &con->showHelpItem, MATMenuItemShowHelp);
  matAddSettingsMenuItem(con, &con->showIdentifiersItem, MATMenuItemShowIdentifiers);
  naAddMenuItem(con->settingsMenu, naNewMenuSeparator(), NA_NULL);
  matAddSettingsMenuItem(con, &con->showCopyPasteItem, MATMenuItemShowCopyPaste);
  matAddSettingsMenuItem(con, &con->codeCRowFirst1DItem, MATMenuItemCodeCRowFirstItem1D);
  matAddSettingsMenuItem(con, &con->codeCRowFirst2DItem, MATMenuItemCodeCRowFirstItem2D);
  matAddSettingsMenuItem(con, &con->codeCColumnFirst1DItem, MATMenuItemCodeCColumnFirstItem1D);
  matAddSettingsMenuItem(con, &con->codeCColumnFirst2DItem, MATMenuItemCodeCColumnFirstItem2D);
  matAddSettingsMenuItem(con, &con->codeMathematicaItem, MATMenuItemCodeMathematica);
  matAddSettingsMenuItem(con, &con->codeMatlabItem, MATMenuItemCodeMatlab);
  matAddSettingsMenuItem(con, &con->codeMapleItem, MATMenuItemCodeMaple);
  naAddMenuItem(con->settingsMenu, naNewMenuSeparator(), NA_NULL);
  matAddSettingsMenuItem(con, &con->rowFirstTabOrderItem, MATMenuItemRowFirstTabOrder);
  matAddSettingsMenuItem(con, &con->columnFirstTabOrderItem, MATMenuItemColumnFirstTabOrder);
  naAddMenuItem(con->settingsMenu, naNewMenuSeparator(), NA_NULL);
  matAddSettingsMenuItem(con, &con->valueAccuracyNaturalItem, MATMenuItemValueAccuracyNatural);
  matAddSettingsMenuItem(con, &con->valueAccuracyFloatItem, MATMenuItemValueAccuracyFloat);
  naAddMenuItem(con->settingsMenu, naNewMenuSeparator(), NA_NULL);
  matAddSettingsMenuItem(con, &con->aboutItem, MATMenuItemAbout);
  matAddSettingsMenuItem(con, &con->helpItem, MATMenuItemHelp);
  naAddMenuItem(con->settingsMenu, naNewMenuSeparator(), NA_NULL);
  matUpdateWindowController(con);
  naShowWindow(con->window);
  return con;
}



void matDeallocWindowController(MATWindowController* con){
  naFree(con);
}



void matUpdateWindowController(MATWindowController* con){
  NASpace* space = naGetWindowContentSpace(con->window);

  naSetRadioState(con->radio2, con->dimensions == 2);
  naSetRadioState(con->radio3, con->dimensions == 3);
  naSetRadioState(con->radio4, con->dimensions == 4);
  
  if(con->currentController){
    naRemoveSpaceChild(space, naGetControllerSpace(con->currentController));
  }
  
  for(int computation = 0; computation < MAT_COMPUTATION_COUNT; ++computation){
    if(con->buttons[computation]){
      naSetButtonState(con->buttons[computation], computation == con->computation);
    }
  }

  size_t index = con->computation * 3 + (con->dimensions - 2);
  if(!con->controllers[index]){
    MATBaseController* newCon = NA_NULL;
    switch(con->computation){
    case MAT_COMPUTATION_VMULS:      newCon = matAllocVMulSController(con->dimensions); break;
    case MAT_COMPUTATION_VDIVS:      newCon = matAllocVDivSController(con->dimensions); break;
    case MAT_COMPUTATION_VMULCOMPV:  newCon = matAllocVMulCompVController(con->dimensions); break;
    case MAT_COMPUTATION_VDIVCOMPV:  newCon = matAllocVDivCompVController(con->dimensions); break;
    case MAT_COMPUTATION_VNEG:       newCon = matAllocVNegController(con->dimensions); break;
    case MAT_COMPUTATION_VADDV:      newCon = matAllocVAddVController(con->dimensions); break;
    case MAT_COMPUTATION_VSUBV:      newCon = matAllocVSubVController(con->dimensions); break;
    case MAT_COMPUTATION_VDOTV:      newCon = matAllocVDotVController(con->dimensions); break;
    case MAT_COMPUTATION_VCROSSV:    newCon = matAllocVCrossVController(3); break;
    case MAT_COMPUTATION_VLENGTH:    newCon = matAllocVLengthController(con->dimensions); break;
    case MAT_COMPUTATION_VNORMALIZE: newCon = matAllocVNormalizeController(con->dimensions); break;
    case MAT_COMPUTATION_VORTHO:     newCon = matAllocVOrthoController(con->dimensions); break;
    case MAT_COMPUTATION_VMIRROR:    newCon = matAllocVMirrorController(con->dimensions); break;
    case MAT_COMPUTATION_MMULS:      newCon = matAllocMMulSController(con->dimensions); break;
    case MAT_COMPUTATION_MDIVS:      newCon = matAllocMDivSController(con->dimensions); break;
    case MAT_COMPUTATION_MMULCOMPV:  newCon = matAllocMMulCompVController(con->dimensions); break;
    case MAT_COMPUTATION_MDIVCOMPV:  newCon = matAllocMDivCompVController(con->dimensions); break;
    case MAT_COMPUTATION_MMULCOMPM:  newCon = matAllocMMulCompMController(con->dimensions); break;
    case MAT_COMPUTATION_MDIVCOMPM:  newCon = matAllocMDivCompMController(con->dimensions); break;
    case MAT_COMPUTATION_MNEG:       newCon = matAllocMNegController(con->dimensions); break;
    case MAT_COMPUTATION_MADDM:      newCon = matAllocMAddMController(con->dimensions); break;
    case MAT_COMPUTATION_MSUBM:      newCon = matAllocMSubMController(con->dimensions); break;
    case MAT_COMPUTATION_MMULV:      newCon = matAllocMMulVController(con->dimensions); break;
    case MAT_COMPUTATION_MMULM:      newCon = matAllocMMulMController(con->dimensions); break;
    case MAT_COMPUTATION_MDIAGS:     newCon = matAllocMDiagSController(con->dimensions); break;
    case MAT_COMPUTATION_MDIAGV:     newCon = matAllocMDiagVController(con->dimensions); break;
    case MAT_COMPUTATION_MTRANSPOSE: newCon = matAllocMTransposeController(con->dimensions); break;
    case MAT_COMPUTATION_MINVERT:    newCon = matAllocMInvertController(con->dimensions); break;
    default: break;
    }
    con->controllers[index] = newCon;
  }
  con->currentController = con->controllers[index];
  NASpace* controllerSpace = naGetControllerSpace(con->currentController);
  naAddSpaceChild(space, controllerSpace, naMakePos(0, 0));

  matUpdateController(con->currentController);
  matUpdateControllerTabOrder(con->currentController);

  naSetMenuItemState(con->showHelpItem, matGetShowHelp());
  naSetMenuItemState(con->showIdentifiersItem, matGetShowIdentifiers());
  naSetMenuItemState(con->showCopyPasteItem, matGetShowCopyPaste());
  
  MATCodeStyle codeStyle = matGetCodeStyle();
  naSetMenuItemState(con->codeCRowFirst1DItem, codeStyle == MAT_CODE_STYLE_C_ROW_FIRST_1D);
  naSetMenuItemState(con->codeCRowFirst2DItem, codeStyle == MAT_CODE_STYLE_C_ROW_FIRST_2D);
  naSetMenuItemState(con->codeCColumnFirst1DItem, codeStyle == MAT_CODE_STYLE_C_COLUMN_FIRST_1D);
  naSetMenuItemState(con->codeCColumnFirst2DItem, codeStyle == MAT_CODE_STYLE_C_COLUMN_FIRST_2D);
  naSetMenuItemState(con->codeMathematicaItem, codeStyle == MAT_CODE_STYLE_MATHEMATICA);
  naSetMenuItemState(con->codeMatlabItem, codeStyle == MAT_CODE_STYLE_MATLAB);
  naSetMenuItemState(con->codeMapleItem, codeStyle == MAT_CODE_STYLE_MAPLE);
  
  naSetMenuItemState(con->rowFirstTabOrderItem, matGetUseRowFirstTabOrder()); naSetMenuItemState(con->columnFirstTabOrderItem, !matGetUseRowFirstTabOrder());
  
  MATValueAccuracy accuray = matGetValueAccuracy();
  naSetMenuItemState(con->valueAccuracyNaturalItem, accuray == MAT_VALUE_ACCURACY_NATURAL);
  naSetMenuItemState(con->valueAccuracyFloatItem, accuray == MAT_VALUE_ACCURACY_FLOAT);
}



// This is free and unencumbered software released into the public domain.

// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.

// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

// For more information, please refer to <http://unlicense.org/>
