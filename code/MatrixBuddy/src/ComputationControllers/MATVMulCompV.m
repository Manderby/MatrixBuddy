
#import "MATVMulCompV.h"
#import "MATApplication.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"


@implementation MATMulCompV2V2

- (void)awakeFromNib{
  NAVec2d inita;
  naFillV2d(inita, 0, 0);
  [a setValues:inita];
  NAVec2d initb;
  naFillV2d(initb, 1, 1);
  [b setValues:initb];
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
  [c setPasteEnabled:NA_FALSE];
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
  NAVec3d inita;
  naFillV3d(inita, 0, 0, 0);
  [a setValues:inita];
  NAVec3d initb;
  naFillV3d(initb, 1, 1, 1);
  [b setValues:initb];
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
  [c setPasteEnabled:NA_FALSE];
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
  NAVec4d inita;
  naFillV4d(inita, 0, 0, 0, 0);
  [a setValues:inita];
  NAVec4d initb;
  naFillV4d(initb, 1, 1, 1, 1);
  [b setValues:initb];
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
  [c setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAVec4d result;
  naMulCompV4dV4d(result, [a values], [b values]);
  [c setValues:result];
  
  [self update];
}

@end


