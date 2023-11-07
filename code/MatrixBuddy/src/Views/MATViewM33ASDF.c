
#include "MATViewM33ASDF.h"
#include "NAMath/NAVectorAlgebra.h"

struct MATViewM33ASDF{
  MATValueChangedHandler handler;
  void* superCon;
  MATStatus status;
  
  NASpace* space;
  NALabel* errorLabel;
  NALabel* label;
  NAButton* copyButton;
  NAButton* pasteButton;

  NAVec2i dimensions;
  NATextField** textFields;
  double* values;
};



NABool mat_ViewM33Changed(NAReaction reaction){
  MATViewM33ASDF* con = (MATViewM33ASDF*)reaction.controller;

  NAString* text = naNewStringWithTextFieldText(reaction.uiElement);
  double value = atof(naGetStringUTF8Pointer(text));
  naDelete(text);
  
  for(size_t i = 0; i < con->dimensions[0] * con->dimensions[1]; ++i){
    if(reaction.uiElement == con->textFields[i]){
      con->values[i] = value;
    }
  }
  
  con->handler(con->superCon, con);
  return NA_TRUE;
}



NABool mat_ViewM33PressCopy(NAReaction reaction){
  MATViewM33ASDF* con = (MATViewM33ASDF*)reaction.controller;

  NAString* valueString = matNewStringWithFormatValue(con->values[0]);
  matPutStringToPasteboard(valueString);
  naDelete(valueString);
  
  return NA_TRUE;
}



NABool mat_ViewM33PressPaste(NAReaction reaction){
  MATViewM33ASDF* con = (MATViewM33ASDF*)reaction.controller;

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




MATViewM33ASDF* matAllocViewM33(
  MATValueChangedHandler handler,
  void* superCon,
  NAInt dimensionX,
  NAInt dimensionY,
  const double* initValues)
{
  MATViewM33ASDF* con = naAlloc(MATViewM33ASDF);

  con->dimensions[0] = dimensionX;
  con->dimensions[1] = dimensionY;

  con->handler = handler;
  con->superCon = superCon;
  con->status = MAT_STATUS_NORMAL;

  con->space = naNewSpace(naMakeSize(300, 350));
   
  con->errorLabel = naNewLabel("Error", 100);
  naSetLabelTextAlignment(con->errorLabel, NA_TEXT_ALIGNMENT_CENTER);
  naAddSpaceChild(con->space, con->errorLabel, naMakePos(10, 100));

  con->label = naNewLabel("s\u207b\u00b9\u1d40", MAT_TEXTFIELD_WIDTH);
  naSetLabelFont(con->label, matGetMathFont());
  naSetLabelTextAlignment(con->label, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelHeight(con->label, 40);
  naAddSpaceChild(con->space, con->label, naMakePos(10, 50));
    
  con->copyButton = naNewImagePushButton(matGetCopyImage(), naMakeSize(19, 19));
  naAddUIReaction(con->copyButton, NA_UI_COMMAND_PRESSED, mat_ViewM33PressCopy, con);
  naAddSpaceChild(con->space, con->copyButton, naMakePos(10, 10));

  con->pasteButton = naNewImagePushButton(matGetPasteImage(), naMakeSize(19, 19));
  naAddUIReaction(con->pasteButton, NA_UI_COMMAND_PRESSED, mat_ViewM33PressPaste, con);
  naAddSpaceChild(con->space, con->pasteButton, naMakePos(50, 10));

  size_t textFieldsByteSize = con->dimensions[0] * con->dimensions[1] * sizeof(NATextField*);
  con->textFields = naMalloc(textFieldsByteSize);
  for(size_t x = 0; x < con->dimensions[0]; ++x){
    for(size_t y = 0; y < con->dimensions[1]; ++y){
      size_t index = x * con->dimensions[1] + y;
      con->textFields[index] = naNewTextField(MAT_TEXTFIELD_WIDTH);
      matSetTextFieldCellProperties(con->textFields[index]);
      naAddSpaceChild(
        con->space,
        con->textFields[index],
        naMakePos(10 + x * 70, 30 + 60 - y * 30));
      naAddUIReaction(
        con->textFields[index],
        NA_UI_COMMAND_EDITED,
        mat_ViewM33Changed,
        con);
    }
  }

  size_t valuesByteSize = con->dimensions[0] * con->dimensions[1] * sizeof(double);
  con->values = naMalloc(valuesByteSize);
  naCopyn(con->values, initValues, valuesByteSize);

  return con;
}



void matDeallocViewM33(MATViewM33ASDF* con){
  naFree(con->values);
  naFree(con->textFields);
}



void matSetViewM33Status(MATViewM33ASDF* con, MATStatus status){
  con->status = status;
}



void matUpdateViewM33(MATViewM33ASDF* con){
  for(size_t x = 0; x < con->dimensions[0]; ++x){
    for(size_t y = 0; y < con->dimensions[1]; ++y){
      size_t index = x * con->dimensions[1] + y;
      NAString* valueString = matNewStringWithFormatValue(con->values[index]);
      naSetTextFieldText(con->textFields[index], naGetStringUTF8Pointer(valueString));
      naDelete(valueString);
    }
  }
  
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
}



const double* matGetViewM33Values(const MATViewM33ASDF* con){
  return con->values;
}

void matSetViewM33Values(MATViewM33ASDF* con, const double* values){
  size_t valuesByteSize = con->dimensions[0] * con->dimensions[1] * sizeof(double);
  naCopyn(con->values, values, valuesByteSize);
}




const NASpace* matGetViewM33Space(const MATViewM33ASDF* con){
  return con->space;
}
