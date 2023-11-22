#include "MATApplication.h"
#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATMAddMController MATMAddMController;
struct MATMAddMController{
  MATBaseController base;
  MATView* viewA;
  NALabel* addSignLabel;
  MATView* viewB;
  NALabel* equalSignLabel;
  MATView* viewC;
};



void matUpdateMAddMController(MATBaseController* controller){
  MATMAddMController* con = (MATMAddMController*)controller;
  matUpdateView(con->viewA);
  matUpdateView(con->viewB);
  matUpdateView(con->viewC);
}



void matUpdateMAddMControllerTabOrder(MATBaseController* controller){
  MATMAddMController* con = (MATMAddMController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewB);
  matUpdateViewTabOrder(con->viewC);
}



void matMAddMValueChanged(MATBaseController* controller, MATView* view){
  MATMAddMController* con = (MATMAddMController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesB = matGetViewValues(con->viewB);
  const double* valuesC = matGetViewValues(con->viewC);

  size_t elementCount = matGetViewElementCount(con->viewC);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  if(view == con->viewC){
    switch(con->base.dimensions){
    case 2: naSubM22d(result, valuesC, valuesA); break;
    case 3: naSubM33d(result, valuesC, valuesA); break;
    case 4: naSubM44d(result, valuesC, valuesA); break;
    }
    matSetViewValues(con->viewB, result);
    matSetViewStatus(con->viewB, MAT_STATUS_RESULT);
    matSetViewStatus(con->viewC, MAT_STATUS_NORMAL);
  }else{
    switch(con->base.dimensions){
    case 2: naAddM22d(result, valuesA, valuesB); break;
    case 3: naAddM33d(result, valuesA, valuesB); break;
    case 4: naAddM44d(result, valuesA, valuesB); break;
    }
    matSetViewValues(con->viewC, result);
    matSetViewStatus(con->viewB, MAT_STATUS_NORMAL);
    matSetViewStatus(con->viewC, MAT_STATUS_RESULT);
  }

  matUpdateMAddMController(&con->base);
  naFree(result);
}



MATBaseController* matAllocMAddMController(size_t dimensions){
  MATMAddMController* con = naAlloc(MATMAddMController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMAddM,
    matMAddMValueChanged,
    matUpdateMAddMController,
    matUpdateMAddMControllerTabOrder);
  
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

  con->addSignLabel = naNewLabel(MAT_ADD_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->addSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->addSignLabel, matGetMathFont());
  naSetLabelHeight(con->addSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->addSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel(MAT_EQUAL_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeB.width + MAT_SIGN_WIDTH, signMarginBottom));

  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewC, MAT_STATUS_RESULT);

  matUpdateMAddMController(&con->base);

  return &con->base;
}



void matDeallocMAddMController(MATBaseController* controller){
  MATMAddMController* con = (MATMAddMController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



