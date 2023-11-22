#include "MATApplication.h"
#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATMDiagSController MATMDiagSController;
struct MATMDiagSController{
  MATBaseController base;
  MATView* viewS;
  NALabel* arrowSignLabel;
  MATView* viewA;
};



void matUpdateMDiagSController(MATBaseController* controller){
  MATMDiagSController* con = (MATMDiagSController*)controller;

  matSetViewPasteEnabled(con->viewA, NA_FALSE);

  matUpdateView(con->viewS);
  matUpdateView(con->viewA);
}



void matUpdateMDiagSControllerTabOrder(MATBaseController* controller){
  MATMDiagSController* con = (MATMDiagSController*)controller;
  matUpdateViewTabOrder(con->viewS);
  matUpdateViewTabOrder(con->viewA);
}



void matMDiagSValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATMDiagSController* con = (MATMDiagSController*)controller;

  const double* valuesS = matGetViewValues(con->viewS);

  size_t elementCount = matGetViewElementCount(con->viewA);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  switch(con->base.dimensions){
  case 2: naFillM22dWithDiag(result, *valuesS); break;
  case 3: naFillM33dWithDiag(result, *valuesS); break;
  case 4: naFillM44dWithDiag(result, *valuesS); break;
  }
  matSetViewValues(con->viewA, result);

  matUpdateMDiagSController(&con->base);
  naFree(result);
}



MATBaseController* matAllocMDiagSController(size_t dimensions){
  MATMDiagSController* con = naAlloc(MATMDiagSController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMDiagS,
    matMDiagSValueChanged,
    matUpdateMDiagSController,
    matUpdateMDiagSControllerTabOrder);
  
  size_t matrixElementCount = dimensions * dimensions;
  double* initMatrix = naMalloc(matrixElementCount * sizeof(double));
  naZeron(initMatrix, matrixElementCount * sizeof(double));
  double initScalar[] = {1.};

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

  con->viewS = matAllocView("s", 1, 1, con, initScalar);
  con->viewA = matAllocView("A", dimensions, dimensions, con, initMatrix);

  naFree(initMatrix);

  NASpace* spaceS = matGetViewSpace(con->viewS);
  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASize sizeS = naGetUIElementRect(spaceS).size;
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeS.width + MAT_SIGN_WIDTH + sizeA.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeS.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeS.height - MAT_MATRIX_LABEL_HEIGHT) / 2. + MAT_SIGN_LABEL_SHIFT_Y); 
  
  naAddSpaceChild(con->base.space, spaceS, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceA, naMakePos(marginLeft + sizeS.width + MAT_SIGN_WIDTH, marginBottom));

  con->arrowSignLabel = naNewLabel(MAT_ARROW_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->arrowSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->arrowSignLabel, matGetMathFont());
  naSetLabelHeight(con->arrowSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->arrowSignLabel, naMakePos(marginLeft + sizeS.width, signMarginBottom));

  matSetViewStatus(con->viewS, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewA, MAT_STATUS_RESULT);

  matUpdateMDiagSController(&con->base);

  return &con->base;
}



void matDeallocMDiagSController(MATBaseController* controller){
  MATMDiagSController* con = (MATMDiagSController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



