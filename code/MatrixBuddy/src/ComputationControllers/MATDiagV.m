
#import "MATDiagV.h"
#import "MATApplication.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"
#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


@implementation MATDiagV2M22

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
  [A setStatus:MAT_STATUS_RESULT];
  [v setLabel:@"v"];
  [A setLabel:@"A"];
  [v update];
  [A update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat22d result;
  naFillM22dWithDiagV2d(result, [v values]);
  [A setValues:result];
  
  [self update];
}

@end





@implementation MATDiagV3M33

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
  [A setStatus:MAT_STATUS_RESULT];
  [v setLabel:@"v"];
  [A setLabel:@"A"];
  [v update];
  [A update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat33d result;
  naFillM33dWithDiagV3d(result, [v values]);
  [A setValues:result];
  
  [self update];
}

@end





@implementation MATDiagV4M44

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
  [A setStatus:MAT_STATUS_RESULT];
  [v setLabel:@"v"];
  [A setLabel:@"A"];
  [v update];
  [A update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat44d result;
  naFillM44dWithDiagV4d(result, [v values]);
  [A setValues:result];
  
  [self update];
}

@end


