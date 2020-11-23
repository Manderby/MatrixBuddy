
#import "MATVDotV.h"
#import "MATApplication.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"


@implementation MATDotV2V2

- (void)awakeFromNib{
  NAVec2d inita;
  naFillV2d(inita, 0, 0);
  [a setValues:inita];
  NAVec2d initb;
  naFillV2d(initb, 0, 0);
  [b setValues:initb];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_NORMAL];
  [s setStatus:MAT_STATUS_RESULT];

  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [s setLabel:@"s"];
  [a update];
  [b update];
  [s update];
  [s setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double result = naDotV2d([a values], [b values]);
  [s setValues:&result];
  
  [self update];
}

@end





@implementation MATDotV3V3

- (void)awakeFromNib{
  NAVec3d inita;
  naFillV3d(inita, 0, 0, 0);
  [a setValues:inita];
  NAVec3d initb;
  naFillV3d(initb, 0, 0, 0);
  [b setValues:initb];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_NORMAL];
  [s setStatus:MAT_STATUS_RESULT];

  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [s setLabel:@"s"];
  [a update];
  [b update];
  [s update];
  [s setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double result = naDotV3d([a values], [b values]);
  [s setValues:&result];
  
  [self update];
}

@end





@implementation MATDotV4V4

- (void)awakeFromNib{
  NAVec4d inita;
  naFillV4d(inita, 0, 0, 0, 0);
  [a setValues:inita];
  NAVec4d initb;
  naFillV4d(initb, 0, 0, 0, 0);
  [b setValues:initb];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_NORMAL];
  [s setStatus:MAT_STATUS_RESULT];

  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [s setLabel:@"s"];
  [a update];
  [b update];
  [s update];
  [s setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double result = naDotV4d([a values], [b values]);
  [s setValues:&result];
  
  [self update];
}

@end


