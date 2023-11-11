
#include "MATView.h"
#include "NAMath/NAVectorAlgebra.h"

struct MATView{
  MATValueChangedHandler handler;
  void* con;
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



NABool mat_ViewChanged(NAReaction reaction){
  MATView* view = (MATView*)reaction.controller;

  NAString* text = naNewStringWithTextFieldText(reaction.uiElement);
  double value = atof(naGetStringUTF8Pointer(text));
  naDelete(text);
  
  
  for(size_t i = 0; i < view->dimensions[0] * view->dimensions[1]; ++i){
    if(reaction.uiElement == view->textFields[i]){
      view->values[i] = value;
    }
  }
  
  view->handler(view->con, view);
  return NA_TRUE;
}



NABool mat_ViewPressCopy(NAReaction reaction){
  MATView* view = (MATView*)reaction.controller;

  NAString* valueString = matNewStringWithFormatValue(view->values[0]);
  matPutStringToPasteboard(valueString);
  naDelete(valueString);
  
  return NA_TRUE;
}



NABool mat_ViewPressPaste(NAReaction reaction){
  MATView* view = (MATView*)reaction.controller;

  NAString* string = matNewStringFromPasteboard();
  const char* codeStr = naGetStringUTF8Pointer(string);

  char* newEndPtr;
  int index = 0;
  
  while(1){
    if(index == 1){break;}
    if(*codeStr == '\0'){break;}
    view->values[index] = strtod(codeStr, &newEndPtr);

    if(newEndPtr == codeStr){
      // No conversion found.
      codeStr++;
    }else{
      codeStr = newEndPtr;
      index++;
    }
  }

  view->handler(view->con, view);
  naDelete(string);

  return NA_TRUE;
}




MATView* matAllocView(
  const NAUTF8Char* label,
  NAInt dimensionX,
  NAInt dimensionY,
  MATValueChangedHandler handler,
  void* con,
  const double* initValues)
{
  MATView* view = naAlloc(MATView);

  view->dimensions[0] = dimensionX;
  view->dimensions[1] = dimensionY;

  view->handler = handler;
  view->con = con;
  view->status = MAT_STATUS_NORMAL;

  MATDimensions dimensions = matGetDimensions();
  NASize viewSize = {
    view->dimensions[0] * MAT_TEXTFIELD_WIDTHASDF + (view->dimensions[0] - 1) * MAT_TEXTFIELD_SPACE_HASDF + 2 * MAT_MATRIX_MARGINASDF,
    350};

  view->space = naNewSpace(viewSize);
   
  view->errorLabel = naNewLabel("Error", viewSize.width);
  naSetLabelTextAlignment(view->errorLabel, NA_TEXT_ALIGNMENT_CENTER);
  naAddSpaceChild(view->space, view->errorLabel, naMakePos(0, 100));

  // "s\u207b\u00b9\u1d40"
  view->label = naNewLabel(label, viewSize.width);
  naSetLabelFont(view->label, matGetMathFont());
  naSetLabelTextAlignment(view->label, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelHeight(view->label, 40);
  naAddSpaceChild(view->space, view->label, naMakePos(0, 50));
    
  view->copyButton = naNewImagePushButton(matGetCopyImage(), naMakeSize(19, 19));
  naAddUIReaction(view->copyButton, NA_UI_COMMAND_PRESSED, mat_ViewPressCopy, view);
  naAddSpaceChild(view->space, view->copyButton, naMakePos(10, 10));

  view->pasteButton = naNewImagePushButton(matGetPasteImage(), naMakeSize(19, 19));
  naAddUIReaction(view->pasteButton, NA_UI_COMMAND_PRESSED, mat_ViewPressPaste, view);
  naAddSpaceChild(view->space, view->pasteButton, naMakePos(50, 10));

  size_t textFieldsByteSize = view->dimensions[0] * view->dimensions[1] * sizeof(NATextField*);
  view->textFields = naMalloc(textFieldsByteSize);
  for(size_t x = 0; x < view->dimensions[0]; ++x){
    for(size_t y = 0; y < view->dimensions[1]; ++y){
      size_t index = x * view->dimensions[1] + y;
      view->textFields[index] = naNewTextField(MAT_TEXTFIELD_WIDTHASDF);
      matSetTextFieldCellProperties(view->textFields[index]);
      naAddSpaceChild(
        view->space,
        view->textFields[index],
        naMakePos(
          MAT_MATRIX_MARGINASDF + x * (MAT_TEXTFIELD_WIDTHASDF + MAT_TEXTFIELD_SPACE_HASDF),
          30 + 60 - y * 30));
      naAddUIReaction(
        view->textFields[index],
        NA_UI_COMMAND_EDIT_FINISHED,
        mat_ViewChanged,
        view);
    }
  }

  size_t valuesByteSize = view->dimensions[0] * view->dimensions[1] * sizeof(double);
  view->values = naMalloc(valuesByteSize);
  naCopyn(view->values, initValues, valuesByteSize);

  return view;
}



void matDeallocView(MATView* view){
  naFree(view->values);
  naFree(view->textFields);
}



void matSetViewStatus(MATView* view, MATStatus status){
  view->status = status;
}



void matUpdateView(MATView* view){
  for(size_t x = 0; x < view->dimensions[0]; ++x){
    for(size_t y = 0; y < view->dimensions[1]; ++y){
      size_t index = x * view->dimensions[1] + y;
      NAString* valueString = matNewStringWithFormatValue(view->values[index]);
      naSetTextFieldText(view->textFields[index], naGetStringUTF8Pointer(valueString));
      naDelete(valueString);
    }
  }
  
  MATColor matColor = matGetColorWithStatus(view->status);
  NABool isNormal = matColor == MAT_COLOR_NORMAL;
  NABool isError = !(isNormal || matColor == MAT_COLOR_RESULT);
  
  naSetLabelVisible(view->label, !isError);
  naSetLabelVisible(view->errorLabel, isError);

  if(isNormal){
    naSetLabelTextColor(view->label, NA_NULL);
    naSetLabelTextColor(view->errorLabel, NA_NULL);
    naSetSpaceBackgroundColor(view->space, NA_NULL);
  }else{
    NABabyColor color;
    matFillBabyColor(&color, matColor);
    naSetLabelTextColor(view->label, &color);
    naSetLabelTextColor(view->errorLabel, &color);
    color[3] *= .15;
    naSetSpaceBackgroundColor(view->space, &color);
  }
}



const double* matGetViewValues(const MATView* view){
  return view->values;
}

void matSetViewValues(MATView* view, const double* values){
  size_t valuesByteSize = view->dimensions[0] * view->dimensions[1] * sizeof(double);
  naCopyn(view->values, values, valuesByteSize);
}




const NASpace* matGetViewSpace(const MATView* view){
  return view->space;
}
