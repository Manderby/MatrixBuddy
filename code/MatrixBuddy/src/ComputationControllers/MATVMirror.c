#include "../MATApplication.h"
#include "MATBaseController.h"
#include "../MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATVMirrorController MATVMirrorController;
struct MATVMirrorController{
  MATBaseController base;
  MATView* viewA;
  NALabel* mirrorSignLabel;
  MATView* viewN;
  NALabel* equalSignLabel;
  MATView* viewB;
};



void matUpdateVMirrorController(MATBaseController* controller){
  MATVMirrorController* con = (MATVMirrorController*)controller;

  matSetViewPasteEnabled(con->viewB, NA_FALSE);

  matUpdateView(con->viewA);
  matUpdateView(con->viewN);
  matUpdateView(con->viewB);
}



void matUpdateVMirrorControllerTabOrder(MATBaseController* controller){
  MATVMirrorController* con = (MATVMirrorController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewN);
  matUpdateViewTabOrder(con->viewB);
}



void matVMirrorValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATVMirrorController* con = (MATVMirrorController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesN = matGetViewValues(con->viewN);

  size_t elementCount = matGetViewElementCount(con->viewB);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  double length = 0.;
  switch(con->base.dimensions){
  case 2: length = naLengthV2d(valuesN); break;
  case 3: length = naLengthV3d(valuesN); break;
  case 4: length = naLengthV4d(valuesN); break;
  }

  if(naAlmostOnef((float)length)){
    matSetViewStatus(con->viewN, MAT_STATUS_NORMAL);
  }else{
    matSetViewStatus(con->viewN, MAT_STATUS_VECTOR_LENGTH_UNEQUAL_ONE);
  }

  switch(con->base.dimensions){
  case 2: naMirrorV4d(result, valuesA, valuesN); break;
  case 3: naMirrorV4d(result, valuesA, valuesN); break;
  case 4: naMirrorV4d(result, valuesA, valuesN); break;
  }
  
  matSetViewValues(con->viewB, result);
  matUpdateVMirrorController(&con->base);
  naFree(result);
}



MATBaseController* matAllocVMirrorController(size_t dimensions){
  MATVMirrorController* con = naAlloc(MATVMirrorController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpVMirror,
    matVMirrorValueChanged,
    matUpdateVMirrorController,
    matUpdateVMirrorControllerTabOrder);
  
  size_t vectorElementCount = dimensions;
  double* initVector = naMalloc(vectorElementCount * sizeof(double));
  naZeron(initVector, vectorElementCount * sizeof(double));
  double* initVectorN = naMalloc(vectorElementCount * sizeof(double));
  naZeron(initVectorN, vectorElementCount * sizeof(double));

  switch(con->base.dimensions){
  case 2:
    naFillV2d(initVectorN, 1., 0.);
    break;
  case 3:
    naFillV3d(initVectorN, 1., 0., 0.);
    break;
  case 4:
    naFillV4d(initVectorN, 1., 0., 0., 0.);
    break;
  }

  con->viewA = matAllocView("a", 1, dimensions, con, initVector);
  con->viewN = matAllocView("n", 1, dimensions, con, initVectorN);
  con->viewB = matAllocView("b", 1, dimensions, con, initVector);

  naFree(initVector);
  naFree(initVectorN);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceS = matGetViewSpace(con->viewN);
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

  con->mirrorSignLabel = naNewLabel(MAT_MIRROR_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->mirrorSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->mirrorSignLabel, matGetMathFont());
  naSetLabelHeight(con->mirrorSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->mirrorSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MAT_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeS.width + MAT_SIGN_WIDTH, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewN, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_RESULT);

  matUpdateVMirrorController(&con->base);

  return &con->base;
}



void matDeallocVMirrorController(MATBaseController* controller){
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
