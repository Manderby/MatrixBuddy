
#import "MATMMulS.h"
#import "MATApplication.h"

#import "MATViewS.h"
#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


@implementation MATMulM22S

- (void)awakeFromNib{
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
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat22d result;
  naMulCompM22d(result, [A values], *[s values]);
  [B setValues:result];
  
  [self update];
}

@end





@implementation MATMulM33S

- (void)awakeFromNib{
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
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat33d result;
  naMulCompM33d(result, [A values], *[s values]);
  [B setValues:result];
  
  [self update];
}

@end





@implementation MATMulM44S

- (void)awakeFromNib{
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
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat44d result;
  naMulCompM44d(result, [A values], *[s values]);
  [B setValues:result];
  
  [self update];
}

@end


