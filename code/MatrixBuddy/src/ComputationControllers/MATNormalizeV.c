#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATVNormalizeController MATVNormalizeController;
struct MATVNormalizeController{
  MATBaseController base;
  MATView* viewA;
  NALabel* arrowSignLabel;
  MATView* viewB;
};



void matUpdateVNormalizeController(MATBaseController* controller){
  MATVNormalizeController* con = (MATVNormalizeController*)controller;

  matSetViewPasteEnabled(con->viewB, NA_FALSE);

  matUpdateView(con->viewA);
  matUpdateView(con->viewB);
}



void matUpdateVNormalizeControllerTabOrder(MATBaseController* controller){
  MATVNormalizeController* con = (MATVNormalizeController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewB);
}



void matVNormalizeValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATVNormalizeController* con = (MATVNormalizeController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);

  size_t elementCount = matGetViewElementCount(con->viewB);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  MATStatus newStatus = MAT_STATUS_NORMAL;
  double len = 0.;
  switch(con->base.dimensions){
  case 2: len = naLengthV2d(valuesA); break;
  case 3: len = naLengthV3d(valuesA); break;
  case 4: len = naLengthV4d(valuesA); break;
  }

  if(len == 0.){newStatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZerof(len)){newStatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}

  if(newStatus == MAT_STATUS_VECTOR_LENGTH_ZERO){
    naFillV3d(result, 0., 0., 0.);
  }else{
    naNormalizeV3d(result, valuesA);
  }

  matSetViewStatus(con->viewA, newStatus);
  
  matSetViewValues(con->viewB, result);
  matUpdateVNormalizeController(&con->base);
  naFree(result);
}



MATBaseController* matAllocVNormalizeController(size_t dimensions){
  MATVNormalizeController* con = naAlloc(MATVNormalizeController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpVNormalize,
    matVNormalizeValueChanged,
    matUpdateVNormalizeController,
    matUpdateVNormalizeControllerTabOrder);
  
  double* initVectorA = naMalloc(dimensions * sizeof(double));
  naZeron(initVectorA, dimensions * sizeof(double));

  switch(con->base.dimensions){
  case 2:
    naFillV2d(initVectorA, 1., 0.);
    break;
  case 3:
    naFillV3d(initVectorA, 1., 0., 0.);
    break;
  case 4:
    naFillV4d(initVectorA, 1., 0., 0., 0.);
    break;
  }

  con->viewA = matAllocView("a", 1, dimensions, con, initVectorA);
  con->viewB = matAllocView("b", 1, dimensions, con, initVectorA);

  naFree(initVectorA);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceB = matGetViewSpace(con->viewB);
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize sizeB = naGetUIElementRect(spaceB).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeA.width + MAT_SIGN_WIDTH + sizeB.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeA.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2. + MAT_SIGN_LABEL_SHIFT_Y); 
  
  naAddSpaceChild(con->base.space, spaceA, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceB, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, marginBottom));

  con->arrowSignLabel = naNewLabel(MAT_ARROW_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->arrowSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->arrowSignLabel, matGetMathFont());
  naSetLabelHeight(con->arrowSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->arrowSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_RESULT);

  matUpdateVNormalizeController(&con->base);

  return &con->base;
}



void matDeallocVNormalizeController(MATBaseController* controller){
  MATVNormalizeController* con = (MATVNormalizeController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



