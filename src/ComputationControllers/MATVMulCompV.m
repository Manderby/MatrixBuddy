
#import "MATVMulCompV.h"
#import "MATApplication.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"


@implementation MATMulCompV2V2

- (void)awakeFromNib{
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_NORMAL];
  [c setStatus:MAT_STATUS_RESULT];

  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [c setLabel:@"c"];
  [a update];
  [b update];
  [c update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAVec2d result;
  naMulCompV2dV2d(result, [a values], [b values]);
  [c setValues:result];
  
  [self update];
}

@end





@implementation MATMulCompV3V3

- (void)awakeFromNib{
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_NORMAL];
  [c setStatus:MAT_STATUS_RESULT];

  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [c setLabel:@"c"];
  [a update];
  [b update];
  [c update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAVec3d result;
  naMulCompV3dV3d(result, [a values], [b values]);
  [c setValues:result];
  
  [self update];
}

@end





@implementation MATMulCompV4V4

- (void)awakeFromNib{
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_NORMAL];
  [c setStatus:MAT_STATUS_RESULT];

  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [c setLabel:@"c"];
  [a update];
  [b update];
  [c update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAVec4d result;
  naMulCompV4dV4d(result, [a values], [b values]);
  [c setValues:result];
  
  [self update];
}

@end


