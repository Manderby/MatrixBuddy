
#import "MATNormalizeV.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"

#import "MATApplication.h"


@implementation MATNormalizeV2

- (void)awakeFromNib{
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
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double len = naLengthV2d([a values]);
  if(len == 0.){newstatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(len)){newstatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [a setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_VECTOR_LENGTH_ZERO){
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
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double len = naLengthV3d([a values]);
  if(len == 0.){newstatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(len)){newstatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [a setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_VECTOR_LENGTH_ZERO){
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
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double len = naLengthV4d([a values]);
  if(len == 0.){newstatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(len)){newstatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [a setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_VECTOR_LENGTH_ZERO){
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

