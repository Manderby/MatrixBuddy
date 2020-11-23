
#import "MATVDivS.h"
#import "MATApplication.h"

#import "MATViewS.h"
#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"


@implementation MATDivV2S

- (void)awakeFromNib{
  NAVec2d inita;
  naFillV2d(inita, 0, 0);
  [a setValues:inita];
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [s setLabel:@"s"];
  [b setLabel:@"b"];
  [a update];
  [s update];
  [b update];
  [b setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double invvalue = *[s values];

  if(invvalue == 0){
    [s setStatus:MAT_STATUS_SCALAR_ZERO];
    NAVec2d result;
    naFillV2d(result, 0., 0.);
    [b setValues:result];
  }else if(naAlmostZero(invvalue)){
    [s setStatus:MAT_STATUS_SCALAR_ALMOST_ZERO];
    NAVec2d result;
    naMulV2d(result, [a values], naInv(invvalue));
    [b setValues:result];
  }else{
    [s setStatus:MAT_STATUS_NORMAL];
    NAVec2d result;
    naMulV2d(result, [a values], naInv(invvalue));
    [b setValues:result];
  }
  
  [self update];
}

@end





@implementation MATDivV3S

- (void)awakeFromNib{
  NAVec3d inita;
  naFillV3d(inita, 0, 0, 0);
  [a setValues:inita];
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [s setLabel:@"s"];
  [b setLabel:@"b"];
  [a update];
  [s update];
  [b update];
  [b setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double invvalue = *[s values];

  if(invvalue == 0){
    [s setStatus:MAT_STATUS_SCALAR_ZERO];
    NAVec3d result;
    naFillV3d(result, 0., 0., 0.);
    [b setValues:result];
  }else if(naAlmostZero(invvalue)){
    [s setStatus:MAT_STATUS_SCALAR_ALMOST_ZERO];
    NAVec3d result;
    naMulV3d(result, [a values], naInv(invvalue));
    [b setValues:result];
  }else{
    [s setStatus:MAT_STATUS_NORMAL];
    NAVec3d result;
    naMulV3d(result, [a values], naInv(invvalue));
    [b setValues:result];
  }
  
  [self update];
}

@end





@implementation MATDivV4S

- (void)awakeFromNib{
  NAVec4d inita;
  naFillV4d(inita, 0, 0, 0, 0);
  [a setValues:inita];
  double inits = 1.;
  [s setValues:&inits];
}



- (NSView*)firstResponder{
  return [a firstResponder];
}



- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [s setLabel:@"s"];
  [b setLabel:@"b"];
  [a update];
  [s update];
  [b update];
  [b setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  double invvalue = *[s values];

  if(invvalue == 0){
    [s setStatus:MAT_STATUS_SCALAR_ZERO];
    NAVec4d result;
    naFillV4d(result, 0., 0., 0., 0.);
    [b setValues:result];
  }else if(naAlmostZero(invvalue)){
    [s setStatus:MAT_STATUS_SCALAR_ALMOST_ZERO];
    NAVec4d result;
    naMulV4d(result, [a values], naInv(invvalue));
    [b setValues:result];
  }else{
    [s setStatus:MAT_STATUS_NORMAL];
    NAVec4d result;
    naMulV4d(result, [a values], naInv(invvalue));
    [b setValues:result];
  }
  
  [self update];
}

@end


