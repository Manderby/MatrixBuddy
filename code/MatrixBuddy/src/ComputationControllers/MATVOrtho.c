#include "../MATApplication.h"
#include "MATBaseController.h"
#include "../MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATVOrthoController MATVOrthoController;
struct MATVOrthoController{
  MATBaseController base;
  MATView* viewA;
  NALabel* orthogonalSignLabel;
  MATView* viewB;
  NALabel* equalSignLabel;
  MATView* viewC;
};



void matUpdateVOrthoController(MATBaseController* controller){
  MATVOrthoController* con = (MATVOrthoController*)controller;

  matSetViewPasteEnabled(con->viewC, NA_FALSE);

  matUpdateView(con->viewA);
  matUpdateView(con->viewB);
  matUpdateView(con->viewC);
}



void matUpdateVOrthoControllerTabOrder(MATBaseController* controller){
  MATVOrthoController* con = (MATVOrthoController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewB);
  matUpdateViewTabOrder(con->viewC);
}



void matVOrthoValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATVOrthoController* con = (MATVOrthoController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesB = matGetViewValues(con->viewB);

  size_t elementCount = matGetViewElementCount(con->viewC);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  double lengthA = 0.;
  double lengthB = 0.;
  switch(con->base.dimensions){
  case 2:
    lengthA = naLengthV2d(valuesA);
    lengthB = naLengthV2d(valuesB);
    break;
  case 3:
    lengthA = naLengthV3d(valuesA);
    lengthB = naLengthV3d(valuesB);
    break;
  case 4:
    lengthA = naLengthV4d(valuesA);
    lengthB = naLengthV4d(valuesB);
    break;
  }

  MATStatus newStatusA = MAT_STATUS_NORMAL;
  if(lengthA == 0.){newStatusA = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZerof((float)lengthA)){newStatusA = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  MATStatus newStatusB = MAT_STATUS_NORMAL;
  if(lengthB == 0.){newStatusB = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZerof((float)lengthB)){newStatusB = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}

  if((newStatusA != MAT_STATUS_VECTOR_LENGTH_ZERO) && (newStatusB != MAT_STATUS_VECTOR_LENGTH_ZERO)){
    NAVec4d normA;
    NAVec4d normB;
    NAVec4d diff;
    double diffLen = 0.;
    switch(con->base.dimensions){
    case 2:
      naNormalizeV2d(normA, valuesA);
      naNormalizeV2d(normB, valuesB);
      naSubV2d(diff, normA, normB);
      diffLen = naLengthV2d(diff);
      break;
    case 3:
      naNormalizeV3d(normA, valuesA);
      naNormalizeV3d(normB, valuesB);
      naSubV3d(diff, normA, normB);
      diffLen = naLengthV3d(diff);
      break;
    case 4:
      naNormalizeV4d(normA, valuesA);
      naNormalizeV4d(normB, valuesB);
      naSubV4d(diff, normA, normB);
      diffLen = naLengthV4d(diff);
      break;
    }
    if(diffLen == 0.){newStatusA = MAT_STATUS_VECTORS_COLINEAR;}
    else if(naAlmostZerof((float)diffLen)){newStatusA = MAT_STATUS_VECTORS_ALMOST_COLINEAR;}
  }

  if(newStatusB == MAT_STATUS_VECTOR_LENGTH_ZERO){
    naFillV4d(result, 0., 0., 0., 0.);
  }else{
    switch(con->base.dimensions){
    case 2: naOrthogonalizeV2d(result, valuesA, valuesB); break;
    case 3: naOrthogonalizeV3d(result, valuesA, valuesB); break;
    case 4: naOrthogonalizeV4d(result, valuesA, valuesB); break;
    }
  }

  matSetViewStatus(con->viewA, newStatusA);
  matSetViewStatus(con->viewB, newStatusB);
  
  matSetViewValues(con->viewC, result);
  matUpdateVOrthoController(&con->base);
  naFree(result);
}



MATBaseController* matAllocVOrthoController(size_t dimensions){
  MATVOrthoController* con = naAlloc(MATVOrthoController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpVOrtho,
    matVOrthoValueChanged,
    matUpdateVOrthoController,
    matUpdateVOrthoControllerTabOrder);
  
  size_t vectorElementCount = dimensions;
  double* initVectorA = naMalloc(vectorElementCount * sizeof(double));
  naZeron(initVectorA, vectorElementCount * sizeof(double));
  double* initVectorB = naMalloc(vectorElementCount * sizeof(double));
  naZeron(initVectorB, vectorElementCount * sizeof(double));

  switch(con->base.dimensions){
  case 2:
    naFillV2d(initVectorA, 1., 0.);
    naFillV2d(initVectorB, 0., 1.);
    break;
  case 3:
    naFillV3d(initVectorA, 1., 0., 0.);
    naFillV3d(initVectorB, 0., 1., 0.);
    break;
  case 4:
    naFillV4d(initVectorA, 1., 0., 0., 0.);
    naFillV4d(initVectorB, 0., 1., 0., 0.);
    break;
  }

  con->viewA = matAllocView("a", 1, dimensions, con, initVectorA);
  con->viewB = matAllocView("b", 1, dimensions, con, initVectorB);
  con->viewC = matAllocView("c", 1, dimensions, con, initVectorA);

  naFree(initVectorA);
  naFree(initVectorB);

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

  con->orthogonalSignLabel = naNewLabel(MAT_ORTHO_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->orthogonalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->orthogonalSignLabel, matGetMathFont());
  naSetLabelHeight(con->orthogonalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->orthogonalSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MAT_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeB.width + MAT_SIGN_WIDTH, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewC, MAT_STATUS_RESULT);

  matUpdateVOrthoController(&con->base);

  return &con->base;
}



void matDeallocVOrthoController(MATBaseController* controller){
  MATVOrthoController* con = (MATVOrthoController*)controller;
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
