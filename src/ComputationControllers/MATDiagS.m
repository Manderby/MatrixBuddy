
#import "MATDiagS.h"
#import "MATApplication.h"

#import "MATViewS.h"
#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


@implementation MATDiagSM22

- (void)awakeFromNib{
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [s firstResponder];
}



- (void)update{
  [s setStatus:MAT_STATUS_NORMAL];
  [A setStatus:MAT_STATUS_RESULT];
  [s setLabel:@"s"];
  [A setLabel:@"A"];
  [s update];
  [A update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat22d result;
  naFillM22dWithDiag(result, *[s values]);
  [A setValues:result];
  
  [self update];
}

@end





@implementation MATDiagSM33

- (void)awakeFromNib{
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [s firstResponder];
}



- (void)update{
  [s setStatus:MAT_STATUS_NORMAL];
  [A setStatus:MAT_STATUS_RESULT];
  [s setLabel:@"s"];
  [A setLabel:@"A"];
  [s update];
  [A update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat33d result;
  naFillM33dWithDiag(result, *[s values]);
  [A setValues:result];
  
  [self update];
}

@end





@implementation MATDiagSM44

- (void)awakeFromNib{
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [s firstResponder];
}



- (void)update{
  [s setStatus:MAT_STATUS_NORMAL];
  [A setStatus:MAT_STATUS_RESULT];
  [s setLabel:@"s"];
  [A setLabel:@"A"];
  [s update];
  [A update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat44d result;
  naFillM44dWithDiag(result, *[s values]);
  [A setValues:result];
  
  [self update];
}

@end


