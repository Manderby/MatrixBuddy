
#include "MATView.h"
#include "NAMath/NAVectorAlgebra.h"

struct MATView{
  MATValueChangedHandler handler;
  void* con;
  MATStatus status;
  
  NASpace* space;
  NALabel* errorLabel;
  NALabel* label;
  NASpace* matrixSpace;
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

  size_t maxDimensions = matGetDimensionsInteger(matGetControllerDimensions(view->con));
  double maxMatrixHeight = maxDimensions * MAT_TEXTFIELD_HEIGHT + (maxDimensions - 1) * MAT_TEXTFIELD_SPACE_VASDF;

  double matrixSize[2] = {
    view->dimensions[0] * MAT_TEXTFIELD_WIDTHASDF + (view->dimensions[0] - 1) * MAT_TEXTFIELD_SPACE_HASDF,
    view->dimensions[1] * MAT_TEXTFIELD_HEIGHT + (view->dimensions[1] - 1) * MAT_TEXTFIELD_SPACE_VASDF};

  NASize viewSize = {
    matrixSize[0] + MAT_MATRIX_MARGIN_LEFT + MAT_MATRIX_MARGIN_RIGHT,
    MAT_MATRIX_LABEL_HEIGHT + MAT_MATRIX_MARGIN_TOP + maxMatrixHeight + MAT_MATRIX_MARGIN_BOTTOM + 2 * MAT_VIEW_MARGIN_V + MAT_MATRIX_DISTANCE_VTOP + MAT_MATRIX_DISTANCE_VBOTTOM + MAT_COPYPASTE_BUTTON_SIZE};

  view->space = naNewSpace(viewSize);
   
  view->errorLabel = naNewLabel("Error", viewSize.width);
  naSetLabelTextAlignment(view->errorLabel, NA_TEXT_ALIGNMENT_CENTER);
  naAddSpaceChild(view->space, view->errorLabel, naMakePos(0, viewSize.height - MAT_MATRIX_LABEL_HEIGHT - MAT_VIEW_MARGIN_V));

  // "s\u207b\u00b9\u1d40"
  view->label = naNewLabel(label, viewSize.width);
  naSetLabelFont(view->label, matGetMathFont());
  naSetLabelTextAlignment(view->label, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelHeight(view->label, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(view->space, view->label, naMakePos(0, viewSize.height - MAT_MATRIX_LABEL_HEIGHT - MAT_VIEW_MARGIN_V));
    
  view->matrixSpace = naNewSpace(naMakeSize(
    matrixSize[0] + MAT_MATRIX_MARGIN_LEFT + MAT_MATRIX_MARGIN_RIGHT,
    matrixSize[1] + MAT_MATRIX_MARGIN_TOP + MAT_MATRIX_MARGIN_BOTTOM));
  
  size_t textFieldsByteSize = view->dimensions[0] * view->dimensions[1] * sizeof(NATextField*);
  view->textFields = naMalloc(textFieldsByteSize);
  for(size_t x = 0; x < view->dimensions[0]; ++x){
    for(size_t y = 0; y < view->dimensions[1]; ++y){
      size_t index = x * view->dimensions[1] + y;
      view->textFields[index] = naNewTextField(MAT_TEXTFIELD_WIDTHASDF);
      matSetTextFieldCellProperties(view->textFields[index]);
      naAddSpaceChild(
        view->matrixSpace,
        view->textFields[index],
        naMakePos(
          MAT_MATRIX_MARGIN_LEFT + x * (MAT_TEXTFIELD_WIDTHASDF + MAT_TEXTFIELD_SPACE_HASDF),
          MAT_MATRIX_MARGIN_BOTTOM + matrixSize[1] - (y + 1) * (MAT_TEXTFIELD_HEIGHT + MAT_TEXTFIELD_SPACE_VASDF) + MAT_TEXTFIELD_SPACE_VASDF));
      naAddUIReaction(
        view->textFields[index],
        NA_UI_COMMAND_EDIT_FINISHED,
        mat_ViewChanged,
        view);
    }
  }

  double matrixCenterMarginBottom = naRound((maxMatrixHeight - matrixSize[1]) / 2.);
  naAddSpaceChild(view->space, view->matrixSpace, naMakePos(
    0,
    MAT_VIEW_MARGIN_V + MAT_COPYPASTE_BUTTON_SIZE + MAT_MATRIX_DISTANCE_VBOTTOM + matrixCenterMarginBottom));

  double buttonsCenterMarginLeft = naRound((viewSize.width - (2 * MAT_COPYPASTE_BUTTON_SIZE + MAT_COPYPASTE_BUTTON_DISTANCE)) / 2.);
  
  view->copyButton = naNewImagePushButton(matGetCopyImage(), naMakeSize(MAT_COPYPASTE_BUTTON_SIZE, MAT_COPYPASTE_BUTTON_SIZE));
  naAddUIReaction(view->copyButton, NA_UI_COMMAND_PRESSED, mat_ViewPressCopy, view);
  naAddSpaceChild(view->space, view->copyButton, naMakePos(buttonsCenterMarginLeft, MAT_VIEW_MARGIN_V));

  view->pasteButton = naNewImagePushButton(matGetPasteImage(), naMakeSize(MAT_COPYPASTE_BUTTON_SIZE, MAT_COPYPASTE_BUTTON_SIZE));
  naAddUIReaction(view->pasteButton, NA_UI_COMMAND_PRESSED, mat_ViewPressPaste, view);
  naAddSpaceChild(view->space, view->pasteButton, naMakePos(buttonsCenterMarginLeft + MAT_COPYPASTE_BUTTON_SIZE + MAT_COPYPASTE_BUTTON_DISTANCE, MAT_VIEW_MARGIN_V));

  // business values:
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
    naSetSpaceBackgroundColor(view->matrixSpace, NA_NULL);
  }else{
    NABabyColor color;
    matFillBabyColor(&color, matColor);
    naSetLabelTextColor(view->label, &color);
    naSetLabelTextColor(view->errorLabel, &color);
    color[3] *= .1;
    naSetSpaceBackgroundColor(view->matrixSpace, &color);
  }
}



const double* matGetViewValues(const MATView* view){
  return view->values;
}

void matSetViewValues(MATView* view, const double* values){
  size_t valuesByteSize = view->dimensions[0] * view->dimensions[1] * sizeof(double);
  naCopyn(view->values, values, valuesByteSize);
}




NASpace* matGetViewSpace(const MATView* view){
  return view->space;
}
