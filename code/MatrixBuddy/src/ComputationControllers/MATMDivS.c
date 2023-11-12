#include "MATMDivS.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


struct MATMDivSController{
  MATBaseController base;
  MATView* viewA;
  NALabel* divSignLabel;
  MATView* viewS;
  NALabel* equalSignLabel;
  MATView* viewB;
};



void matMDivSValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATMDivSController* con = (MATMDivSController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesS = matGetViewValues(con->viewS);

  size_t elementCount = matGetViewElementCount(con->viewB);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  if(*valuesS == 0){
    matSetViewStatus(con->viewS, MAT_STATUS_SCALAR_ZERO);
  }else{
    double factor = naInv(*valuesS);
    matSetViewStatus(con->viewS, naAlmostZerof((float)*valuesS)
      ? MAT_STATUS_SCALAR_ALMOST_ZERO
      : MAT_STATUS_NORMAL);
    switch(con->base.dimensions){
    case 2: naMulCompM22d(result, valuesA, factor); break;
    case 3: naMulCompM33d(result, valuesA, factor); break;
    case 4: naMulCompM44d(result, valuesA, factor); break;
    }
  }

  matSetViewValues(con->viewB, result);
  matUpdateMDivSController(&con->base);
  naFree(result);
}



void matUpdateMDivSController(MATBaseController* controller){
  MATMDivSController* con = (MATMDivSController*)controller;

  matSetViewPasteEnabled(con->viewB, NA_FALSE);

  matUpdateView(con->viewA);
  matUpdateView(con->viewS);
  matUpdateView(con->viewB);
}



void matUpdateMDivSControllerTabOrder(MATBaseController* controller){
  MATMDivSController* con = (MATMDivSController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewS);
  matUpdateViewTabOrder(con->viewB);
}



MATBaseController* matAllocMDivSController(size_t dimensions){
  MATMDivSController* con = naAlloc(MATMDivSController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMDivS,
    matMDivSValueChanged,
    matUpdateMDivSController,
    matUpdateMDivSControllerTabOrder);
  
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

  con->viewA = matAllocView("A", dimensions, dimensions, con, initMatrix);
  con->viewS = matAllocView("s", 1, 1, con, initScalar);
  con->viewB = matAllocView("B", dimensions, dimensions, con, initMatrix);

  naFree(initMatrix);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceS = matGetViewSpace(con->viewS);
  NASpace* spaceB = matGetViewSpace(con->viewB);
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize sizeS = naGetUIElementRect(spaceS).size;
  NASize sizeB = naGetUIElementRect(spaceB).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeA.width + MAT_SIGN_WIDTH + sizeS.width + MAT_SIGN_WIDTH + sizeB.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeA.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2.); 
  
  naAddSpaceChild(con->base.space, spaceA, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceS, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, marginBottom));
  naAddSpaceChild(con->base.space, spaceB, naMakePos(marginLeft + sizeA.width + sizeS.width + 2 * MAT_SIGN_WIDTH, marginBottom));

  con->divSignLabel = naNewLabel(MA_DIVISION_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->divSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->divSignLabel, matGetMathFont());
  naSetLabelHeight(con->divSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->divSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MA_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeS.width + MAT_SIGN_WIDTH, signMarginBottom));
  
  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewS, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_RESULT);

  matUpdateMDivSController(&con->base);

  return &con->base;
}



void matDeallocMDivSController(MATBaseController* controller){
  MATMDivSController* con = (MATMDivSController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}


