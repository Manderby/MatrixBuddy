
#import "MATMDivCompV.h"

#import "MATViewV2.h"
#import "MATViewM22.h"
#import "MATViewV3.h"
#import "MATViewM33.h"
#import "MATViewV4.h"
#import "MATViewM44.h"

#import "MATApplication.h"


@implementation MATDivCompM22V2

- (void)awakeFromNib{
  NAMat22d initA;
  naFillM22dWithDiag(initA, 1);
  [A setValues:initA];
  NAVec2d initv;
  naFillV2d(initv, 1, 1);
  [v setValues:initv];
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [v setLabel:@"v"];
  [B setLabel:@"B"];
  [A update];
  [v update];
  [B update];
  [B setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newStatus = MAT_STATUS_NORMAL;
  double* divvalues = [v values];
  for(int i=0; i<2; i++){
    if(divvalues[i] == 0.){
      newStatus = MAT_STATUS_VECTOR_COMPONENT_ZERO;
    }else if((newStatus != MAT_STATUS_VECTOR_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newStatus = MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [v setStatus:newStatus];
  
  if(newStatus == MAT_STATUS_VECTOR_COMPONENT_ZERO){
    NAMat22d result;
    naFillM22dWithDiag(result, 0.);
    [B setValues:result];
  }else{
    NAMat22d result;
    naDivCompM22dV2d(result, [A values], divvalues);
    [B setValues:result];
  }
  
  [self update];
}

@end





@implementation MATDivCompM33V3

- (void)awakeFromNib{
  NAMat33d initA;
  naFillM33dWithDiag(initA, 1);
  [A setValues:initA];
  NAVec3d initv;
  naFillV3d(initv, 1, 1, 1);
  [v setValues:initv];
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [v setLabel:@"v"];
  [B setLabel:@"B"];
  [A update];
  [v update];
  [B update];
  [B setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newStatus = MAT_STATUS_NORMAL;
  double* divvalues = [v values];
  for(int i=0; i<3; i++){
    if(divvalues[i] == 0.){
      newStatus = MAT_STATUS_VECTOR_COMPONENT_ZERO;
    }else if((newStatus != MAT_STATUS_VECTOR_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newStatus = MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [v setStatus:newStatus];
  
  if(newStatus == MAT_STATUS_VECTOR_COMPONENT_ZERO){
    NAMat33d result;
    naFillM33dWithDiag(result, 0.);
    [B setValues:result];
  }else{
    NAMat33d result;
    naDivCompM33dV3d(result, [A values], divvalues);
    [B setValues:result];
  }
  
  [self update];
}

@end





@implementation MATDivCompM44V4

- (void)awakeFromNib{
  NAMat44d initA;
  naFillM44dWithDiag(initA, 1);
  [A setValues:initA];
  NAVec4d initv;
  naFillV4d(initv, 1, 1, 1, 1);
  [v setValues:initv];
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [v setLabel:@"v"];
  [B setLabel:@"B"];
  [A update];
  [v update];
  [B update];
  [B setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newStatus = MAT_STATUS_NORMAL;
  double* divvalues = [v values];
  for(int i=0; i<4; i++){
    if(divvalues[i] == 0.){
      newStatus = MAT_STATUS_VECTOR_COMPONENT_ZERO;
    }else if((newStatus != MAT_STATUS_VECTOR_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newStatus = MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [v setStatus:newStatus];
  
  if(newStatus == MAT_STATUS_VECTOR_COMPONENT_ZERO){
    NAMat44d result;
    naFillM44dWithDiag(result, 0.);
    [B setValues:result];
  }else{
    NAMat44d result;
    naDivCompM44dV4d(result, [A values], divvalues);
    [B setValues:result];
  }
  
  [self update];
}

@end










#include "MATMDivCompV.h"
#include "MATTranslations.h"
#include "NAMath/NAVectorAlgebra.h"


struct MATMDivCompVController{
  MATBaseController base;
  MATView* viewA;
  NALabel* divSignLabel;
  MATView* viewV;
  NALabel* equalSignLabel;
  MATView* viewB;
};



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
  double signMarginBottom = marginBottom + naRound((sizeA.height - MAT_MATRIX_LABEL_HEIGHT) / 2.); 
  
  naAddSpaceChild(con->base.space, spaceA, naMakePos(marginLeft, marginBottom));
  naAddSpaceChild(con->base.space, spaceS, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, marginBottom));
  naAddSpaceChild(con->base.space, spaceB, naMakePos(marginLeft + sizeA.width + sizeS.width + 2 * MAT_SIGN_WIDTH, marginBottom));

  con->divSignLabel = naNewLabel(MA_DIVISION_CIRCLE_SIGN, MAT_SIGN_WIDTH);
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



