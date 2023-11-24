#include "../MATApplication.h"
#include "MATBaseController.h"
#include "../MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATMMulVController MATMMulVController;
struct MATMMulVController{
  MATBaseController base;
  MATView* viewA;
  NALabel* mulSignLabel;
  MATView* viewX;
  NALabel* equalSignLabel;
  MATView* viewB;
};



void matUpdateMMulVController(MATBaseController* controller){
  MATMMulVController* con = (MATMMulVController*)controller;
  matUpdateView(con->viewA);
  matUpdateView(con->viewX);
  matUpdateView(con->viewB);
}



void matUpdateMMulVControllerTabOrder(MATBaseController* controller){
  MATMMulVController* con = (MATMMulVController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewX);
  matUpdateViewTabOrder(con->viewB);
}



void matMMulVValueChanged(MATBaseController* controller, MATView* view){
  MATMMulVController* con = (MATMMulVController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesX = matGetViewValues(con->viewX);
  const double* valuesB = matGetViewValues(con->viewB);

  size_t elementCountMatrix = matGetViewElementCount(con->viewA);
  size_t elementCountVector = matGetViewElementCount(con->viewB);
  double* result = naMalloc(elementCountVector * sizeof(double));
  naZeron(result, elementCountVector * sizeof(double));

  MATStatus newStatusA = MAT_STATUS_NORMAL;
  MATStatus newStatusX;
  MATStatus newStatusB;
  if(view == con->viewB){
    newStatusX = MAT_STATUS_RESULT;
    newStatusB = MAT_STATUS_NORMAL;
    double det = 0.;
    switch(con->base.dimensions){
    case 2: det = naDetM22d(valuesA); break;
    case 3: det = naDetM33d(valuesA); break;
    case 4: det = naDetM44d(valuesA); break;
    }
    if(det == 0.){
      newStatusA = MAT_STATUS_MATRIX_DETERMINANT_ZERO;
    }else{
      newStatusA = naAlmostZerof(det)
        ? MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO
        : MAT_STATUS_NORMAL;
      double* inverse = naMalloc(elementCountMatrix * sizeof(double));
      switch(con->base.dimensions){
      case 2: naInvM22d(inverse, valuesA); naMulM22dV2d(result, inverse, valuesB); break;
      case 3: naInvM33d(inverse, valuesA); naMulM33dV3d(result, inverse, valuesB); break;
      case 4: naInvM44d(inverse, valuesA); naMulM44dV4d(result, inverse, valuesB); break;
      }
      naFree(inverse);
    }
    matSetViewValues(con->viewX, result);

  }else{
    newStatusX = MAT_STATUS_NORMAL;
    newStatusB = MAT_STATUS_RESULT;
    switch(con->base.dimensions){
    case 2: naMulM22dV2d(result, valuesA, valuesX); break;
    case 3: naMulM33dV3d(result, valuesA, valuesX); break;
    case 4: naMulM44dV4d(result, valuesA, valuesX); break;
    }
    matSetViewValues(con->viewB, result);
  }
  matSetViewStatus(con->viewA, newStatusA);
  matSetViewStatus(con->viewX, newStatusX);
  matSetViewStatus(con->viewB, newStatusB);

  matUpdateMMulVController(&con->base);
  naFree(result);
}



MATBaseController* matAllocMMulVController(size_t dimensions){
  MATMMulVController* con = naAlloc(MATMMulVController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMMulV,
    matMMulVValueChanged,
    matUpdateMMulVController,
    matUpdateMMulVControllerTabOrder);
  
  size_t matrixElementCount = dimensions * dimensions;
  double* initMatrix = naMalloc(matrixElementCount * sizeof(double));
  naZeron(initMatrix, matrixElementCount * sizeof(double));
  double* initVector = naMalloc(dimensions * sizeof(double));
  naZeron(initVector, dimensions * sizeof(double));

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
  con->viewX = matAllocView("x", 1, dimensions, con, initVector);
  con->viewB = matAllocView("b", 1, dimensions, con, initVector);

  naFree(initMatrix);
  naFree(initVector);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceX = matGetViewSpace(con->viewX);
  NASpace* spaceB = matGetViewSpace(con->viewB);
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize sizeX = naGetUIElementRect(spaceX).size;
  NASize sizeB = naGetUIElementRect(spaceB).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeA.width + MAT_SIGN_WIDTH + sizeX.width + MAT_SIGN_WIDTH + sizeB.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeA.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2. + MAT_SIGN_LABEL_SHIFT_Y); 
  
  naAddSpaceChild(con->base.space, spaceA, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceX, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, marginBottom));
  naAddSpaceChild(con->base.space, spaceB, naMakePos(marginLeft + sizeA.width + sizeX.width + 2 * MAT_SIGN_WIDTH, marginBottom));

  con->mulSignLabel = naNewLabel(MAT_MUL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->mulSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->mulSignLabel, matGetMathFont());
  naSetLabelHeight(con->mulSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->mulSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MAT_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeX.width + MAT_SIGN_WIDTH, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewX, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_RESULT);

  matUpdateMMulVController(&con->base);

  return &con->base;
}



void matDeallocMMulVController(MATBaseController* controller){
  MATMMulVController* con = (MATMMulVController*)controller;
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
