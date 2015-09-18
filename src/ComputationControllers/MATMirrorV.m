
#import "MATMirrorV.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"

#import "MATApplication.h"


@implementation MATMirrorV2

- (void)awakeFromNib{
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

