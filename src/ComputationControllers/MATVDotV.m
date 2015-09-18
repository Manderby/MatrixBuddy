
#import "MATVDotV.h"
#import "MATApplication.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"


@implementation MATDotV2V2

- (void)awakeFromNib{
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
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double result = naDotV4d([a values], [b values]);
  [s setValues:&result];
  
  [self update];
}

@end


