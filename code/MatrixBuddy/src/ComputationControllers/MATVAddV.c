#include "MATApplication.h"
#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATVAddVController MATVAddVController;
struct MATVAddVController{
  MATBaseController base;
  MATView* viewA;
  NALabel* addSignLabel;
  MATView* viewB;
  NALabel* equalSignLabel;
  MATView* viewC;
};



void matUpdateVAddVController(MATBaseController* controller){
  MATVAddVController* con = (MATVAddVController*)controller;
  matUpdateView(con->viewA);
  matUpdateView(con->viewB);
  matUpdateView(con->viewC);
}



void matUpdateVAddVControllerTabOrder(MATBaseController* controller){
  MATVAddVController* con = (MATVAddVController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewB);
  matUpdateViewTabOrder(con->viewC);
}



void matVAddVValueChanged(MATBaseController* controller, MATView* view){
  MATVAddVController* con = (MATVAddVController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesB = matGetViewValues(con->viewB);
  const double* valuesC = matGetViewValues(con->viewC);

  size_t elementCount = matGetViewElementCount(con->viewC);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  if(view == con->viewC){
    switch(con->base.dimensions){
    case 2: naSubV2d(result, valuesC, valuesA); break;
    case 3: naSubV3d(result, valuesC, valuesA); break;
    case 4: naSubV4d(result, valuesC, valuesA); break;
    }
    matSetViewValues(con->viewB, result);
    matSetViewStatus(con->viewB, MAT_STATUS_RESULT);
    matSetViewStatus(con->viewC, MAT_STATUS_NORMAL);
  }else{
    switch(con->base.dimensions){
    case 2: naAddV2d(result, valuesA, valuesB); break;
    case 3: naAddV3d(result, valuesA, valuesB); break;
    case 4: naAddV4d(result, valuesA, valuesB); break;
    }
    matSetViewValues(con->viewC, result);
    matSetViewStatus(con->viewB, MAT_STATUS_NORMAL);
    matSetViewStatus(con->viewC, MAT_STATUS_RESULT);
  }

  matUpdateVAddVController(&con->base);
  naFree(result);
}



MATBaseController* matAllocVAddVController(size_t dimensions){
  MATVAddVController* con = naAlloc(MATVAddVController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpVAddV,
    matVAddVValueChanged,
    matUpdateVAddVController,
    matUpdateVAddVControllerTabOrder);
  
  size_t matrixElementCount = dimensions * dimensions;
  double* initMatrix = naMalloc(matrixElementCount * sizeof(double));
  naZeron(initMatrix, matrixElementCount * sizeof(double));

  con->viewA = matAllocView("a", 1, dimensions, con, initMatrix);
  con->viewB = matAllocView("b", 1, dimensions, con, initMatrix);
  con->viewC = matAllocView("c", 1, dimensions, con, initMatrix);

  naFree(initMatrix);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceB = matGetViewSpace(con->viewB);
  NASpace* spaceC = matGetViewSpace(con->viewC);
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize sizeB = naGetUIElementRect(spaceB).size;
  NASize sizeC = naGetUIElementRect(spaceC).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeA.width + MAT_SIGN_WIDTH + sizeB.width + MAT_SIGN_WIDTH + sizeC.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeA.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2. + MAT_SIGN_LABEL_SHIFT_Y); 
  
  naAddSpaceChild(con->base.space, spaceA, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceB, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, marginBottom));
  naAddSpaceChild(con->base.space, spaceC, naMakePos(marginLeft + sizeA.width + sizeB.width + 2 * MAT_SIGN_WIDTH, marginBottom));

  con->addSignLabel = naNewLabel(MAT_ADD_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->addSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->addSignLabel, matGetMathFont());
  naSetLabelHeight(con->addSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->addSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MAT_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeB.width + MAT_SIGN_WIDTH, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewC, MAT_STATUS_RESULT);

  matUpdateVAddVController(&con->base);

  return &con->base;
}



void matDeallocVAddVController(MATBaseController* controller){
  MATVAddVController* con = (MATVAddVController*)controller;
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
