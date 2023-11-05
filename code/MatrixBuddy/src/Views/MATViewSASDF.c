
#include "MATViewSASDF.h"

struct MATViewSASDF{
  MATValueChangedHandler handler;
  void* superCon;
  MATStatus status;
  
  NASpace* space;
  NALabel* errorLabel;
  NALabel* label;
  NAButton* copyButton;
  NAButton* pasteButton;

  NATextField* textFieldS;
  double* values;
};



NABool mat_ViewSChanged(NAReaction reaction){
  MATViewSASDF* con = (MATViewSASDF*)reaction.controller;

  NAString* text = naNewStringWithTextFieldText(reaction.uiElement);
  double value = atof(naGetStringUTF8Pointer(text));
  naDelete(text);
  
  if(reaction.uiElement == con->textFieldS){
    con->values[0] = value;
  }
  
  con->handler(con->superCon, con);
  return NA_TRUE;
}



NABool mat_ViewSPressCopy(NAReaction reaction){
  MATViewSASDF* con = (MATViewSASDF*)reaction.controller;

  NAString* valueString = matNewStringWithFormatValue(con->values[0]);
  matPutStringToPasteboard(valueString);
  naDelete(valueString);
  
  return NA_TRUE;
}



NABool mat_ViewSPressPaste(NAReaction reaction){
  MATViewSASDF* con = (MATViewSASDF*)reaction.controller;

  NAString* string = matNewStringFromPasteboard();
  const char* codeStr = naGetStringUTF8Pointer(string);

  char* newEndPtr;
  int index = 0;
  
  while(1){
    if(index == 1){break;}
    if(*codeStr == '\0'){break;}
    con->values[index] = strtod(codeStr, &newEndPtr);

    if(newEndPtr == codeStr){
      // No conversion found.
      codeStr++;
    }else{
      codeStr = newEndPtr;
      index++;
    }
  }

  con->handler(con->superCon, con);
  naDelete(string);

  return NA_TRUE;
}




MATViewSASDF* matAllocViewS(
  MATValueChangedHandler handler,
  void* superCon,
  const double* initValues)
{
  MATViewSASDF* con = naAlloc(MATViewSASDF);

  con->handler = handler;
  con->superCon = superCon;
  con->status = MAT_STATUS_NORMAL;

  con->space = naNewSpace(naMakeSize(100, 150));
   
  con->errorLabel = naNewLabel("Error", 100);
  naSetLabelTextAlignment(con->errorLabel, NA_TEXT_ALIGNMENT_CENTER);
  naAddSpaceChild(con->space, con->errorLabel, naMakePos(10, 100));

  con->label = naNewLabel("s\u207b\u00b9\u1d40", MAT_TEXTFIELD_WIDTH);
  naSetLabelFont(con->label, matGetMathFont());
  naSetLabelTextAlignment(con->label, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelHeight(con->label, 40);
  naAddSpaceChild(con->space, con->label, naMakePos(10, 50));
    
  con->copyButton = naNewImagePushButton(matGetCopyImage(), naMakeSize(19, 19));
  naAddUIReaction(con->copyButton, NA_UI_COMMAND_PRESSED, mat_ViewSPressCopy, con);
  naAddSpaceChild(con->space, con->copyButton, naMakePos(10, 10));

  con->pasteButton = naNewImagePushButton(matGetPasteImage(), naMakeSize(19, 19));
  naAddUIReaction(con->pasteButton, NA_UI_COMMAND_PRESSED, mat_ViewSPressPaste, con);
  naAddSpaceChild(con->space, con->pasteButton, naMakePos(50, 10));

  con->textFieldS = naNewTextField(MAT_TEXTFIELD_WIDTH);
  matSetTextFieldCellProperties(con->textFieldS);
  naAddSpaceChild(con->space, con->textFieldS, naMakePos(10, 30));
  
  naAddUIReaction(con->textFieldS, NA_UI_COMMAND_EDITED, mat_ViewSChanged, con);

  con->values = naMalloc(1 * sizeof(double));
  naCopyn(con->values, initValues, 1 * sizeof(double));

  return con;
}



void matDeallocViewS(MATViewSASDF* con){
  naFree(con->values);
  naFree(con->textFieldS);
}



void matSetViewSStatus(MATViewSASDF* view, MATStatus status){
  view->status = status;
}



void matUpdateViewS(MATViewSASDF* con){
  NAString* valueString = matNewStringWithFormatValue(con->values[0]);
  naSetTextFieldText(con->textFieldS, naGetStringUTF8Pointer(valueString));
  
  MATColor matColor = matGetColorWithStatus(con->status);
  NABool isNormal = matColor == MAT_COLOR_NORMAL;
  
  naSetLabelVisible(con->label, isNormal);
  naSetLabelVisible(con->errorLabel, !isNormal);

  if(isNormal){
    naSetLabelTextColor(con->label, NA_NULL);
    naSetLabelTextColor(con->errorLabel, NA_NULL);
    naSetSpaceBackgroundColor(con->space, NA_NULL);
  }else{
    NABabyColor color;
    matFillBabyColor(&color, matColor);
    naSetLabelTextColor(con->label, &color);
    naSetLabelTextColor(con->errorLabel, &color);
    color[3] *= .15;
    naSetSpaceBackgroundColor(con->space, &color);
  }

  naDelete(valueString);
}



const double* matGetViewSValues(const MATViewSASDF* con){
  return con->values;
}



const NASpace* matGetViewSSpace(const MATViewSASDF* con){
  return con->space;
}
