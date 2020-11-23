
#import "MATNegV.h"
#import "MATApplication.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"


@implementation MATNegV2

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAVec3d inita;
  naFillV2d(inita, 0, 0);
  [a setValues:inita];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  if(computeforward){
    [a setStatus:MAT_STATUS_NORMAL];
    [b setStatus:MAT_STATUS_RESULT];
  }else{
    [a setStatus:MAT_STATUS_RESULT];
    [b setStatus:MAT_STATUS_NORMAL];
  }

  [a setLabel:@"v"];
  [b setLabel:@"-v"];
  [a update];
  [b update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  if(sender == a){computeforward = NA_TRUE;}
  if(sender == b){computeforward = NA_FALSE;}

  if(computeforward){
    NAVec2d result;
    naNegV2d(result, [a values]);
    [b setValues:result];
  }else{
    NAVec2d result;
    naNegV2d(result, [b values]);
    [a setValues:result];
  }
  
  [self update];
}

@end





@implementation MATNegV3

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAVec3d inita;
  naFillV3d(inita, 0, 0, 0);
  [a setValues:inita];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  if(computeforward){
    [a setStatus:MAT_STATUS_NORMAL];
    [b setStatus:MAT_STATUS_RESULT];
  }else{
    [a setStatus:MAT_STATUS_RESULT];
    [b setStatus:MAT_STATUS_NORMAL];
  }

  [a setLabel:@"v"];
  [b setLabel:@"-v"];
  [a update];
  [b update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  if(sender == a){computeforward = NA_TRUE;}
  if(sender == b){computeforward = NA_FALSE;}

  if(computeforward){
    NAVec3d result;
    naNegV3d(result, [a values]);
    [b setValues:result];
  }else{
    NAVec3d result;
    naNegV3d(result, [b values]);
    [a setValues:result];
  }
  
  [self update];
}

@end





@implementation MATNegV4

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAVec4d inita;
  naFillV4d(inita, 0, 0, 0, 0);
  [a setValues:inita];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  if(computeforward){
    [a setStatus:MAT_STATUS_NORMAL];
    [b setStatus:MAT_STATUS_RESULT];
  }else{
    [a setStatus:MAT_STATUS_RESULT];
    [b setStatus:MAT_STATUS_NORMAL];
  }

  [a setLabel:@"v"];
  [b setLabel:@"-v"];
  [a update];
  [b update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  if(sender == a){computeforward = NA_TRUE;}
  if(sender == b){computeforward = NA_FALSE;}

  if(computeforward){
    NAVec4d result;
    naNegV4d(result, [a values]);
    [b setValues:result];
  }else{
    NAVec4d result;
    naNegV4d(result, [b values]);
    [a setValues:result];
  }
  
  [self update];
}

@end


