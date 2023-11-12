
#import "MATNormalizeV.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"

#import "MATApplication.h"


@implementation MATNormalizeV2

- (void)awakeFromNib{
  NAVec2d inita;
  naFillV2d(inita, 1, 0);
  [a setValues:inita];
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [a update];
  [b update];
  [b setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newStatus = MAT_STATUS_NORMAL;
  double len = naLengthV2d([a values]);
  if(len == 0.){newStatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(len)){newStatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [a setStatus:newStatus];
  
  if(newStatus == MAT_STATUS_VECTOR_LENGTH_ZERO){
    NAVec2d result;
    naFillV2d(result, 0., 0.);
    [b setValues:result];
  }else{
    NAVec4d result;
    naNormalizeV2d(result, [a values]);
    [b setValues:result];
  }

  [self update];
}

@end





@implementation MATNormalizeV3

- (void)awakeFromNib{
  NAVec3d inita;
  naFillV3d(inita, 1, 0, 0);
  [a setValues:inita];
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [a update];
  [b update];
  [b setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newStatus = MAT_STATUS_NORMAL;
  double len = naLengthV3d([a values]);
  if(len == 0.){newStatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(len)){newStatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [a setStatus:newStatus];
  
  if(newStatus == MAT_STATUS_VECTOR_LENGTH_ZERO){
    NAVec3d result;
    naFillV3d(result, 0., 0., 0.);
    [b setValues:result];
  }else{
    NAVec3d result;
    naNormalizeV3d(result, [a values]);
    [b setValues:result];
  }
  
  [self update];
}

@end





@implementation MATNormalizeV4

- (void)awakeFromNib{
  NAVec4d inita;
  naFillV4d(inita, 1, 0, 0, 0);
  [a setValues:inita];
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
  [b setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [a update];
  [b update];
  [b setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newStatus = MAT_STATUS_NORMAL;
  double len = naLengthV4d([a values]);
  if(len == 0.){newStatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(len)){newStatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [a setStatus:newStatus];
  
  if(newStatus == MAT_STATUS_VECTOR_LENGTH_ZERO){
    NAVec4d result;
    naFillV4d(result, 0., 0., 0., 0.);
    [b setValues:result];
  }else{
    NAVec4d result;
    naNormalizeV4d(result, [a values]);
    [b setValues:result];
  }
  
  [self update];
}

@end

