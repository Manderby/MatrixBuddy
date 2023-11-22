#include "MATApplication.h"
#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATVNegController MATVNegController;
struct MATVNegController{
  MATBaseController base;
  MATView* viewV;
  NALabel* arrowSignLabel;
  MATView* viewN;
};



void matUpdateVNegController(MATBaseController* controller){
  MATVNegController* con = (MATVNegController*)controller;
  matUpdateView(con->viewV);
  matUpdateView(con->viewN);
}



void matUpdateVNegControllerTabOrder(MATBaseController* controller){
  MATVNegController* con = (MATVNegController*)controller;
  matUpdateViewTabOrder(con->viewV);
  matUpdateViewTabOrder(con->viewN);
}



void matVNegValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATVNegController* con = (MATVNegController*)controller;

  const double* valuesV = matGetViewValues(con->viewV);
  const double* valuesN = matGetViewValues(con->viewN);

  size_t elementCount = matGetViewElementCount(con->viewN);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  if(view == con->viewV){
    switch(con->base.dimensions){
    case 2: naNegV2d(result, valuesV); break;
    case 3: naNegV3d(result, valuesV); break;
    case 4: naNegV4d(result, valuesV); break;
    }
    matSetViewValues(con->viewN, result);
    matSetViewStatus(con->viewV, MAT_STATUS_NORMAL);
    matSetViewStatus(con->viewN, MAT_STATUS_RESULT);
  }else{
    switch(con->base.dimensions){
    case 2: naNegV2d(result, valuesN); break;
    case 3: naNegV3d(result, valuesN); break;
    case 4: naNegV4d(result, valuesN); break;
    }
    matSetViewValues(con->viewV, result);
    matSetViewStatus(con->viewV, MAT_STATUS_RESULT);
    matSetViewStatus(con->viewN, MAT_STATUS_NORMAL);
  }

  matUpdateVNegController(&con->base);
  naFree(result);
}



MATBaseController* matAllocVNegController(size_t dimensions){
  MATVNegController* con = naAlloc(MATVNegController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpVNeg,
    matVNegValueChanged,
    matUpdateVNegController,
    matUpdateVNegControllerTabOrder);
  
  double* initVector = naMalloc(dimensions * sizeof(double));
  naZeron(initVector, dimensions * sizeof(double));

  con->viewV = matAllocView("v", 1, dimensions, con, initVector);
  con->viewN = matAllocView(MAT_SUB_SIGN "v", 1, dimensions, con, initVector);

  naFree(initVector);

  NASpace* spaceV = matGetViewSpace(con->viewV);
  NASpace* spaceN = matGetViewSpace(con->viewN);
  NASize sizeV = naGetUIElementRect(spaceV).size;
  NASize sizeN = naGetUIElementRect(spaceN).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeV.width + MAT_SIGN_WIDTH + sizeN.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeV.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeV.height - MAT_MATRIX_LABEL_HEIGHT) / 2. + MAT_SIGN_LABEL_SHIFT_Y); 
  
  naAddSpaceChild(con->base.space, spaceV, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceN, naMakePos(marginLeft + sizeV.width + MAT_SIGN_WIDTH, marginBottom));

  con->arrowSignLabel = naNewLabel(MAT_DOUBLE_ARROW_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->arrowSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->arrowSignLabel, matGetMathFont());
  naSetLabelHeight(con->arrowSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->arrowSignLabel, naMakePos(marginLeft + sizeV.width, signMarginBottom));

  matSetViewStatus(con->viewV, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewN, MAT_STATUS_RESULT);

  matUpdateVNegController(&con->base);

  return &con->base;
}



void matDeallocVNegController(MATBaseController* controller){
  MATVNegController* con = (MATVNegController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



