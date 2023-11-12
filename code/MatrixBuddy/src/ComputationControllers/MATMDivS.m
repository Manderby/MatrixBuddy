

#import "MATMDivS.h"
#import "MATApplication.h"

#import "MATViewS.h"
#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


@implementation MATDivM22S

- (void)awakeFromNib{
  NAMat22d initA;
  naFillM22dWithDiag(initA, 1);
  [A setValues:initA];
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];

  [A setLabel:@"A"];
  [s setLabel:@"s"];
  [B setLabel:@"B"];
  [A update];
  [s update];
  [B update];
  [B setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double invvalue = *[s values];
  
  if(invvalue == 0){
    [s setStatus:MAT_STATUS_SCALAR_ZERO];
    NAMat22d result;
    naFillM22dWithDiag(result, 0.);
    [B setValues:result];
  }else if(naAlmostZero(invvalue)){
    [s setStatus:MAT_STATUS_SCALAR_ALMOST_ZERO];
    NAMat22d result;
    naMulCompM22d(result, [A values], naInv(invvalue));
    [B setValues:result];
  }else{
    [s setStatus:MAT_STATUS_NORMAL];
    NAMat22d result;
    naMulCompM22d(result, [A values], naInv(invvalue));
    [B setValues:result];
  }
  
  [self update];
}

@end





@implementation MATDivM33S

- (void)awakeFromNib{
  NAMat33d initA;
  naFillM33dWithDiag(initA, 1);
  [A setValues:initA];
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];

  [A setLabel:@"A"];
  [s setLabel:@"s"];
  [B setLabel:@"B"];
  [A update];
  [s update];
  [B update];
  [B setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double invvalue = *[s values];

  if(invvalue == 0){
    [s setStatus:MAT_STATUS_SCALAR_ZERO];
    NAMat33d result;
    naFillM33dWithDiag(result, 0.);
    [B setValues:result];
  }else if(naAlmostZero(invvalue)){
    [s setStatus:MAT_STATUS_SCALAR_ALMOST_ZERO];
    NAMat33d result;
    naMulCompM33d(result, [A values], naInv(invvalue));
    [B setValues:result];
  }else{
    [s setStatus:MAT_STATUS_NORMAL];
    NAMat33d result;
    naMulCompM33d(result, [A values], naInv(invvalue));
    [B setValues:result];
  }
  
  [self update];
}

@end





@implementation MATDivM44S

- (void)awakeFromNib{
  NAMat44d initA;
  naFillM44dWithDiag(initA, 1);
  [A setValues:initA];
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];

  [A setLabel:@"A"];
  [s setLabel:@"s"];
  [B setLabel:@"B"];
  [A update];
  [s update];
  [B update];
  [B setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double invvalue = *[s values];

  if(invvalue == 0){
    [s setStatus:MAT_STATUS_SCALAR_ZERO];
    NAMat44d result;
    naFillM44dWithDiag(result, 0.);
    [B setValues:result];
  }else if(naAlmostZero(invvalue)){
    [s setStatus:MAT_STATUS_SCALAR_ALMOST_ZERO];
    NAMat44d result;
    naMulCompM44d(result, [A values], naInv(invvalue));
    [B setValues:result];
  }else{
    [s setStatus:MAT_STATUS_NORMAL];
    NAMat44d result;
    naMulCompM44d(result, [A values], naInv(invvalue));
    [B setValues:result];
  }
  
  [self update];
}

@end








#include "MATMDivS.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


struct MATMDivSController{
  MATBaseController base;
  MATView* viewA;
  NALabel* divSignLabel;
  MATView* viewS;
  NALabel* equalSignLabel;
  MATView* viewB;
};





void matMDivSValueChanged(MATBaseController* controller, MATView* view){
  NA_UNUSED(view);
  MATMDivSController* con = (MATMDivSController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesS = matGetViewValues(con->viewS);

  size_t elementCount = matGetViewElementCount(con->viewB);
  double* result = naMalloc(elementCount * sizeof(double));
  naZeron(result, elementCount * sizeof(double));

  if(*valuesS == 0){
    matSetViewStatus(con->viewS, MAT_STATUS_SCALAR_ZERO);
  }else{
    double factor = naInv(*valuesS);
    matSetViewStatus(con->viewS, naAlmostZerof((float)*valuesS)
      ? MAT_STATUS_SCALAR_ALMOST_ZERO
      : MAT_STATUS_NORMAL);
    switch(con->base.dimensions){
    case 2: naMulCompM22d(result, valuesA, factor); break;
    case 3: naMulCompM33d(result, valuesA, factor); break;
    case 4: naMulCompM44d(result, valuesA, factor); break;
    }
  }

  matSetViewValues(con->viewB, result);
  matUpdateMDivSController(&con->base);
  naFree(result);
}



void matUpdateMDivSController(MATBaseController* controller){
  MATMDivSController* con = (MATMDivSController*)controller;

  matSetViewPasteEnabled(con->viewB, NA_FALSE);

  matUpdateView(con->viewA);
  matUpdateView(con->viewS);
  matUpdateView(con->viewB);
}



void matUpdateMDivSControllerTabOrder(MATBaseController* controller){
  MATMDivSController* con = (MATMDivSController*)controller;
  matUpdateViewTabOrder(con->viewA);
  matUpdateViewTabOrder(con->viewS);
  matUpdateViewTabOrder(con->viewB);
}



MATBaseController* matAllocMDivSController(size_t dimensions){
  MATMDivSController* con = naAlloc(MATMDivSController);
  
  matInitBaseController(
    &con->base,
    dimensions,
    MATHelpMDivS,
    matMDivSValueChanged,
    matUpdateMDivSController,
    matUpdateMDivSControllerTabOrder);
  
  NAMat22d initM22;
  NAMat33d initM33;
  NAMat44d initM44;
  double* initM = NA_NULL;

  switch(con->base.dimensions){
  case 2:
    naFillM22dWithDiag(initM22, 1);
    initM = initM22;
    break;
  case 3:
    naFillM33dWithDiag(initM33, 1);
    initM = initM33;
    break;
  case 4:
    naFillM44dWithDiag(initM44, 1);
    initM = initM44;
    break;
  }

  double initS[] = {1.};
  con->viewA = matAllocView("A", dimensions, dimensions, con, initM);
  con->viewS = matAllocView("s", 1, 1, con, initS);
  con->viewB = matAllocView("B", dimensions, dimensions, con, initM);

  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceS = matGetViewSpace(con->viewS);
  NASpace* spaceB = matGetViewSpace(con->viewB);
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize sizeS = naGetUIElementRect(spaceS).size;
  NASize sizeB = naGetUIElementRect(spaceB).size;
  NASize viewSize = naGetUIElementRect(con->base.space).size;
  
  double marginLeft = naRound((viewSize.width - (sizeA.width + MAT_SIGN_WIDTH + sizeS.width + MAT_SIGN_WIDTH + sizeB.width)) / 2.);
  double marginBottom = naRound((viewSize.height - sizeA.height) / 2.);
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2.); 
  
  naAddSpaceChild(con->base.space, spaceA, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceS, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, marginBottom));
  naAddSpaceChild(con->base.space, spaceB, naMakePos(marginLeft + sizeA.width + sizeS.width + 2 * MAT_SIGN_WIDTH, marginBottom));

  con->divSignLabel = naNewLabel(MA_DIVISION_SIGN, MAT_SIGN_WIDTH);
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
  matSetViewStatus(con->viewS, MAT_STATUS_NORMAL);
  matSetViewStatus(con->viewB, MAT_STATUS_RESULT);

  matUpdateMDivSController(&con->base);

  return &con->base;
}



void matDeallocMDivSController(MATBaseController* controller){
  MATMDivSController* con = (MATMDivSController*)controller;
  NA_UNUSED(con);
  naFree(controller);
}





