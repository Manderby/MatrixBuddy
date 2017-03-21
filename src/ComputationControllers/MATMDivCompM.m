
#import "MATMDivCompM.h"

#import "MATViewV2.h"
#import "MATViewM22.h"
#import "MATViewV3.h"
#import "MATViewM33.h"
#import "MATViewV4.h"
#import "MATViewM44.h"

#import "MATApplication.h"


@implementation MATDivCompM22M22

- (void)awakeFromNib{
  NAMat22d initA;
  naFillM22dWithDiag(initA, 1);
  [A setValues:initA];
  NAMat22d initB;
  naFillM22dRowFirst(initB, 1, 1, 1, 1);
  [B setValues:initB];
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [C setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [B setLabel:@"B"];
  [C setLabel:@"C"];
  [A update];
  [B update];
  [C update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double* divvalues = [B values];
  for(int i=0; i<4; i++){
    if(divvalues[i] == 0.){
      newstatus = MAT_STATUS_MATRIX_COMPONENT_ZERO;
    }else if((newstatus != MAT_STATUS_MATRIX_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newstatus = MAT_STATUS_MATRIX_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [B setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_MATRIX_COMPONENT_ZERO){
    NAMat22d result;
    naFillM22dWithDiag(result, 0.);
    [C setValues:result];
  }else{
    NAMat22d result;
    naDivCompM22dM22d(result, [A values], divvalues);
    [C setValues:result];
  }
  
  [self update];
}

@end





@implementation MATDivCompM33M33

- (void)awakeFromNib{
  NAMat33d initA;
  naFillM33dWithDiag(initA, 1);
  [A setValues:initA];
  NAMat33d initB;
  naFillM33dRowFirst(initB, 1, 1, 1, 1, 1, 1, 1, 1, 1);
  [B setValues:initB];
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [C setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [B setLabel:@"B"];
  [C setLabel:@"C"];
  [A update];
  [B update];
  [C update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double* divvalues = [B values];
  for(int i=0; i<9; i++){
    if(divvalues[i] == 0.){
      newstatus = MAT_STATUS_MATRIX_COMPONENT_ZERO;
    }else if((newstatus != MAT_STATUS_MATRIX_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newstatus = MAT_STATUS_MATRIX_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [B setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_MATRIX_COMPONENT_ZERO){
    NAMat33d result;
    naFillM33dWithDiag(result, 0.);
    [C setValues:result];
  }else{
    NAMat33d result;
    naDivCompM33dM33d(result, [A values], divvalues);
    [C setValues:result];
  }
  
  [self update];
}

@end





@implementation MATDivCompM44M44

- (void)awakeFromNib{
  NAMat44d initA;
  naFillM44dWithDiag(initA, 1);
  [A setValues:initA];
  NAMat44d initB;
  naFillM44dRowFirst(initB, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
  [B setValues:initB];
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  [A setStatus:MAT_STATUS_NORMAL];
  [C setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [B setLabel:@"B"];
  [C setLabel:@"C"];
  [A update];
  [B update];
  [C update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  MATStatus newstatus = MAT_STATUS_NORMAL;
  double* divvalues = [B values];
  for(int i=0; i<16; i++){
    if(divvalues[i] == 0.){
      newstatus = MAT_STATUS_MATRIX_COMPONENT_ZERO;
    }else if((newstatus != MAT_STATUS_MATRIX_COMPONENT_ZERO) && naAlmostZero(divvalues[i])){
      newstatus = MAT_STATUS_MATRIX_COMPONENT_ALMOST_ZERO;
    }else{
      // everything ok.
    }
  }
  [B setStatus:newstatus];
  
  if(newstatus == MAT_STATUS_MATRIX_COMPONENT_ZERO){
    NAMat44d result;
    naFillM44dWithDiag(result, 0.);
    [C setValues:result];
  }else{
    NAMat44d result;
    naDivCompM44dM44d(result, [A values], divvalues);
    [C setValues:result];
  }
  
  [self update];
}

@end

