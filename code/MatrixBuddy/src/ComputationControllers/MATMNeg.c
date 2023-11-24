#include "../MATApplication.h"
#include "MATBaseController.h"
#include "../MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATMNegController MATMNegController;
struct MATMNegController{
  MATBaseController base;
  MATView* viewA;
  NALabel* arrowSignLabel;
  MATView* viewN;
};



void matUpdateMNegController(MATBaseController* controller){
  MATMNegController* con = (MATMNegController*)controller;
  matUpdateView(con->viewA);
  matUpdateView(con->viewN);
}



void matUpdateMNegControllerTabOrder(MATBaseController* controller){
  MATMNegController* con = (MATMNegController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewN);
}



void matMNegValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATMNegController* con = (MATMNegController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesN = matGetViewValues(con->viewN);

  size_t elementCount = matGetViewElementCount(con->viewN);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  if(view == con->viewA){
    switch(con->base.dimensions){
    case 2: naNegM22d(result, valuesA); break;
    case 3: naNegM33d(result, valuesA); break;
    case 4: naNegM44d(result, valuesA); break;
    }
    matSetViewValues(con->viewN, result);
    matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
    matSetViewStatus(con->viewN, MAT_STATUS_RESULT);
  }else{
    switch(con->base.dimensions){
    case 2: naNegM22d(result, valuesN); break;
    case 3: naNegM33d(result, valuesN); break;
    case 4: naNegM44d(result, valuesN); break;
    }
    matSetViewValues(con->viewA, result);
    matSetViewStatus(con->viewA, MAT_STATUS_RESULT);
    matSetViewStatus(con->viewN, MAT_STATUS_NORMAL);
  }

  matUpdateMNegController(&con->base);
  naFree(result);
}



MATBaseController* matAllocMNegController(size_t dimensions){
  MATMNegController* con = naAlloc(MATMNegController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMNeg,
    matMNegValueChanged,
    matUpdateMNegController,
    matUpdateMNegControllerTabOrder);
  
  size_t matrixElementCount = dimensions * dimensions;
  double* initMatrix = naMalloc(matrixElementCount * sizeof(double));
  naZeron(initMatrix, matrixElementCount * sizeof(double));

  con->viewA = matAllocView("A", dimensions, dimensions, con, initMatrix);
  con->viewN = matAllocView(MAT_SUB_SIGN "A", dimensions, dimensions, con, initMatrix);

  naFree(initMatrix);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceN = matGetViewSpace(con->viewN);
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize sizeN = naGetUIElementRect(spaceN).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeA.width + MAT_SIGN_WIDTH + sizeN.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeA.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2. + MAT_SIGN_LABEL_SHIFT_Y); 
  
  naAddSpaceChild(con->base.space, spaceA, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceN, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, marginBottom));

  con->arrowSignLabel = naNewLabel(MAT_DOUBLE_ARROW_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->arrowSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->arrowSignLabel, matGetMathFont());
  naSetLabelHeight(con->arrowSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->arrowSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewN, MAT_STATUS_RESULT);

  matUpdateMNegController(&con->base);

  return &con->base;
}



void matDeallocMNegController(MATBaseController* controller){
  MATMNegController* con = (MATMNegController*)controller;
  NA_UNUSED(con);
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
