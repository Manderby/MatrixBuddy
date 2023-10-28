
#import "MATMMulS.h"
#import "MATApplication.h"

#import "MATViewS.h"
#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


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
  NAMat33d initA;
  naFillM33dWithDiag(initA, 1);
  [A setValues:initA];
  double inits = 1.;
  [s setValues:&inits];

  viewS = matAllocViewS(mulM33SValueChanged, self);
  [self addSubview:naGetUIElementNativePtrConst(matGetValueViewSpace(viewS))];
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

  double myTestValue = matGetInputMatrixValues(viewS)[0];
  NA_UNUSED(myTestValue);

  NAMat33d result;
  naMulCompM33d(result, [A values], myTestValue);
//  naMulCompM33d(result, [A values], *[s values]);
  [B setValues:result];
  
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


