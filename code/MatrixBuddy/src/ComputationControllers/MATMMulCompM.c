#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATMMulCompMController MATMMulCompMController;
struct MATMMulCompMController{
  MATBaseController base;
  MATView* viewA;
  NALabel* mulSignLabel;
  MATView* viewB;
  NALabel* equalSignLabel;
  MATView* viewC;
};



void matUpdateMMulCompMController(MATBaseController* controller){
  MATMMulCompMController* con = (MATMMulCompMController*)controller;

  matSetViewPasteEnabled(con->viewC, NA_FALSE);

  matUpdateView(con->viewA);
  matUpdateView(con->viewB);
  matUpdateView(con->viewC);
}



void matUpdateMMulCompMControllerTabOrder(MATBaseController* controller){
  MATMMulCompMController* con = (MATMMulCompMController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewB);
  matUpdateViewTabOrder(con->viewC);
}



void matMMulCompMValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATMMulCompMController* con = (MATMMulCompMController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesB = matGetViewValues(con->viewB);

  size_t elementCount = matGetViewElementCount(con->viewC);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  switch(con->base.dimensions){
  case 2: naMulCompM22dM22d(result, valuesA, valuesB); break;
  case 3: naMulCompM33dM33d(result, valuesA, valuesB); break;
  case 4: naMulCompM44dM44d(result, valuesA, valuesB); break;
  }
  
  matSetViewValues(con->viewC, result);
  matUpdateMMulCompMController(&con->base);
  naFree(result);
}



MATBaseController* matAllocMMulCompMController(size_t dimensions){
  MATMMulCompMController* con = naAlloc(MATMMulCompMController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMMulCompM,
    matMMulCompMValueChanged,
    matUpdateMMulCompMController,
    matUpdateMMulCompMControllerTabOrder);
  
  size_t matrixElementCount = dimensions * dimensions;
  double* initMatrixUnit = naMalloc(matrixElementCount * sizeof(double));
  naZeron(initMatrixUnit, matrixElementCount * sizeof(double));
  double* initMatrixOne = naMalloc(matrixElementCount * sizeof(double));
  naZeron(initMatrixOne, matrixElementCount * sizeof(double));

  switch(con->base.dimensions){
  case 2:
    naFillM22dWithDiag(initMatrixUnit, 1);
    naFillM22dColumnFirst(initMatrixOne, 1., 1., 1., 1.);
    break;
  case 3:
    naFillM33dWithDiag(initMatrixUnit, 1);
    naFillM33dColumnFirst(initMatrixOne, 1., 1., 1., 1., 1., 1., 1., 1., 1.);
    break;
  case 4:
    naFillM44dWithDiag(initMatrixUnit, 1);
    naFillM44dColumnFirst(initMatrixOne, 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1., 1.);
    break;
  }

  con->viewA = matAllocView("A", dimensions, dimensions, con, initMatrixUnit);
  con->viewB = matAllocView("B", dimensions, dimensions, con, initMatrixOne);
  con->viewC = matAllocView("C", dimensions, dimensions, con, initMatrixUnit);

  naFree(initMatrixUnit);
  naFree(initMatrixOne);

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

  con->mulSignLabel = naNewLabel(MA_MUL_CIRCLE_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->mulSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->mulSignLabel, matGetMathFont());
  naSetLabelHeight(con->mulSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->mulSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MA_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeB.width + MAT_SIGN_WIDTH, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewC, MAT_STATUS_RESULT);

  matUpdateMMulCompMController(&con->base);

  return &con->base;
}



void matDeallocMMulCompMController(MATBaseController* controller){
  MATMMulCompMController* con = (MATMMulCompMController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



