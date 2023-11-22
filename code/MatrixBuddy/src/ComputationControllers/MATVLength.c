#include "MATApplication.h"
#include "MATBaseController.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


typedef struct MATVLengthController MATVLengthController;
struct MATVLengthController{
  MATBaseController base;
  MATView* viewV;
  NALabel* arrowSignLabel;
  MATView* viewL;
};



void matUpdateVLengthController(MATBaseController* controller){
  MATVLengthController* con = (MATVLengthController*)controller;

  matSetViewPasteEnabled(con->viewL, NA_FALSE);

  matUpdateView(con->viewV);
  matUpdateView(con->viewL);
}



void matUpdateVLengthControllerTabOrder(MATBaseController* controller){
  MATVLengthController* con = (MATVLengthController*)controller;
  matUpdateViewTabOrder(con->viewV);
  matUpdateViewTabOrder(con->viewL);
}



void matVLengthValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATVLengthController* con = (MATVLengthController*)controller;

  const double* valuesV = matGetViewValues(con->viewV);

  double result = 0.;
  switch(con->base.dimensions){
  case 2: result = naLengthV2d(valuesV); break;
  case 3: result = naLengthV3d(valuesV); break;
  case 4: result = naLengthV4d(valuesV); break;
  }

  matSetViewValues(con->viewL, &result);
  matUpdateVLengthController(&con->base);
}



MATBaseController* matAllocVLengthController(size_t dimensions){
  MATVLengthController* con = naAlloc(MATVLengthController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpVLength,
    matVLengthValueChanged,
    matUpdateVLengthController,
    matUpdateVLengthControllerTabOrder);
  
  double* initVector = naMalloc(dimensions * sizeof(double));
  naZeron(initVector, dimensions * sizeof(double));
  double initScalar[] = {naSqrt(3.)};

  switch(con->base.dimensions){
  case 2:
    naFillV2d(initVector, 1., 1.);
    break;
  case 3:
    naFillV3d(initVector, 1., 1., 1.);
    break;
  case 4:
    naFillV4d(initVector, 1., 1., 1., 1.);
    break;
  }

  con->viewV = matAllocView("v", 1, dimensions, con, initVector);
  con->viewL = matAllocView("|v|", 1, 1, con, initScalar);

  naFree(initVector);

  NASpace* spaceV = matGetViewSpace(con->viewV);
  NASpace* spaceL = matGetViewSpace(con->viewL);
  NASize sizeV = naGetUIElementRect(spaceV).size;
  NASize sizeL = naGetUIElementRect(spaceL).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeV.width + MAT_SIGN_WIDTH + sizeL.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeV.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeV.height - MAT_MATRIX_LABEL_HEIGHT) / 2. + MAT_SIGN_LABEL_SHIFT_Y); 
  
  naAddSpaceChild(con->base.space, spaceV, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceL, naMakePos(marginLeft + sizeV.width + MAT_SIGN_WIDTH, marginBottom));

  con->arrowSignLabel = naNewLabel(MAT_ARROW_SIGN, MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->arrowSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->arrowSignLabel, matGetMathFont());
  naSetLabelHeight(con->arrowSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->base.space, con->arrowSignLabel, naMakePos(marginLeft + sizeV.width, signMarginBottom));

  matSetViewStatus(con->viewV, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewL, MAT_STATUS_RESULT);

  matUpdateVLengthController(&con->base);

  return &con->base;
}



void matDeallocVLengthController(MATBaseController* controller){
  MATVLengthController* con = (MATVLengthController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}



