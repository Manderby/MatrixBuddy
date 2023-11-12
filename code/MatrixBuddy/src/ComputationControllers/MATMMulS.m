
#import "MATMMulS.h"
#import "MATApplication.h"

#import "MATViewS.h"
#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


MATDimensions matGetControllerDimensions(void* con){
  NA_UNUSED(con);
  return MAT_DIMENSIONS_3;
}

@implementation MATMulM22S

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
  [s setStatus:MAT_STATUS_NORMAL];
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

  NAMat22d result;
  naMulCompM22d(result, [A values], *[s values]);
  [B setValues:result];
  
  [self update];
}

@end






struct MATMulM33SController{
  NASpace* space;
  MATView* viewA;
  NALabel* mulSignLabel;
  MATView* viewS;
  NALabel* equalSignLabel;
  MATView* viewB;
};

void mulM33SValueChanged(void* controller, void* view){
  NA_UNUSED(view);
  MATMulM33SController* con = (MATMulM33SController*)controller;

  const double* valuesA = matGetViewValues(con->viewA);
  const double* valuesS = matGetViewValues(con->viewS);
  NAMat33d result;

  naMulCompM33d(result, valuesA, *valuesS);
  matSetViewValues(con->viewB, result);

  naUpdateMulM33SController(con);
}

MATMulM33SController* matAllocMulM33SController(){
  MATMulM33SController* con = naAlloc(MATMulM33SController);
  
  con->space = naNewSpace(naMakeSize(700, 200));
  
  NAMat33d initM33;
  naFillM33dWithDiag(initM33, 1);
  double initS[] = {1.};
  con->viewA = matAllocView("A", 3, 3, mulM33SValueChanged, con, initM33);
  con->viewS = matAllocView("s", 1, 1, mulM33SValueChanged, con, initS);
  con->viewB = matAllocView("B", 3, 3, mulM33SValueChanged, con, initM33);
  NASpace* spaceA = matGetViewSpace(con->viewA);
  NASpace* spaceS = matGetViewSpace(con->viewS);
  NASpace* spaceB = matGetViewSpace(con->viewB);
  double marginLeft = 150;
  NASize sizeA = naGetUIElementRect(spaceA).size;
  NASize sizeS = naGetUIElementRect(spaceS).size;
  naAddSpaceChild(con->space, spaceA, naMakePos(marginLeft, 0));
  naAddSpaceChild(con->space, spaceS, naMakePos(marginLeft + sizeA.width + MAT_SIGN_WIDTH, 0));
  naAddSpaceChild(con->space, spaceB, naMakePos(marginLeft + sizeA.width + sizeS.width + 2 * MAT_SIGN_WIDTH, 0));

  con->mulSignLabel = naNewLabel("\u00d7", MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->mulSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->mulSignLabel, matGetMathFont());
  naSetLabelHeight(con->mulSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->space, con->mulSignLabel, naMakePos(marginLeft + sizeA.width, 70));

  con->equalSignLabel = naNewLabel("=", MAT_SIGN_WIDTH);
  naSetLabelTextAlignment(con->equalSignLabel, NA_TEXT_ALIGNMENT_CENTER);
  naSetLabelFont(con->equalSignLabel, matGetMathFont());
  naSetLabelHeight(con->equalSignLabel, MAT_MATRIX_LABEL_HEIGHT);
  naAddSpaceChild(con->space, con->equalSignLabel, naMakePos(marginLeft + sizeA.width + sizeS.width + MAT_SIGN_WIDTH, 70));
  
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



@implementation MATMulM33S

- (void)awakeFromNib{
}



- (NSView*)firstResponder{
//  return [A firstResponder];
  return nil;
}



- (void)update{
//  [B setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
}

@end





@implementation MATMulM44S

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
  [s setStatus:MAT_STATUS_NORMAL];
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

  NAMat44d result;
  naMulCompM44d(result, [A values], *[s values]);
  [B setValues:result];
  
  [self update];
}

@end


