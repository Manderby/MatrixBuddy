
#import "MATMDivS.h"
#import "MATApplication.h"

#import "MATViewS.h"
#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


@implementation MATDivM22S

- (void)awakeFromNib{
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


