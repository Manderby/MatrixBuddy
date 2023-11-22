#include "MATApplication.h"
#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATVDivCompVController MATVDivCompVController;
struct MATVDivCompVController{
  MATBaseController base;
  MATView* viewA;
  NALabel* divSignLabel;
  MATView* viewB;
  NALabel* equalSignLabel;
  MATView* viewC;
};



void matUpdateVDivCompVController(MATBaseController* controller){
  MATVDivCompVController* con = (MATVDivCompVController*)controller;

  matSetViewPasteEnabled(con->viewC, NA_FALSE);

  matUpdateView(con->viewA);
  matUpdateView(con->viewB);
  matUpdateView(con->viewC);
}



void matUpdateVDivCompVControllerTabOrder(MATBaseController* controller){
  MATVDivCompVController* con = (MATVDivCompVController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewB);
  matUpdateViewTabOrder(con->viewC);
}



void matVDivCompVValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATVDivCompVController* con = (MATVDivCompVController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesB = matGetViewValues(con->viewB);

  size_t elementCount = matGetViewElementCount(con->viewC);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  MATStatus newStatus = MAT_STATUS_NORMAL;
  for(int y = 0; y < con->base.dimensions; ++y){
    if(valuesB[y] == 0.){
      newStatus = MAT_STATUS_VECTOR_COMPONENT_ZERO;
    }else if((newStatus != MAT_STATUS_VECTOR_COMPONENT_ZERO) && naAlmostZerof(valuesB[y])){
      newStatus = MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }

  matSetViewStatus(con->viewB, newStatus);
  if(newStatus != MAT_STATUS_VECTOR_COMPONENT_ZERO){
    switch(con->base.dimensions){
    case 2: naDivCompV2dV2d(result, valuesA, valuesB); break;
    case 3: naDivCompV3dV3d(result, valuesA, valuesB); break;
    case 4: naDivCompV4dV4d(result, valuesA, valuesB); break;
    }
  }

  matSetViewValues(con->viewC, result);
  matUpdateVDivCompVController(&con->base);
  naFree(result);
}



MATBaseController* matAllocVDivCompVController(size_t dimensions){
  MATVDivCompVController* con = naAlloc(MATVDivCompVController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpVDivCompV,
    matVDivCompVValueChanged,
    matUpdateVDivCompVController,
    matUpdateVDivCompVControllerTabOrder);
  
  double* initVectorA = naMalloc(dimensions * sizeof(double));
  naZeron(initVectorA, dimensions * sizeof(double));
  double* initVectorB = naMalloc(dimensions * sizeof(double));
  naZeron(initVectorB, dimensions * sizeof(double));

  switch(con->base.dimensions){
  case 2:
    naFillV2d(initVectorB, 1., 1.);
    break;
  case 3:
    naFillV3d(initVectorB, 1., 1., 1.);
    break;
  case 4:
    naFillV4d(initVectorB, 1., 1., 1., 1.);
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

  con->divSignLabel = naNewLabel(MAT_DIV_CIRCLE_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->divSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->divSignLabel, matGetMathFont());
  naSetLabelHeight(con->divSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->divSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MAT_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeB.width + MAT_SIGN_WIDTH, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewC, MAT_STATUS_RESULT);

  matUpdateVDivCompVController(&con->base);

  return &con->base;
}



void matDeallocVDivCompVController(MATBaseController* controller){
  MATVDivCompVController* con = (MATVDivCompVController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



