#include "../MATApplication.h"
#include "MATBaseController.h"
#include "../MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATVMulSController MATVMulSController;
struct MATVMulSController{
  MATBaseController base;
  MATView* viewA;
  NALabel* mulSignLabel;
  MATView* viewS;
  NALabel* equalSignLabel;
  MATView* viewB;
};



void matUpdateVMulSController(MATBaseController* controller){
  MATVMulSController* con = (MATVMulSController*)controller;

  matSetViewPasteEnabled(con->viewB, NA_FALSE);

  matUpdateView(con->viewA);
  matUpdateView(con->viewS);
  matUpdateView(con->viewB);
}



void matUpdateVMulSControllerTabOrder(MATBaseController* controller){
  MATVMulSController* con = (MATVMulSController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewS);
  matUpdateViewTabOrder(con->viewB);
}



void matVMulSValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATVMulSController* con = (MATVMulSController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesS = matGetViewValues(con->viewS);

  size_t elementCount = matGetViewElementCount(con->viewB);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  switch(con->base.dimensions){
  case 2: naMulV2d(result, valuesA, *valuesS); break;
  case 3: naMulV3d(result, valuesA, *valuesS); break;
  case 4: naMulV4d(result, valuesA, *valuesS); break;
  }
  
  matSetViewValues(con->viewB, result);
  matUpdateVMulSController(&con->base);
  naFree(result);
}



MATBaseController* matAllocVMulSController(size_t dimensions){
  MATVMulSController* con = naAlloc(MATVMulSController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpVMulS,
    matVMulSValueChanged,
    matUpdateVMulSController,
    matUpdateVMulSControllerTabOrder);
  
  double* initVector = naMalloc(dimensions * sizeof(double));
  naZeron(initVector, dimensions * sizeof(double));
  double initScalar[] = {1.};

  con->viewA = matAllocView("a", 1, dimensions, con, initVector);
  con->viewS = matAllocView("s", 1, 1, con, initScalar);
  con->viewB = matAllocView("b", 1, dimensions, con, initVector);

  naFree(initVector);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceS = matGetViewSpace(con->viewS);
  NASpace* spaceB = matGetViewSpace(con->viewB);
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize sizeS = naGetUIElementRect(spaceS).size;
  NASize sizeB = naGetUIElementRect(spaceB).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeA.width + MAT_SIGN_WIDTH + sizeS.width + MAT_SIGN_WIDTH + sizeB.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeA.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2. + MAT_SIGN_LABEL_SHIFT_Y); 
  
  naAddSpaceChild(con->base.space, spaceA, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceS, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, marginBottom));
  naAddSpaceChild(con->base.space, spaceB, naMakePos(marginLeft + sizeA.width + sizeS.width + 2 * MAT_SIGN_WIDTH, marginBottom));

  con->mulSignLabel = naNewLabel(MAT_MUL_SIGN, MAT_SIGN_WIDTH);
  //con->mulSignLabel = naNewLabel(MAT_MUL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->mulSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->mulSignLabel, matGetMathFont());
  naSetLabelHeight(con->mulSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->mulSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MAT_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeS.width + MAT_SIGN_WIDTH, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewS, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_RESULT);

  matUpdateVMulSController(&con->base);

  return &con->base;
}



void matDeallocVMulSController(MATBaseController* controller){
  MATVMulSController* con = (MATVMulSController*)controller;
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
