
#import "MATMirrorV.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"

#import "MATApplication.h"


@implementation MATMirrorV2

- (void)awakeFromNib{
  NAVec2d inita;
  naFillV2d(inita, 0, 0);
  [a setValues:inita];
  NAVec2d initn;
  naFillV2d(initn, 1, 0);
  [n setValues:initn];
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [n setLabel:@"n"];
  [b setLabel:@"b"];
  [a update];
  [n update];
  [b update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double length = naLengthV2d([n values]);
  if(naAlmostOnef(length)){     //todo float variatn!
    [n setStatus:MAT_STATUS_NORMAL];
  }else{
    [n setStatus:MAT_STATUS_VECTOR_LENGTH_UNEQUAL_ONE];
  }

  NAVec2d result;
  naMirrorV2d(result, [a values], [n values]);
  [b setValues:result];

  [self update];
}

@end





@implementation MATMirrorV3

- (void)awakeFromNib{
  NAVec3d inita;
  naFillV3d(inita, 0, 0, 0);
  [a setValues:inita];
  NAVec3d initn;
  naFillV3d(initn, 1, 0, 0);
  [n setValues:initn];
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [n setLabel:@"n"];
  [b setLabel:@"b"];
  [a update];
  [n update];
  [b update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double length = naLengthV3d([n values]);
  if(naAlmostOnef(length)){    //todo float variatn!
    [n setStatus:MAT_STATUS_NORMAL];
  }else{
    [n setStatus:MAT_STATUS_VECTOR_LENGTH_UNEQUAL_ONE];
  }

  NAVec3d result;
  naMirrorV3d(result, [a values], [n values]);
  [b setValues:result];

  [self update];
}

@end





@implementation MATMirrorV4

- (void)awakeFromNib{
  NAVec4d inita;
  naFillV4d(inita, 0, 0, 0, 0);
  [a setValues:inita];
  NAVec4d initn;
  naFillV4d(initn, 1, 0, 0, 0);
  [n setValues:initn];
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [n setLabel:@"n"];
  [b setLabel:@"b"];
  [a update];
  [n update];
  [b update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double length = naLengthV4d([n values]);
  if(naAlmostOnef(length)){   //todo float variatn!
    [n setStatus:MAT_STATUS_NORMAL];
  }else{
    [n setStatus:MAT_STATUS_VECTOR_LENGTH_UNEQUAL_ONE];
  }

  NAVec4d result;
  naMirrorV4d(result, [a values], [n values]);
  [b setValues:result];

  [self update];
}

@end

