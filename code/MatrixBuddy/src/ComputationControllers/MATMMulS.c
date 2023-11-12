
#include "MATMMulS.h"
#include "NAMath/NAVectorAlgebra.h"


struct MATMulMSController{
  MATBaseController base;
  MATView* viewA;
  NALabel* mulSignLabel;
  MATView* viewS;
  NALabel* equalSignLabel;
  MATView* viewB;
};





void mulMSValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATMulMSController* con = (MATMulMSController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesS = matGetViewValues(con->viewS);

  NAMat22d result2;
  NAMat33d result3;
  NAMat44d result4;

  switch(con->base.dimensions){
  case 2:
    naMulCompM22d(result2, valuesA, *valuesS);
    matSetViewValues(con->viewB, result2);
    break;
  case 3:
    naMulCompM33d(result3, valuesA, *valuesS);
    matSetViewValues(con->viewB, result3);
    break;
  case 4:
    naMulCompM44d(result4, valuesA, *valuesS);
    matSetViewValues(con->viewB, result4);
    break;
  }

  naUpdateMulMSController(con);
}



void updateMulMSControllerTabOrder(MATBaseController* controller){
  MATMulMSController* con = (MATMulMSController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewS);
  matUpdateViewTabOrder(con->viewB);
}



MATBaseController* matAllocMulMSController(size_t dimensions){
  MATMulMSController* con = naAlloc(MATMulMSController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    mulMSValueChanged,
    updateMulMSControllerTabOrder);
  
  NAMat22d initM22;
  NAMat33d initM33;
  NAMat44d initM44;
  double* initM = NA_NULL;

  switch(con->base.dimensions){
  case 2:
    naFillM22dWithDiag(initM22, 1);
    initM = initM22;
    break;
  case 3:
    naFillM33dWithDiag(initM33, 1);
    initM = initM33;
    break;
  case 4:
    naFillM44dWithDiag(initM44, 1);
    initM = initM44;
    break;
  }

  double initS[] = {1.};
  con->viewS = matAllocView("s", 1, 1, con, initS);
  con->viewA = matAllocView("A", 1, dimensions, con, initM);
  con->viewB = matAllocView("B", dimensions, dimensions, con, initM);

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

  con->mulSignLabel = naNewLabel(MA_MULTIPLICATION_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->mulSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->mulSignLabel, matGetMathFont());
  naSetLabelHeight(con->mulSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->mulSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MA_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeS.width + MAT_SIGN_WIDTH, signMarginBottom));
  
  matUpdateView(con->viewA);
  matUpdateView(con->viewS);
  naUpdateMulMSController(con);

  return &con->base;
}



void naUpdateMulMSController(MATMulMSController* con){
  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewS, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_RESULT);

  matSetViewPasteEnabled(con->viewB, NA_FALSE);

  matUpdateView(con->viewB);
}
