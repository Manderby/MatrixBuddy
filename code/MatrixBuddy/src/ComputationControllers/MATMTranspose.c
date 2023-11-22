#include "MATApplication.h"
#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATMTransposeController MATMTransposeController;
struct MATMTransposeController{
  MATBaseController base;
  MATView* viewA;
  NALabel* arrowSignLabel;
  MATView* viewT;
};



void matUpdateMTransposeController(MATBaseController* controller){
  MATMTransposeController* con = (MATMTransposeController*)controller;
  matUpdateView(con->viewA);
  matUpdateView(con->viewT);
}



void matUpdateMTransposeControllerTabOrder(MATBaseController* controller){
  MATMTransposeController* con = (MATMTransposeController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewT);
}



void matMTransposeValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATMTransposeController* con = (MATMTransposeController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesT = matGetViewValues(con->viewT);

  size_t elementCount = matGetViewElementCount(con->viewT);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  if(view == con->viewA){
    switch(con->base.dimensions){
    case 2: naTransposeM22d(result, valuesA); break;
    case 3: naTransposeM33d(result, valuesA); break;
    case 4: naTransposeM44d(result, valuesA); break;
    }
    matSetViewValues(con->viewT, result);
    matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
    matSetViewStatus(con->viewT, MAT_STATUS_RESULT);
  }else{
    switch(con->base.dimensions){
    case 2: naTransposeM22d(result, valuesT); break;
    case 3: naTransposeM33d(result, valuesT); break;
    case 4: naTransposeM44d(result, valuesT); break;
    }
    matSetViewValues(con->viewA, result);
    matSetViewStatus(con->viewA, MAT_STATUS_RESULT);
    matSetViewStatus(con->viewT, MAT_STATUS_NORMAL);
  }

  matUpdateMTransposeController(&con->base);
  naFree(result);
}



MATBaseController* matAllocMTransposeController(size_t dimensions){
  MATMTransposeController* con = naAlloc(MATMTransposeController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMTranspose,
    matMTransposeValueChanged,
    matUpdateMTransposeController,
    matUpdateMTransposeControllerTabOrder);
  
  size_t matrixElementCount = dimensions * dimensions;
  double* initMatrix = naMalloc(matrixElementCount * sizeof(double));
  naZeron(initMatrix, matrixElementCount * sizeof(double));

  con->viewA = matAllocView("A", dimensions, dimensions, con, initMatrix);
  con->viewT = matAllocView("A" MAT_SUPERSCRIPT_T, dimensions, dimensions, con, initMatrix);

  naFree(initMatrix);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceT = matGetViewSpace(con->viewT);
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize sizeT = naGetUIElementRect(spaceT).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeA.width + MAT_SIGN_WIDTH + sizeT.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeA.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2. + MAT_SIGN_LABEL_SHIFT_Y); 
  
  naAddSpaceChild(con->base.space, spaceA, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceT, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, marginBottom));

  con->arrowSignLabel = naNewLabel(MAT_DOUBLE_ARROW_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->arrowSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->arrowSignLabel, matGetMathFont());
  naSetLabelHeight(con->arrowSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->arrowSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewT, MAT_STATUS_RESULT);

  matUpdateMTransposeController(&con->base);

  return &con->base;
}



void matDeallocMTransposeController(MATBaseController* controller){
  MATMTransposeController* con = (MATMTransposeController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



