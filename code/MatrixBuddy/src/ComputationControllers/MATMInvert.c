#include "../MATApplication.h"
#include "MATBaseController.h"
#include "../MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATMInvertController MATMInvertController;
struct MATMInvertController{
  MATBaseController base;
  MATView* viewA;
  NALabel* arrowSignLabel;
  MATView* viewI;
};



void matUpdateMInvertController(MATBaseController* controller){
  MATMInvertController* con = (MATMInvertController*)controller;
  matUpdateView(con->viewA);
  matUpdateView(con->viewI);
}



void matUpdateMInvertControllerTabOrder(MATBaseController* controller){
  MATMInvertController* con = (MATMInvertController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewI);
}



void matMInvertValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATMInvertController* con = (MATMInvertController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesI = matGetViewValues(con->viewI);

  size_t elementCount = matGetViewElementCount(con->viewI);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  MATStatus newStatusA;
  MATStatus newStatusI;
  if(view == con->viewA){
    newStatusI = MAT_STATUS_RESULT;
    double det = 0.;
    switch(con->base.dimensions){
    case 2: det = naDetM22d(valuesA); break;
    case 3: det = naDetM33d(valuesA); break;
    case 4: det = naDetM44d(valuesA); break;
    }
    if(det == 0.){
      newStatusA = MAT_STATUS_MATRIX_DETERMINANT_ZERO;
    }else{
      newStatusA = naAlmostZerof((float)det)
        ? MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO
        : MAT_STATUS_NORMAL;
      switch(con->base.dimensions){
      case 2: naInvM22d(result, valuesA); break;
      case 3: naInvM33d(result, valuesA); break;
      case 4: naInvM44d(result, valuesA); break;
      }
    }
    matSetViewValues(con->viewI, result);
  }else{
    newStatusA = MAT_STATUS_RESULT;
    double det = 0.;
    switch(con->base.dimensions){
    case 2: det = naDetM22d(valuesI); break;
    case 3: det = naDetM33d(valuesI); break;
    case 4: det = naDetM44d(valuesI); break;
    }
    if(det == 0.){
      newStatusI = MAT_STATUS_MATRIX_DETERMINANT_ZERO;
    }else{
      newStatusI = naAlmostZerof((float)det)
        ? MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO
        : MAT_STATUS_NORMAL;
      switch(con->base.dimensions){
      case 2: naInvM22d(result, valuesI); break;
      case 3: naInvM33d(result, valuesI); break;
      case 4: naInvM44d(result, valuesI); break;
      }
    }
    matSetViewValues(con->viewA, result);
  }
  matSetViewStatus(con->viewA, newStatusA);
  matSetViewStatus(con->viewI, newStatusI);

  matUpdateMInvertController(&con->base);
  naFree(result);
}



MATBaseController* matAllocMInvertController(size_t dimensions){
  MATMInvertController* con = naAlloc(MATMInvertController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMInvert,
    matMInvertValueChanged,
    matUpdateMInvertController,
    matUpdateMInvertControllerTabOrder);
  
  size_t matrixElementCount = dimensions * dimensions;
  double* initMatrix = naMalloc(matrixElementCount * sizeof(double));
  naZeron(initMatrix, matrixElementCount * sizeof(double));

  switch(con->base.dimensions){
  case 2:
    naFillM22dWithDiag(initMatrix, 1);
    break;
  case 3:
    naFillM33dWithDiag(initMatrix, 1);
    break;
  case 4:
    naFillM44dWithDiag(initMatrix, 1);
    break;
  }

  con->viewA = matAllocView("A", dimensions, dimensions, con, initMatrix);
  con->viewI = matAllocView(u8"A" MAT_SUPERSCRIPT_MINUS_ONE, dimensions, dimensions, con, initMatrix);

  naFree(initMatrix);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceI = matGetViewSpace(con->viewI);
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize sizeI = naGetUIElementRect(spaceI).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeA.width + MAT_SIGN_WIDTH + sizeI.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeA.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2. + MAT_SIGN_LABEL_SHIFT_Y); 
  
  naAddSpaceChild(con->base.space, spaceA, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceI, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, marginBottom));

  con->arrowSignLabel = naNewLabel(MAT_DOUBLE_ARROW_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->arrowSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->arrowSignLabel, matGetMathFont());
  naSetLabelHeight(con->arrowSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->arrowSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewI, MAT_STATUS_RESULT);

  matUpdateMInvertController(&con->base);

  return &con->base;
}



void matDeallocMInvertController(MATBaseController* controller){
  matClearBaseController(controller);
  naFree(controller);
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
