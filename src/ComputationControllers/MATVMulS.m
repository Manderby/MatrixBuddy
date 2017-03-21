
#import "MATVMulS.h"
#import "MATApplication.h"

#import "MATViewS.h"
#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"


@implementation MATMulV2S

- (void)awakeFromNib{
  NAVec2d inita;
  naFillV2d(inita, 0, 0);
  [a setValues:inita];
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [s setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [s setLabel:@"s"];
  [b setLabel:@"b"];
  [a update];
  [s update];
  [b update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAVec2d result;
  naMulV2d(result, [a values], *[s values]);
  [b setValues:result];
  
  [self update];
}

@end





@implementation MATMulV3S

- (void)awakeFromNib{
  NAVec3d inita;
  naFillV3d(inita, 0, 0, 0);
  [a setValues:inita];
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [s setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [s setLabel:@"s"];
  [b setLabel:@"b"];
  [a update];
  [s update];
  [b update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAVec3d result;
  naMulV3d(result, [a values], *[s values]);
  [b setValues:result];
  
  [self update];
}

@end





@implementation MATMulV4S

- (void)awakeFromNib{
  NAVec4d inita;
  naFillV4d(inita, 0, 0, 0, 0);
  [a setValues:inita];
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [s setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [s setLabel:@"s"];
  [b setLabel:@"b"];
  [a update];
  [s update];
  [b update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAVec4d result;
  naMulV4d(result, [a values], *[s values]);
  [b setValues:result];

  [self update];
}

@end


