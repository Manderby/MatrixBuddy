
#include "MATMMulS.h"
#include "NAMath/NAVectorAlgebra.h"


struct MATMulM33SController{
  size_t dimensions;
  NASpace* space;
  MATView* viewA;
  NALabel* mulSignLabel;
  MATView* viewS;
  NALabel* equalSignLabel;
  MATView* viewB;
};



size_t matGetControllerDimensions(void* controller){
  MATMulM33SController* con = (MATMulM33SController*)controller;
  return con->dimensions;
}



void mulM33SValueChanged(void* controller, void* view){
  NA_UNUSED(view);
  MATMulM33SController* con = (MATMulM33SController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesS = matGetViewValues(con->viewS);

  NAMat22d result2;
  NAMat33d result3;
  NAMat33d result4;

  switch(con->dimensions){
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

  naUpdateMulM33SController(con);
}



MATMulM33SController* matAllocMulM33SController(size_t dimensions){
  MATMulM33SController* con = naAlloc(MATMulM33SController);
  
  con->dimensions = dimensions;
  
  double viewWidth = 991;
  double viewHeight = 197;
  con->space = naNewSpace(naMakeSize(viewWidth, viewHeight));
  
  NAMat22d initM22;
  NAMat33d initM33;
  NAMat44d initM44;

  switch(con->dimensions){
  case 2:
    naFillM22dWithDiag(initM22, 1);
    con->viewA = matAllocView("A", dimensions, dimensions, mulM33SValueChanged, con, initM22);
    con->viewB = matAllocView("B", dimensions, dimensions, mulM33SValueChanged, con, initM22);
    break;
  case 3:
    naFillM33dWithDiag(initM33, 1);
    con->viewA = matAllocView("A", dimensions, dimensions, mulM33SValueChanged, con, initM33);
    con->viewB = matAllocView("B", dimensions, dimensions, mulM33SValueChanged, con, initM33);
    break;
  case 4:
    naFillM44dWithDiag(initM44, 1);
    con->viewA = matAllocView("A", dimensions, dimensions, mulM33SValueChanged, con, initM44);
    con->viewB = matAllocView("B", dimensions, dimensions, mulM33SValueChanged, con, initM44);
    break;
  }

  double initS[] = {1.};
  con->viewS = matAllocView("s", 1, 1, mulM33SValueChanged, con, initS);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceS = matGetViewSpace(con->viewS);
  NASpace* spaceB = matGetViewSpace(con->viewB);
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize sizeS = naGetUIElementRect(spaceS).size;
  NASize sizeB = naGetUIElementRect(spaceB).size;
  
  double marginLeft = naRound((viewWidth - (sizeA.width + MAT_SIGN_WIDTH + sizeS.width + MAT_SIGN_WIDTH + sizeB.width)) / 2.);
  double marginBottom = naRound((viewHeight - sizeA.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2.); 
  
  naAddSpaceChild(con->space, spaceA, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->space, spaceS, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, marginBottom));
  naAddSpaceChild(con->space, spaceB, naMakePos(marginLeft + sizeA.width + sizeS.width + 2 * MAT_SIGN_WIDTH, marginBottom));

  con->mulSignLabel = naNewLabel("\u00d7", MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->mulSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->mulSignLabel, matGetMathFont());
  naSetLabelHeight(con->mulSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->space, con->mulSignLabel, naMakePos(marginLeft + sizeA.width, signMarginBottom));

  con->equalSignLabel = naNewLabel("=", MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeS.width + MAT_SIGN_WIDTH, signMarginBottom));
  
  matUpdateView(con->viewA);
  matUpdateView(con->viewS);
  matUpdateView(con->viewB);

  return con;
}



NASpace* naGetMulM33SSpace(MATMulM33SController* con){
  return con->space;
}



void naUpdateMulM33SController(MATMulM33SController* con){
  matSetViewStatus(con->viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewS, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_RESULT);

  matUpdateView(con->viewB);
}



//@implementation MATMulM33S
//
//- (void)awakeFromNib{
//}
//
//
//
//- (NSView*)firstResponder{
////  return [A firstResponder];
//  return nil;
//}
//
//
//
//- (void)update{
////  [B setPasteEnabled:NA_FALSE];
//}
//
//
//
//- (void)valueChanged:(id)sender{
//}
//
//@end


