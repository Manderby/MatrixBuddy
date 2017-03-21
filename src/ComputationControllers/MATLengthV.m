
#import "MATLengthV.h"
#import "MATApplication.h"

#import "MATViewS.h"
#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"


@implementation MATLengthV2

- (void)awakeFromNib{
  NAVec2d initv;
  naFillV2d(initv, 1, 1);
  [v setValues:initv];
}



- (NSView*)firstResponder{
  return [v firstResponder];
}



- (void)update{
  [v setStatus:MAT_STATUS_NORMAL];
  [l setStatus:MAT_STATUS_NORMAL];
  [v setLabel:@"v"];
  [l setLabel:@"|v|"];
  [v update];
  [l update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double result = naLengthV2d([v values]);
  [l setValues:&result];
  
  [self update];
}

@end





@implementation MATLengthV3

- (void)awakeFromNib{
  NAVec3d initv;
  naFillV3d(initv, 1, 1, 1);
  [v setValues:initv];
}



- (NSView*)firstResponder{
  return [v firstResponder];
}



- (void)update{
  [v setStatus:MAT_STATUS_NORMAL];
  [l setStatus:MAT_STATUS_NORMAL];
  [v setLabel:@"v"];
  [l setLabel:@"|v|"];
  [v update];
  [l update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double result = naLengthV3d([v values]);
  [l setValues:&result];
  
  [self update];
}

@end





@implementation MATLengthV4

- (void)awakeFromNib{
  NAVec4d initv;
  naFillV4d(initv, 1, 1, 1, 1);
  [v setValues:initv];
}



- (NSView*)firstResponder{
  return [v firstResponder];
}



- (void)update{
  [v setStatus:MAT_STATUS_NORMAL];
  [l setStatus:MAT_STATUS_NORMAL];
  [v setLabel:@"v"];
  [l setLabel:@"|v|"];
  [v update];
  [l update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double result = naLengthV4d([v values]);
  [l setValues:&result];

  [self update];
}

@end


