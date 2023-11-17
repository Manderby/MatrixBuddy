
#include "MATMMulS.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


struct MATMMulSController{
  MATBaseController base;
  MATView* viewA;
  NALabel* mulSignLabel;
  MATView* viewS;
  NALabel* equalSignLabel;
  MATView* viewB;
};



void matMMulSValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATMMulSController* con = (MATMMulSController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesS = matGetViewValues(con->viewS);

  size_t elementCount = matGetViewElementCount(con->viewB);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  switch(con->base.dimensions){
  case 2: naMulCompM22d(result, valuesA, *valuesS); break;
  case 3: naMulCompM33d(result, valuesA, *valuesS); break;
  case 4: naMulCompM44d(result, valuesA, *valuesS); break;
  }
  
  matSetViewValues(con->viewB, result);
  matUpdateMMulSController(&con->base);
  naFree(result);
}



void matUpdateMMulSController(MATBaseController* controller){
  MATMMulSController* con = (MATMMulSController*)controller;

  matSetViewPasteEnabled(con->viewB, NA_FALSE);

  matUpdateView(con->viewA);
  matUpdateView(con->viewS);
  matUpdateView(con->viewB);
}



void matUpdateMMulSControllerTabOrder(MATBaseController* controller){
  MATMMulSController* con = (MATMMulSController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewS);
  matUpdateViewTabOrder(con->viewB);
}



MATBaseController* matAllocMMulSController(size_t dimensions){
  MATMMulSController* con = naAlloc(MATMMulSController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMMulS,
    matMMulSValueChanged,
    matUpdateMMulSController,
    matUpdateMMulSControllerTabOrder);
  
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
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2. + MAT_SIGN_LABEL_SHIFT_Y); 
  
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

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewS, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_RESULT);

  matUpdateMMulSController(&con->base);

  return &con->base;
}



void matDeallocMMulSController(MATBaseController* controller){
  MATMMulSController* con = (MATMMulSController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



