
#import "MATMDivCompV.h"

#import "MATViewV2.h"
#import "MATViewM22.h"
#import "MATViewV3.h"
#import "MATViewM33.h"
#import "MATViewV4.h"
#import "MATViewM44.h"

#import "MATApplication.h"


@implementation MATDivCompM22V2

- (void)awakeFromNib{
  NAMat22d initA;
  naFillM22dWithDiag(initA, 1);
  [A setValues:initA];
  NAVec2d initv;
  naFillV2d(initv, 1, 1);
  [v setValues:initv];
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [v setLabel:@"v"];
  [B setLabel:@"B"];
  [A update];
  [v update];
  [B update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double* divvalues = [v values];
  for(int i=0; i<2; i++){
    if(divvalues[i] == 0.){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ZERO;
    }else if((newstatus != MAT_STATUS_VECTOR_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [v setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_VECTOR_COMPONENT_ZERO){
    NAMat22d result;
    naFillM22dWithDiag(result, 0.);
    [B setValues:result];
  }else{
    NAMat22d result;
    naDivCompM22dV2d(result, [A values], divvalues);
    [B setValues:result];
  }
  
  [self update];
}

@end





@implementation MATDivCompM33V3

- (void)awakeFromNib{
  NAMat33d initA;
  naFillM33dWithDiag(initA, 1);
  [A setValues:initA];
  NAVec3d initv;
  naFillV3d(initv, 1, 1, 1);
  [v setValues:initv];
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [v setLabel:@"v"];
  [B setLabel:@"B"];
  [A update];
  [v update];
  [B update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double* divvalues = [v values];
  for(int i=0; i<3; i++){
    if(divvalues[i] == 0.){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ZERO;
    }else if((newstatus != MAT_STATUS_VECTOR_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [v setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_VECTOR_COMPONENT_ZERO){
    NAMat33d result;
    naFillM33dWithDiag(result, 0.);
    [B setValues:result];
  }else{
    NAMat33d result;
    naDivCompM33dV3d(result, [A values], divvalues);
    [B setValues:result];
  }
  
  [self update];
}

@end





@implementation MATDivCompM44V4

- (void)awakeFromNib{
  NAMat44d initA;
  naFillM44dWithDiag(initA, 1);
  [A setValues:initA];
  NAVec4d initv;
  naFillV4d(initv, 1, 1, 1, 1);
  [v setValues:initv];
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [B setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [v setLabel:@"v"];
  [B setLabel:@"B"];
  [A update];
  [v update];
  [B update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double* divvalues = [v values];
  for(int i=0; i<4; i++){
    if(divvalues[i] == 0.){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ZERO;
    }else if((newstatus != MAT_STATUS_VECTOR_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newstatus = MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [v setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_VECTOR_COMPONENT_ZERO){
    NAMat44d result;
    naFillM44dWithDiag(result, 0.);
    [B setValues:result];
  }else{
    NAMat44d result;
    naDivCompM44dV4d(result, [A values], divvalues);
    [B setValues:result];
  }
  
  [self update];
}

@end

