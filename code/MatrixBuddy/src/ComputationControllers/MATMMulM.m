
#import "MATMMulM.h"
#import "MATApplication.h"

#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


@implementation MATMulM22M22

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAMat22d initA;
  naFillM22dWithDiag(initA, 1);
  [A setValues:initA];
  NAMat22d initB;
  naFillM22dWithDiag(initB, 1);
  [B setValues:initB];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{
  if(computeforward){
    [B setStatus:MAT_STATUS_NORMAL];
    [C setStatus:MAT_STATUS_RESULT];
  }else{
    [B setStatus:MAT_STATUS_RESULT];
    [C setStatus:MAT_STATUS_NORMAL];
  }

  [A setLabel:@"A"];
  [B setLabel:@"B"];
  [C setLabel:@"C"];
  [A update];
  [B update];
  [C update];
}



- (void)valueChanged:(id)sender{

  if(sender == B){computeforward = NA_TRUE;}
  if(sender == C){computeforward = NA_FALSE;}

  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    NAMat22d result;
    naMulM22dM22d(result, [A values], [B values]);
    [C setValues:result];
  }else{
    NAMat22d invA;
    NAMat22d result;
    double det = naDetM22d([A values]);
    if(det == 0.){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillM22dWithDiag(result, 0.);
      [B setValues:result];
    }else if(naAlmostZero(det)){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM22d(invA, [A values]);
      naMulM22dM22d(result, invA, [C values]);
      [B setValues:result];
    }else{
      [A setStatus:MAT_STATUS_NORMAL];
      naInvM22d(invA, [A values]);
      naMulM22dM22d(result, invA, [C values]);
      [B setValues:result];
    }
  }
  
  [self update];
}

@end





@implementation MATMulM33M33

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAMat33d initA;
  naFillM33dWithDiag(initA, 1);
  [A setValues:initA];
  NAMat33d initB;
  naFillM33dWithDiag(initB, 1);
  [B setValues:initB];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{
  if(computeforward){
    [B setStatus:MAT_STATUS_NORMAL];
    [C setStatus:MAT_STATUS_RESULT];
  }else{
    [B setStatus:MAT_STATUS_RESULT];
    [C setStatus:MAT_STATUS_NORMAL];
  }

  [A setLabel:@"A"];
  [B setLabel:@"B"];
  [C setLabel:@"C"];
  [A update];
  [B update];
  [C update];
}



- (void)valueChanged:(id)sender{

  if(sender == B){computeforward = NA_TRUE;}
  if(sender == C){computeforward = NA_FALSE;}

  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    NAMat33d result;
    naMulM33dM33d(result, [A values], [B values]);
    [C setValues:result];
  }else{
    NAMat33d invA;
    NAMat33d result;
    double det = naDetM33d([A values]);
    if(det == 0.){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillM33dWithDiag(result, 0.);
      [B setValues:result];
    }else if(naAlmostZero(det)){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM33d(invA, [A values]);
      naMulM33dM33d(result, invA, [C values]);
      [B setValues:result];
    }else{
      [A setStatus:MAT_STATUS_NORMAL];
      naInvM33d(invA, [A values]);
      naMulM33dM33d(result, invA, [C values]);
      [B setValues:result];
    }
  }
  
  [self update];
}

@end





@implementation MATMulM44M44

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAMat44d initA;
  naFillM44dWithDiag(initA, 1);
  [A setValues:initA];
  NAMat44d initB;
  naFillM44dWithDiag(initB, 1);
  [B setValues:initB];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{
  if(computeforward){
    [B setStatus:MAT_STATUS_NORMAL];
    [C setStatus:MAT_STATUS_RESULT];
  }else{
    [B setStatus:MAT_STATUS_RESULT];
    [C setStatus:MAT_STATUS_NORMAL];
  }

  [A setLabel:@"A"];
  [B setLabel:@"B"];
  [C setLabel:@"C"];
  [A update];
  [B update];
  [C update];
}



- (void)valueChanged:(id)sender{

  if(sender == B){computeforward = NA_TRUE;}
  if(sender == C){computeforward = NA_FALSE;}

  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    NAMat44d result;
    naMulM44dM44d(result, [A values], [B values]);
    [C setValues:result];
  }else{
    NAMat44d invA;
    NAMat44d result;
    double det = naDetM44d([A values]);
    if(det == 0.){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillM44dWithDiag(result, 0.);
      [B setValues:result];
    }else if(naAlmostZero(det)){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM44d(invA, [A values]);
      naMulM44dM44d(result, invA, [C values]);
      [B setValues:result];
    }else{
      [A setStatus:MAT_STATUS_NORMAL];
      naInvM44d(invA, [A values]);
      naMulM44dM44d(result, invA, [C values]);
      [B setValues:result];
    }
  }
  
  [self update];
}

@end


