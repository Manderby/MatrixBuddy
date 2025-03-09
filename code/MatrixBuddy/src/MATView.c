#include "MATApplication.h"

#include "MATView.h"
#include "NAMath/NAVectorAlgebra.h"
#include "ComputationControllers/MATBaseController.h"
#include "NAStruct/NABuffer.h"
#include "NAVisual/NAColor.h"
#include "MATPreferences.h"

struct MATView{
  void* con;
  MATStatus status;
  
  NASpace* space;
  NALabel* errorLabel;
  NALabel* label;
  NASpace* matrixSpace;
  NAButton* copyButton;
  NAButton* pasteButton;

  NAVec2s dimensions;
  NATextField** textFields;
  double* values;
};



size_t matGetViewElementCount(const MATView* view){
  return view->dimensions[0] * view->dimensions[1];
}



void mat_ViewChanged(NAReaction reaction){
  MATView* view = (MATView*)reaction.controller;

  NAString* text = naNewStringWithTextFieldText(reaction.uiElement);
  double value = atof(naGetStringUTF8Pointer(text));
  naDelete(text);
  
  
  for(size_t i = 0; i < matGetViewElementCount(view); ++i){
    if(reaction.uiElement == view->textFields[i]){
      view->values[i] = value;
    }
  }
  
  matNotifyControllerValuesChanged(view->con, view);
}



// Returns a temporary (automatically freed) utf8 string pointer.
NAUTF8Char* matFormatValue(double value){
  if(value > -1e-7 && value < 1e-7){value = 0.;}
  MATValueAccuracy valueAccuracy = matGetValueAccuracy();
  if(valueAccuracy == MAT_VALUE_ACCURACY_NATURAL){
    for(int digit = 0; digit < 10; digit++){
      float testValue = (float)value * naExp10f((float)digit);
      if(naRoundf(testValue) == testValue){
        NAUTF8Char* formatString = naAllocSprintf(NA_TRUE, "%%.%df", digit);
        return naAllocSprintf(NA_TRUE, formatString, value);
      }
    }
  }
  return naAllocSprintf(NA_TRUE, "%f", value);
}



void mat_ViewPressCopy(NAReaction reaction){
  MATView* view = (MATView*)reaction.controller;

  NABuffer* stringBuffer = naCreateBuffer(NA_FALSE);
  NABufferIterator bufferIt = naMakeBufferModifier(stringBuffer);
  
  if(view->dimensions[0] == 1 && view->dimensions[1] == 1){
    naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[0]));
  }else if(view->dimensions[0] == 1){
    switch(matGetCodeStyle()){
    case MAT_CODE_STYLE_C_ROW_FIRST_1D:
    case MAT_CODE_STYLE_C_ROW_FIRST_2D:
    case MAT_CODE_STYLE_C_COLUMN_FIRST_1D:
    case MAT_CODE_STYLE_C_COLUMN_FIRST_2D:
      naWriteBufferStringWithFormat(&bufferIt, "{");
      for(size_t y = 0; y < view->dimensions[1]; ++y){
        if(y > 0)
          naWriteBufferStringWithFormat(&bufferIt, ", ");
        naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[y]));
      }
      naWriteBufferStringWithFormat(&bufferIt, "}");
      break;
    case MAT_CODE_STYLE_MATHEMATICA:
      naWriteBufferStringWithFormat(&bufferIt, "{");
      for(size_t y = 0; y < view->dimensions[1]; ++y){
        if(y > 0)
          naWriteBufferStringWithFormat(&bufferIt, ", ");
        naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[y]));
      }
      naWriteBufferStringWithFormat(&bufferIt, "}");
      break;
    case MAT_CODE_STYLE_MATLAB:
      naWriteBufferStringWithFormat(&bufferIt, "[");
      for(size_t y = 0; y < view->dimensions[1]; ++y){
        if(y > 0)
          naWriteBufferStringWithFormat(&bufferIt, " ");
        naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[y]));
      }
      naWriteBufferStringWithFormat(&bufferIt, "]");
      break;
    case MAT_CODE_STYLE_MAPLE:
      naWriteBufferStringWithFormat(&bufferIt, "[");
      for(size_t y = 0; y < view->dimensions[1]; ++y){
        if(y > 0)
          naWriteBufferStringWithFormat(&bufferIt, ", ");
        naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[y]));
      }
      naWriteBufferStringWithFormat(&bufferIt, "]");
      break;
    default:
      break;
    }
  }else{
    switch(matGetCodeStyle()){
    case MAT_CODE_STYLE_C_ROW_FIRST_1D:
      naWriteBufferStringWithFormat(&bufferIt, "{");
      for(size_t y = 0; y < view->dimensions[1]; ++y){
        if(y > 0)
          naWriteBufferStringWithFormat(&bufferIt, ", ");
        for(size_t x = 0; x < view->dimensions[0]; ++x){
          size_t index = x * view->dimensions[1] + y;
          if(x > 0)
            naWriteBufferStringWithFormat(&bufferIt, ", ");
          naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[index]));
        }
      }
      naWriteBufferStringWithFormat(&bufferIt, "}");
      break;
    case MAT_CODE_STYLE_C_ROW_FIRST_2D:
      naWriteBufferStringWithFormat(&bufferIt, "{");
      for(size_t y = 0; y < view->dimensions[1]; ++y){
        if(y > 0)
          naWriteBufferStringWithFormat(&bufferIt, ", ");
        naWriteBufferStringWithFormat(&bufferIt, "{");
        for(size_t x = 0; x < view->dimensions[0]; ++x){
          size_t index = x * view->dimensions[1] + y;
          if(x > 0)
            naWriteBufferStringWithFormat(&bufferIt, ", ");
          naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[index]));
        }
        naWriteBufferStringWithFormat(&bufferIt, "}");
      }
      naWriteBufferStringWithFormat(&bufferIt, "}");
      break;
    case MAT_CODE_STYLE_C_COLUMN_FIRST_1D:
      naWriteBufferStringWithFormat(&bufferIt, "{");
      for(size_t x = 0; x < view->dimensions[0]; ++x){
        if(x > 0)
          naWriteBufferStringWithFormat(&bufferIt, ", ");
        for(size_t y = 0; y < view->dimensions[1]; ++y){
          size_t index = x * view->dimensions[1] + y;
          if(y > 0)
            naWriteBufferStringWithFormat(&bufferIt, ", ");
          naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[index]));
        }
      }
      naWriteBufferStringWithFormat(&bufferIt, "}");
      break;
    case MAT_CODE_STYLE_C_COLUMN_FIRST_2D:
      naWriteBufferStringWithFormat(&bufferIt, "{");
      for(size_t x = 0; x < view->dimensions[0]; ++x){
        if(x > 0)
          naWriteBufferStringWithFormat(&bufferIt, ", ");
        naWriteBufferStringWithFormat(&bufferIt, "{");
        for(size_t y = 0; y < view->dimensions[1]; ++y){
          size_t index = x * view->dimensions[1] + y;
          if(y > 0)
            naWriteBufferStringWithFormat(&bufferIt, ", ");
          naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[index]));
        }
        naWriteBufferStringWithFormat(&bufferIt, "}");
      }
      naWriteBufferStringWithFormat(&bufferIt, "}");
      break;
    case MAT_CODE_STYLE_MATHEMATICA:
      naWriteBufferStringWithFormat(&bufferIt, "{");
      for(size_t y = 0; y < view->dimensions[1]; ++y){
        if(y > 0)
          naWriteBufferStringWithFormat(&bufferIt, ", ");
        naWriteBufferStringWithFormat(&bufferIt, "{");
        for(size_t x = 0; x < view->dimensions[0]; ++x){
          size_t index = x * view->dimensions[1] + y;
          if(x > 0)
            naWriteBufferStringWithFormat(&bufferIt, ", ");
          naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[index]));
        }
        naWriteBufferStringWithFormat(&bufferIt, "}");
      }
      naWriteBufferStringWithFormat(&bufferIt, "}");
      break;
    case MAT_CODE_STYLE_MATLAB:
      naWriteBufferStringWithFormat(&bufferIt, "[");
      for(size_t y = 0; y < view->dimensions[1]; ++y){
        if(y > 0)
          naWriteBufferStringWithFormat(&bufferIt, "; ");
        for(size_t x = 0; x < view->dimensions[0]; ++x){
          size_t index = x * view->dimensions[1] + y;
          if(x > 0)
            naWriteBufferStringWithFormat(&bufferIt, " ");
          naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[index]));
        }
      }
      naWriteBufferStringWithFormat(&bufferIt, "]");
      break;
    case MAT_CODE_STYLE_MAPLE:
      naWriteBufferStringWithFormat(&bufferIt, "[");
      for(size_t y = 0; y < view->dimensions[1]; ++y){
        if(y > 0)
          naWriteBufferStringWithFormat(&bufferIt, ", ");
        naWriteBufferStringWithFormat(&bufferIt, "[");
        for(size_t x = 0; x < view->dimensions[0]; ++x){
          size_t index = x * view->dimensions[1] + y;
          if(x > 0)
            naWriteBufferStringWithFormat(&bufferIt, ", ");
          naWriteBufferStringWithFormat(&bufferIt, matFormatValue(view->values[index]));
        }
        naWriteBufferStringWithFormat(&bufferIt, "]");
      }
      naWriteBufferStringWithFormat(&bufferIt, "]");
      break;
    default:
      break;
    }
  }

  NAString* pasteBoardString = naNewStringWithBufferExtraction(
    stringBuffer,
    naGetBufferRange(stringBuffer));

  naPutStringToClipboard(pasteBoardString);

  naDelete(pasteBoardString);
  
  naClearBufferIterator(&bufferIt);
  naRelease(stringBuffer);
}



void mat_ViewPressPaste(NAReaction reaction){
  MATView* view = (MATView*)reaction.controller;

  NAString* string = naNewStringFromClipboard();
  if(!string) { return; }

  const char* codeStr = naGetStringUTF8Pointer(string);

  // Strip the first whitespaces and find out if there is a curly bracket. If
  // so, we assume, this is a C code string and will treat the ordering
  // according to the setting.
  NABool mightBeCEncoding = NA_FALSE;
  while(*codeStr && (*codeStr <= ' ')){codeStr++;}
  if(*codeStr == '{'){
    mightBeCEncoding = NA_TRUE;
    codeStr++;
  }

  size_t elementCount = matGetViewElementCount(view);
  double* newValues = naMalloc(elementCount * sizeof(double));
  naZeron(newValues, elementCount * sizeof(double));
  
  char* newEndPtr;
  int curValue = 0;
  while(1){
    if(curValue == elementCount){break;}
    if(*codeStr == '\0'){break;}
    newValues[curValue] = strtod(codeStr, &newEndPtr);

    if(newEndPtr == codeStr){
      // No conversion found.
      codeStr++;
    }else{
      codeStr = newEndPtr;
      curValue++;
    }
  }
  
  if(view->dimensions[0] == view->dimensions[1] && view->dimensions[0] != 1){
    MATCodeStyle codeStyle = matGetCodeStyle();
    if(mightBeCEncoding && ((codeStyle == MAT_CODE_STYLE_C_COLUMN_FIRST_1D) || (codeStyle == MAT_CODE_STYLE_C_COLUMN_FIRST_2D))){
      // The values are expected colum first. And as NALib matrices are stored
      // column first, we do nothing.
    }else{
      // We transform the values to column first ordering.
      switch(view->dimensions[1]){
        case 2: naTransposeM22dS(newValues); break;
        case 3: naTransposeM33dS(newValues); break;
        case 4: naTransposeM44dS(newValues); break;
      }
    }
  }
  
  matSetViewValues(view, newValues);
  matUpdateView(view);
  matNotifyControllerValuesChanged(view->con, view);

  naDelete(string);
  naFree(newValues);
}



MATView* matAllocView(
  const NAUTF8Char* label,
  NAInt dimensionX,
  NAInt dimensionY,
  void* con,
  const double* initValues)
{
  MATView* view = naAlloc(MATView);

  view->dimensions[0] = dimensionX;
  view->dimensions[1] = dimensionY;

  view->con = con;
  view->status = MAT_STATUS_NORMAL;

  size_t maxDimensions = matGetControllerDimensions(view->con);
  double maxMatrixHeight = maxDimensions * MAT_TEXTFIELD_HEIGHT + (maxDimensions - 1) * MAT_TEXTFIELD_SPACE_V;

  double matrixSize[2] = {
    view->dimensions[0] * MAT_TEXTFIELD_WIDTH + (view->dimensions[0] - 1) * MAT_TEXTFIELD_SPACE_H,
    view->dimensions[1] * MAT_TEXTFIELD_HEIGHT + (view->dimensions[1] - 1) * MAT_TEXTFIELD_SPACE_V};

  NASize viewSize = {
    matrixSize[0] + MAT_MATRIX_MARGIN_LEFT + MAT_MATRIX_MARGIN_RIGHT,
    MAT_MATRIX_LABEL_HEIGHT + MAT_MATRIX_MARGIN_TOP + maxMatrixHeight + MAT_MATRIX_MARGIN_BOTTOM + 2 * MAT_VIEW_MARGIN_V + MAT_MATRIX_DISTANCE_VTOP + MAT_MATRIX_DISTANCE_VBOTTOM + MAT_COPYPASTE_BUTTON_SIZE};

  view->space = naNewSpace(viewSize);
   
  view->errorLabel = naNewLabel("", viewSize.width);
  naSetLabelTextAlignment(view->errorLabel, NA_TEXT_ALIGNMENT_CENTER);
  naAddSpaceChild(view->space, view->errorLabel, naMakePos(0, viewSize.height - MAT_MATRIX_LABEL_HEIGHT - MAT_VIEW_MARGIN_V + MAT_ERROR_LABEL_SHIFT_Y));

  view->label = naNewLabel(label, viewSize.width);
  naSetLabelFont(view->label, matGetMathFont());
  naSetLabelTextAlignment(view->label, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelHeight(view->label, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(view->space, view->label, naMakePos(0, viewSize.height - MAT_MATRIX_LABEL_HEIGHT - MAT_VIEW_MARGIN_V));

  view->matrixSpace = naNewSpace(naMakeSize(
    matrixSize[0] + MAT_MATRIX_MARGIN_LEFT + MAT_MATRIX_MARGIN_RIGHT,
    matrixSize[1] + MAT_MATRIX_MARGIN_TOP + MAT_MATRIX_MARGIN_BOTTOM));
  
  size_t textFieldsByteSize = matGetViewElementCount(view)* sizeof(NATextField*);
  view->textFields = naMalloc(textFieldsByteSize);
  for(size_t x = 0; x < view->dimensions[0]; ++x){
    for(size_t y = 0; y < view->dimensions[1]; ++y){
      size_t index = x * view->dimensions[1] + y;
      view->textFields[index] = naNewTextField(MAT_TEXTFIELD_WIDTH);

      #if NA_OS == NA_OS_MAC_OS_X
        matSetTextFieldCellProperties(view->textFields[index]);
      #endif

      naAddSpaceChild(
        view->matrixSpace,
        view->textFields[index],
        naMakePos(
          MAT_MATRIX_MARGIN_LEFT + x * (MAT_TEXTFIELD_WIDTH + MAT_TEXTFIELD_SPACE_H),
          MAT_MATRIX_MARGIN_BOTTOM + matrixSize[1] - (y + 1) * (MAT_TEXTFIELD_HEIGHT + MAT_TEXTFIELD_SPACE_V) + MAT_TEXTFIELD_SPACE_V));
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
  
  view->copyButton = naNewImagePushButton(matGetCopyImageSet(), naMakeSize(MAT_COPYPASTE_BUTTON_SIZE, MAT_COPYPASTE_BUTTON_SIZE));
  naAddUIReaction(view->copyButton, NA_UI_COMMAND_PRESSED, mat_ViewPressCopy, view);
  naAddSpaceChild(view->space, view->copyButton, naMakePos(buttonsCenterMarginLeft, MAT_VIEW_MARGIN_V));

  view->pasteButton = naNewImagePushButton(matGetPasteImageSet(), naMakeSize(MAT_COPYPASTE_BUTTON_SIZE, MAT_COPYPASTE_BUTTON_SIZE));
  naAddUIReaction(view->pasteButton, NA_UI_COMMAND_PRESSED, mat_ViewPressPaste, view);
  naAddSpaceChild(view->space, view->pasteButton, naMakePos(buttonsCenterMarginLeft + MAT_COPYPASTE_BUTTON_SIZE + MAT_COPYPASTE_BUTTON_DISTANCE, MAT_VIEW_MARGIN_V));

  // business values:
  size_t valuesByteSize = matGetViewElementCount(view) * sizeof(double);
  view->values = naMalloc(valuesByteSize);
  naCopyn(view->values, initValues, valuesByteSize);

  matUpdateViewTabOrder(view);

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

  naSetLabelText(view->errorLabel, matGetUTF8StringWithStatus(view->status));

  for(size_t x = 0; x < view->dimensions[0]; ++x){
    for(size_t y = 0; y < view->dimensions[1]; ++y){
      size_t index = x * view->dimensions[1] + y;
      NAUTF8Char* valueString = matFormatValue(view->values[index]);
      naSetTextFieldText(view->textFields[index], valueString);
    }
  }
  
  MATColor matColor = matGetColorWithStatus(view->status);
  NABool isNormal = matColor == MAT_COLOR_NORMAL;
  NABool isError = !(isNormal || matColor == MAT_COLOR_RESULT);

  naSetLabelVisible(view->label, !isError && matGetShowIdentifiers());
  naSetLabelVisible(view->errorLabel, isError);

  NABool showCopyPaste = matGetShowCopyPaste();
  naSetButtonVisible(view->copyButton, showCopyPaste);
  naSetButtonVisible(view->pasteButton, showCopyPaste);

  if(isNormal){
    naSetLabelTextColor(view->label, NA_NULL);
    naSetLabelTextColor(view->errorLabel, NA_NULL);
    naSetSpaceBackgroundColor(view->matrixSpace, NA_NULL);
  }else{
    NAColor naColor;
    matFillColor(&naColor, matColor);
    naSetLabelTextColor(view->label, &naColor);
    naSetLabelTextColor(view->errorLabel, &naColor);
    naColor.alpha *= .15f;
    naSetSpaceBackgroundColor(view->matrixSpace, &naColor);
  }
}


void matUpdateViewTabOrder(MATView* view){
  size_t elementCount = matGetViewElementCount(view);
  for(size_t x = 0; x < view->dimensions[0]; ++x){
    for(size_t y = 0; y < view->dimensions[1]; ++y){
      size_t index = x * view->dimensions[1] + y;
      size_t nextIndex;
      
      if(matGetUseRowFirstTabOrder()){
        if(index == elementCount - 1){
          nextIndex = 0;
        }else{
          nextIndex = index + view->dimensions[0];
          if(index / view->dimensions[1] == view->dimensions[1] - 1)
            nextIndex += 1;
        }
      }else{
        nextIndex = index + 1;
      }
      naSetUIElementNextTabElement(view->textFields[index], view->textFields[nextIndex % elementCount]);
    }
  }
}



const double* matGetViewValues(const MATView* view){
  return view->values;
}



void matSetViewValues(MATView* view, const double* values){
  size_t valuesByteSize = matGetViewElementCount(view) * sizeof(double);
  naCopyn(view->values, values, valuesByteSize);
}



NASpace* matGetViewSpace(const MATView* view){
  return view->space;
}



void matSetViewPasteEnabled(MATView* view, NABool enabled){
  naSetButtonEnabled(view->pasteButton, enabled);
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
