#include "MATApplication.h"
#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATMMulMController MATMMulMController;
struct MATMMulMController{
  MATBaseController base;
  MATView* viewA;
  NALabel* mulSignLabel;
  MATView* viewB;
  NALabel* equalSignLabel;
  MATView* viewC;
};



void matUpdateMMulMController(MATBaseController* controller){
  MATMMulMController* con = (MATMMulMController*)controller;
  matUpdateView(con->viewA);
  matUpdateView(con->viewB);
  matUpdateView(con->viewC);
}



void matUpdateMMulMControllerTabOrder(MATBaseController* controller){
  MATMMulMController* con = (MATMMulMController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewB);
  matUpdateViewTabOrder(con->viewC);
}



void matMMulMValueChanged(MATBaseController* controller, MATView* view){
  MATMMulMController* con = (MATMMulMController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesB = matGetViewValues(con->viewB);
  const double* valuesC = matGetViewValues(con->viewC);

  size_t elementCount = matGetViewElementCount(con->viewC);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  MATStatus newStatusA = MAT_STATUS_NORMAL;
  MATStatus newStatusB;
  MATStatus newStatusC;
  if(view == con->viewC){
    newStatusB = MAT_STATUS_RESULT;
    newStatusC = MAT_STATUS_NORMAL;
    double det = 0.;
    switch(con->base.dimensions){
    case 2: det = naDetM22d(valuesA); break;
    case 3: det = naDetM33d(valuesA); break;
    case 4: det = naDetM44d(valuesA); break;
    }
    if(det == 0.){
      newStatusA = MAT_STATUS_MATRIX_DETERMINANT_ZERO;
    }else{
      newStatusA = naAlmostZerof(det)
        ? MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO
        : MAT_STATUS_NORMAL;
      double* inverse = naMalloc(elementCount * sizeof(double));
      switch(con->base.dimensions){
      case 2: naInvM22d(inverse, valuesA); naMulM22dM22d(result, inverse, valuesC); break;
      case 3: naInvM33d(inverse, valuesA); naMulM33dM33d(result, inverse, valuesC); break;
      case 4: naInvM44d(inverse, valuesA); naMulM44dM44d(result, inverse, valuesC); break;
      }
      naFree(inverse);
    }
    matSetViewValues(con->viewB, result);

  }else{
    newStatusB = MAT_STATUS_NORMAL;
    newStatusC = MAT_STATUS_RESULT;
    switch(con->base.dimensions){
    case 2: naMulM22dM22d(result, valuesA, valuesB); break;
    case 3: naMulM33dM33d(result, valuesA, valuesB); break;
    case 4: naMulM44dM44d(result, valuesA, valuesB); break;
    }
    matSetViewValues(con->viewC, result);
  }
  matSetViewStatus(con->viewA, newStatusA);
  matSetViewStatus(con->viewB, newStatusB);
  matSetViewStatus(con->viewC, newStatusC);

  matUpdateMMulMController(&con->base);
  naFree(result);
}



MATBaseController* matAllocMMulMController(size_t dimensions){
  MATMMulMController* con = naAlloc(MATMMulMController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMMulM,
    matMMulMValueChanged,
    matUpdateMMulMController,
    matUpdateMMulMControllerTabOrder);
  
  size_t matrixElementCount = dimensions * dimensions;
  double* initMatrix = naMalloc(matrixElementCount * sizeof(double));
  naZeron(initMatrix, matrixElementCount * sizeof(double));

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
  con->viewB = matAllocView("B", dimensions, dimensions, con, initMatrix);
  con->viewC = matAllocView("C", dimensions, dimensions, con, initMatrix);

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

  con->mulSignLabel = naNewLabel(MAT_MUL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->mulSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->mulSignLabel, matGetMathFont());
  naSetLabelHeight(con->mulSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->mulSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MAT_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeB.width + MAT_SIGN_WIDTH, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewC, MAT_STATUS_RESULT);

  matUpdateMMulMController(&con->base);

  return &con->base;
}



void matDeallocMMulMController(MATBaseController* controller){
  MATMMulMController* con = (MATMMulMController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



