
#import "MATVAddV.h"
#import "MATApplication.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"


@implementation MATAddV2V2

- (void)awakeFromNib{
  computeforward = NA_TRUE;
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
  if(computeforward){
    [b setStatus:MAT_STATUS_NORMAL];
    [c setStatus:MAT_STATUS_RESULT];
  }else{
    [b setStatus:MAT_STATUS_RESULT];
    [c setStatus:MAT_STATUS_NORMAL];
  }

  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [c setLabel:@"c"];
  [a update];
  [b update];
  [c update];
}



- (void)valueChanged:(id)sender{

  if(sender == b){computeforward = NA_TRUE;}
  if(sender == c){computeforward = NA_FALSE;}

  if(computeforward){
    NAVec2d result;
    naAddV2d(result, [a values], [b values]);
    [c setValues:result];
  }else{
    NAVec2d result;
    naSubV2d(result, [c values], [a values]);
    [b setValues:result];
  }
  
  [self update];
}

@end





@implementation MATAddV3V3

- (void)awakeFromNib{
  computeforward = NA_TRUE;
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
  if(computeforward){
    [b setStatus:MAT_STATUS_NORMAL];
    [c setStatus:MAT_STATUS_RESULT];
  }else{
    [b setStatus:MAT_STATUS_RESULT];
    [c setStatus:MAT_STATUS_NORMAL];
  }

  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [c setLabel:@"c"];
  [a update];
  [b update];
  [c update];
}



- (void)valueChanged:(id)sender{

  if(sender == b){computeforward = NA_TRUE;}
  if(sender == c){computeforward = NA_FALSE;}

  if(computeforward){
    NAVec3d result;
    naAddV3d(result, [a values], [b values]);
    [c setValues:result];
  }else{
    NAVec3d result;
    naSubV3d(result, [c values], [a values]);
    [b setValues:result];
  }
  
  [self update];
}

@end





@implementation MATAddV4V4

- (void)awakeFromNib{
  computeforward = NA_TRUE;
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
  if(computeforward){
    [b setStatus:MAT_STATUS_NORMAL];
    [c setStatus:MAT_STATUS_RESULT];
  }else{
    [b setStatus:MAT_STATUS_RESULT];
    [c setStatus:MAT_STATUS_NORMAL];
  }

  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [c setLabel:@"c"];
  [a update];
  [b update];
  [c update];
}



- (void)valueChanged:(id)sender{

  if(sender == b){computeforward = NA_TRUE;}
  if(sender == c){computeforward = NA_FALSE;}

  if(computeforward){
    NAVec4d result;
    naAddV4d(result, [a values], [b values]);
    [c setValues:result];
  }else{
    NAVec4d result;
    naSubV4d(result, [c values], [a values]);
    [b setValues:result];
  }
  
  [self update];
}

@end


