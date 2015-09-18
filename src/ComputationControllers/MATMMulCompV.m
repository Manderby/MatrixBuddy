
#import "MATMMulCompV.h"

#import "MATViewV2.h"
#import "MATViewM22.h"
#import "MATViewV3.h"
#import "MATViewM33.h"
#import "MATViewV4.h"
#import "MATViewM44.h"

#import "MATApplication.h"


@implementation MATMulCompM22V2

- (void)awakeFromNib{
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [v setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [v setLabel:@"v"];
  [B setLabel:@"B"];
  [A update];
  [v update];
  [B update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat22d result;
  naMulCompM22dV2d(result, [A values], [v values]);
  [B setValues:result];
  
  [self update];
}

@end





@implementation MATMulCompM33V3

- (void)awakeFromNib{
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [v setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [v setLabel:@"v"];
  [B setLabel:@"B"];
  [A update];
  [v update];
  [B update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat33d result;
  naMulCompM33dV3d(result, [A values], [v values]);
  [B setValues:result];
  
  [self update];
}

@end





@implementation MATMulCompM44V4

- (void)awakeFromNib{
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [v setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [v setLabel:@"v"];
  [B setLabel:@"B"];
  [A update];
  [v update];
  [B update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat44d result;
  naMulCompM44dV4d(result, [A values], [v values]);
  [B setValues:result];
  
  [self update];
}

@end

