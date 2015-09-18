
#import "MATVDivCompV.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"

#import "MATApplication.h"


@implementation MATDivCompV2V2

- (void)awakeFromNib{
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [c setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [c setLabel:@"c"];
  [a update];
  [b update];
  [c update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double* divvalues = [b values];
  for(int i=0; i<2; i++){
    if(divvalues[i] == 0.){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ZERO;
    }else if((newstatus != MAT_STATUS_VECTOR_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [b setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_VECTOR_COMPONENT_ZERO){
    NAVec2d result;
    naFillV2d(result, 0., 0.);
    [c setValues:result];
  }else{
    NAVec2d result;
    naDivCompV2dV2d(result, [a values], divvalues);
    [c setValues:result];
  }

  [self update];
}

@end





@implementation MATDivCompV3V3

- (void)awakeFromNib{
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [c setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [c setLabel:@"c"];
  [a update];
  [b update];
  [c update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double* divvalues = [b values];
  for(int i=0; i<3; i++){
    if(divvalues[i] == 0.){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ZERO;
    }else if((newstatus != MAT_STATUS_VECTOR_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [b setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_VECTOR_COMPONENT_ZERO){
    NAVec3d result;
    naFillV3d(result, 0., 0., 0.);
    [c setValues:result];
  }else{
    NAVec3d result;
    naDivCompV3dV3d(result, [a values], divvalues);
    [c setValues:result];
  }
  
  [self update];
}

@end





@implementation MATDivCompV4V4

- (void)awakeFromNib{
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
  [a setStatus:MAT_STATUS_NORMAL];
  [c setStatus:MAT_STATUS_RESULT];
  [a setLabel:@"a"];
  [b setLabel:@"b"];
  [c setLabel:@"c"];
  [a update];
  [b update];
  [c update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double* divvalues = [b values];
  for(int i=0; i<4; i++){
    if(divvalues[i] == 0.){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ZERO;
    }else if((newstatus != MAT_STATUS_VECTOR_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [b setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_VECTOR_COMPONENT_ZERO){
    NAVec4d result;
    naFillV4d(result, 0., 0., 0., 0.);
    [c setValues:result];
  }else{
    NAVec4d result;
    naDivCompV4dV4d(result, [a values], divvalues);
    [c setValues:result];
  }
  
  [self update];
}

@end

