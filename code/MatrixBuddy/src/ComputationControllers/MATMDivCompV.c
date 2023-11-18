#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATMDivCompVController MATMDivCompVController;
struct MATMDivCompVController{
  MATBaseController base;
  MATView* viewA;
  NALabel* divSignLabel;
  MATView* viewV;
  NALabel* equalSignLabel;
  MATView* viewB;
};



void matUpdateMDivCompVController(MATBaseController* controller){
  MATMDivCompVController* con = (MATMDivCompVController*)controller;

  matSetViewPasteEnabled(con->viewB, NA_FALSE);

  matUpdateView(con->viewA);
  matUpdateView(con->viewV);
  matUpdateView(con->viewB);
}



void matUpdateMDivCompVControllerTabOrder(MATBaseController* controller){
  MATMDivCompVController* con = (MATMDivCompVController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewV);
  matUpdateViewTabOrder(con->viewB);
}



void matMDivCompVValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATMDivCompVController* con = (MATMDivCompVController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesV = matGetViewValues(con->viewV);

  size_t elementCount = matGetViewElementCount(con->viewB);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  MATStatus newStatus = MAT_STATUS_NORMAL;
  for(int y = 0; y < con->base.dimensions; ++y){
    if(valuesV[y] == 0.){
      newStatus = MAT_STATUS_VECTOR_COMPONENT_ZERO;
    }else if((newStatus != MAT_STATUS_VECTOR_COMPONENT_ZERO) && naAlmostZerof(valuesV[y])){
      newStatus = MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }

  matSetViewStatus(con->viewV, newStatus);
  if(newStatus != MAT_STATUS_VECTOR_COMPONENT_ZERO){
    switch(con->base.dimensions){
    case 2: naDivCompM22dV2d(result, valuesA, valuesV); break;
    case 3: naDivCompM33dV3d(result, valuesA, valuesV); break;
    case 4: naDivCompM44dV4d(result, valuesA, valuesV); break;
    }
  }

  matSetViewValues(con->viewB, result);
  matUpdateMDivCompVController(&con->base);
  naFree(result);
}



MATBaseController* matAllocMDivCompVController(size_t dimensions){
  MATMDivCompVController* con = naAlloc(MATMDivCompVController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMDivCompV,
    matMDivCompVValueChanged,
    matUpdateMDivCompVController,
    matUpdateMDivCompVControllerTabOrder);
  
  size_t matrixElementCount = dimensions * dimensions;
  size_t vectorElementCount = dimensions;
  double* initMatrix = naMalloc(matrixElementCount * sizeof(double));
  naZeron(initMatrix, matrixElementCount * sizeof(double));
  double* initVector = naMalloc(vectorElementCount * sizeof(double));
  naZeron(initVector, vectorElementCount * sizeof(double));

  switch(con->base.dimensions){
  case 2:
    naFillM22dWithDiag(initMatrix, 1);
    naFillV2d(initVector, 1., 1.);
    break;
  case 3:
    naFillM33dWithDiag(initMatrix, 1);
    naFillV3d(initVector, 1., 1., 1.);
    break;
  case 4:
    naFillM44dWithDiag(initMatrix, 1);
    naFillV4d(initVector, 1., 1., 1., 1.);
    break;
  }

  con->viewA = matAllocView("A", dimensions, dimensions, con, initMatrix);
  con->viewV = matAllocView("v", 1, dimensions, con, initVector);
  con->viewB = matAllocView("B", dimensions, dimensions, con, initMatrix);

  naFree(initMatrix);
  naFree(initVector);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceS = matGetViewSpace(con->viewV);
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

  con->divSignLabel = naNewLabel(MA_DIV_CIRCLE_SIGN, MAT_SIGN_WIDTH);
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
  matSetViewStatus(con->viewV, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_RESULT);

  matUpdateMDivCompVController(&con->base);

  return &con->base;
}



void matDeallocMDivCompVController(MATBaseController* controller){
  MATMDivCompVController* con = (MATMDivCompVController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



