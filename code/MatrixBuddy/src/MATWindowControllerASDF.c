
#include "MATWindowControllerASDF.h"
#include "MATBaseController.h"
#include "NAApp/NAApp.h"

struct MATWindowControllerASDF{
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
};



NABool matDimensionsChanged(NAReaction reaction){
  MATWindowControllerASDF* con = (MATWindowControllerASDF*)reaction.controller;
  
  if(reaction.uiElement == con->radio2){
    con->dimensions = 2;
  }else if(reaction.uiElement == con->radio3){
    con->dimensions = 3;
  }else if(reaction.uiElement == con->radio4){
    con->dimensions = 4;
  }
  
  matUpdateWindowController(con);
  
  return NA_TRUE;
}



NABool matComputationChanged(NAReaction reaction){
  MATWindowControllerASDF* con = (MATWindowControllerASDF*)reaction.controller;

  for(int computation = 0; computation < MAT_COMPUTATION_COUNT; ++computation){
    if(reaction.uiElement == con->buttons[computation]){
      con->computation = computation;
      break;
    }
  }

  matUpdateWindowController(con);

  return NA_TRUE;
}



void matAddComputationButton(
  MATWindowControllerASDF* con,
  MATComputation computation,
  MATTranslation translation,
  NAPos pos)
{
  con->buttons[computation] = naNewTextStateButton(matTranslate(translation), NA_NULL, 50);
  naAddUIReaction(con->buttons[computation], NA_UI_COMMAND_PRESSED, matComputationChanged, con);
  naAddSpaceChild(con->buttonsSpace, con->buttons[computation], pos);
}


MATWindowControllerASDF* matAllocWindowController(){
  MATWindowControllerASDF* con = naAlloc(MATWindowControllerASDF);
  
  con->window = naNewWindow("Matrix Buddy", naMakeRectS(100, 100, 1075, 340), 0, 0);
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
  
  con->buttonsSpace = naNewSpace(naMakeSize(700, 75));
  naZeron(con->buttons, MAT_COMPUTATION_COUNT * sizeof(NAButton*));
  matAddComputationButton(con, MAT_COMPUTATION_VMULS, MATButtonVMulS, naMakePos(0, 50));
  matAddComputationButton(con, MAT_COMPUTATION_VDIVS, MATButtonVDivS, naMakePos(60, 50));
  matAddComputationButton(con, MAT_COMPUTATION_VMULCOMPV, MATButtonVMulCompV, naMakePos(120, 50));
  matAddComputationButton(con, MAT_COMPUTATION_VDIVCOMPV, MATButtonVDivCompV, naMakePos(180, 50));
  naAddSpaceChild(space, con->buttonsSpace, naMakePos(120, 250));

  naZeron(con->controllers, MAT_COMPUTATION_COUNT * 3 * sizeof(MATBaseController*));
  con->currentController = NA_NULL;
  con->dimensions = 3;
  con->computation = MAT_COMPUTATION_VMULS;
  
  matUpdateWindowController(con);
  naShowWindow(con->window);
  return con;
}



void matUpdateWindowController(MATWindowControllerASDF* con){
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
    case MAT_COMPUTATION_VMULS: newCon = matAllocVMulSController(con->dimensions); break;
    case MAT_COMPUTATION_VDIVS: newCon = matAllocVDivSController(con->dimensions); break;
    case MAT_COMPUTATION_VMULCOMPV: newCon = matAllocVMulCompVController(con->dimensions); break;
    case MAT_COMPUTATION_VDIVCOMPV: newCon = matAllocVDivCompVController(con->dimensions); break;
    }
    con->controllers[index] = newCon;
  }
  con->currentController = con->controllers[index];
  NASpace* controllerSpace = naGetControllerSpace(con->currentController);
  naAddSpaceChild(space, controllerSpace, naMakePos(0, 0));
}
