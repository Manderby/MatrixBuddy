#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATMSubMController MATMSubMController;
struct MATMSubMController{
  MATBaseController base;
  MATView* viewA;
  NALabel* subSignLabel;
  MATView* viewB;
  NALabel* equalSignLabel;
  MATView* viewC;
};



void matUpdateMSubMController(MATBaseController* controller){
  MATMSubMController* con = (MATMSubMController*)controller;
  matUpdateView(con->viewA);
  matUpdateView(con->viewB);
  matUpdateView(con->viewC);
}



void matUpdateMSubMControllerTabOrder(MATBaseController* controller){
  MATMSubMController* con = (MATMSubMController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewB);
  matUpdateViewTabOrder(con->viewC);
}



void matMSubMValueChanged(MATBaseController* controller, MATView* view){
  MATMSubMController* con = (MATMSubMController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesB = matGetViewValues(con->viewB);
  const double* valuesC = matGetViewValues(con->viewC);

  size_t elementCount = matGetViewElementCount(con->viewC);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  if(view == con->viewC){
    switch(con->base.dimensions){
    case 2: naSubM22d(result, valuesA, valuesC); break;
    case 3: naSubM33d(result, valuesA, valuesC); break;
    case 4: naSubM44d(result, valuesA, valuesC); break;
    }
    matSetViewValues(con->viewB, result);
    matSetViewStatus(con->viewB, MAT_STATUS_RESULT);
    matSetViewStatus(con->viewC, MAT_STATUS_NORMAL);
  }else{
    switch(con->base.dimensions){
    case 2: naSubM22d(result, valuesA, valuesB); break;
    case 3: naSubM33d(result, valuesA, valuesB); break;
    case 4: naSubM44d(result, valuesA, valuesB); break;
    }
    matSetViewValues(con->viewC, result);
    matSetViewStatus(con->viewB, MAT_STATUS_NORMAL);
    matSetViewStatus(con->viewC, MAT_STATUS_RESULT);
  }

  matUpdateMSubMController(&con->base);
  naFree(result);
}



MATBaseController* matAllocMSubMController(size_t dimensions){
  MATMSubMController* con = naAlloc(MATMSubMController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMSubM,
    matMSubMValueChanged,
    matUpdateMSubMController,
    matUpdateMSubMControllerTabOrder);
  
  size_t matrixElementCount = dimensions * dimensions;
  double* initMatrix = naMalloc(matrixElementCount * sizeof(double));
  naZeron(initMatrix, matrixElementCount * sizeof(double));

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

  con->subSignLabel = naNewLabel(MA_SUB_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->subSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->subSignLabel, matGetMathFont());
  naSetLabelHeight(con->subSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->subSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MA_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeB.width + MAT_SIGN_WIDTH, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewC, MAT_STATUS_RESULT);

  matUpdateMSubMController(&con->base);

  return &con->base;
}



void matDeallocMSubMController(MATBaseController* controller){
  MATMSubMController* con = (MATMSubMController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



