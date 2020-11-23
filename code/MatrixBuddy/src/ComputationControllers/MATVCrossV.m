
#import "MATVCrossV.h"
#import "MATApplication.h"

#import "MATViewV3.h"



@implementation MATCrossV3V3

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
  naCrossV3d(result, [a values], [b values]);
  [c setValues:result];
  
  [self update];
}

@end


