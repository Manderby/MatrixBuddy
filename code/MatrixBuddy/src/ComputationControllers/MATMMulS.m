
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



void mulM33SValueChanged(void* con, void* view){
  NA_UNUSED(con);
  NA_UNUSED(view);
  [(MATMulM33S*)con valueChanged: view];
}



@implementation MATMulM33S

- (void)awakeFromNib{
  NAMat33d initM33;
  naFillM33dWithDiag(initM33, 1);
  double initS[] = {1.};
  viewA = matAllocView("A", 3, 3, mulM33SValueChanged, self, initM33);
  viewS = matAllocView("s", 1, 1, mulM33SValueChanged, self, initS);
  viewB = matAllocView("B", 3, 3, mulM33SValueChanged, self, initM33);
  NSView* nsViewA = naGetUIElementNativePtrConst(matGetViewSpace(viewA));
  NSView* nsViewS = naGetUIElementNativePtrConst(matGetViewSpace(viewS));
  NSView* nsViewB = naGetUIElementNativePtrConst(matGetViewSpace(viewB));

  NSRect frame;
  frame = [nsViewA frame];
  frame.origin.x = 0;
  [nsViewA setFrame:frame];
  [self addSubview:nsViewA];
  frame = [nsViewS frame];
  frame.origin.x = 300;
  [nsViewS setFrame:frame];
  [self addSubview:nsViewS];
  frame = [nsViewB frame];
  frame.origin.x = 400;
  [nsViewB setFrame:frame];
  [self addSubview:nsViewB];

  mulSignLabel = naNewLabel("\u00d7", 20);
  equalSignLabel = naNewLabel("=", 20);

  matUpdateView(viewA);
  matUpdateView(viewS);
  matUpdateView(viewB);
}



- (NSView*)firstResponder{
//  return [A firstResponder];
  return nil;
}



- (void)update{
  matSetViewStatus(viewA, MAT_STATUS_NORMAL);
  matSetViewStatus(viewS, MAT_STATUS_NORMAL);
  matSetViewStatus(viewB, MAT_STATUS_RESULT);
  
//  [B setPasteEnabled:NA_FALSE];
  
  matUpdateView(viewB);
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  const double* valuesA = matGetViewValues(viewA);
  const double* valuesS = matGetViewValues(viewS);
  NAMat33d result;

  naMulCompM33d(result, valuesA, *valuesS);
  matSetViewValues(viewB, result);
  
  [self update];
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


