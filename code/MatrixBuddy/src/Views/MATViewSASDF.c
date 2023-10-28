
#include "MATViewSASDF.h"

struct MATViewSASDF{
  MATInputMatrix matrix;

  MATValueChangedHandler handler;
  void* superCon;
  
  NATextField* textFieldS;
};



NABool mat_ViewSChanged(NAReaction reaction){
  MATViewSASDF* con = (MATViewSASDF*)reaction.controller;

  NAString* text = naNewStringWithTextFieldText(reaction.uiElement);
  double value = atof(naGetStringUTF8Pointer(text));
  naDelete(text);
  
  if(reaction.uiElement == con->textFieldS){
    mat_SetInputMatrixValue(con, 0, value);
  }
  
  con->handler(con->superCon, con);
  return NA_TRUE;
}



MATViewSASDF* matAllocViewS(MATValueChangedHandler handler, void* superCon){
  MATViewSASDF* view = naAlloc(MATViewSASDF);

  mat_InitInputMatrix(&view->matrix, "s\u207b\u00b9\u1d40", 1);

  view->handler = handler;
  view->superCon = superCon;
  
  NASpace* space = matGetValueViewSpace(view);
  view->textFieldS = naNewTextField(MAT_TEXTFIELD_WIDTH);
  naAddSpaceChild(space, view->textFieldS, naMakePos(10, 30));
  
  naAddUIReaction(view->textFieldS, NA_UI_COMMAND_EDITED, mat_ViewSChanged, view);

  return view;
}



void matDeallocViewS(MATViewSASDF* view){
  mat_ClearInputMatrix(&view->matrix);
  naFree(view->textFieldS);
}



void mat_UpdateViewS(MATViewSASDF* view){
  mat_UpdateInputMatrix(&view->matrix);
}

