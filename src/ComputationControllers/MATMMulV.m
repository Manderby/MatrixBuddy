
#import "MATMMulV.h"

#import "MATViewV2.h"
#import "MATViewM22.h"
#import "MATViewV3.h"
#import "MATViewM33.h"
#import "MATViewV4.h"
#import "MATViewM44.h"

#import "MATApplication.h"


@implementation MATMulM22V2

- (void)awakeFromNib{
  computeforward = NA_TRUE;
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  if(computeforward){
    [x setStatus:MAT_STATUS_NORMAL];
    [b setStatus:MAT_STATUS_RESULT];
  }else{
    [x setStatus:MAT_STATUS_RESULT];
    [b setStatus:MAT_STATUS_NORMAL];
  }
  [A setLabel:@"A"];
  [x setLabel:@"x"];
  [b setLabel:@"b"];
  [A update];
  [x update];
  [b update];
}



- (void)valueChanged:(id)sender{
  if(sender == x){computeforward = NA_TRUE;}
  if(sender == b){computeforward = NA_FALSE;}

  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    NAMat22d result;
    naMulM22dV2d(result, [A values], [x values]);
    [b setValues:result];
  }else{
    NAMat22d invA;
    NAMat22d result;
    double det = naDetM22d([A values]);
    if(det == 0.){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillV2d(result, 0., 0.);
      [x setValues:result];
    }else if(naAlmostZero(det)){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM22d(invA, [A values]);
      naMulM22dV2d(result, invA, [b values]);
      [x setValues:result];
    }else{
      [A setStatus:MAT_STATUS_NORMAL];
      naInvM22d(invA, [A values]);
      naMulM22dV2d(result, invA, [b values]);
      [x setValues:result];
    }
  }
  
  [self update];
}

@end





@implementation MATMulM33V3

- (void)awakeFromNib{
  computeforward = NA_TRUE;
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  if(computeforward){
    [x setStatus:MAT_STATUS_NORMAL];
    [b setStatus:MAT_STATUS_RESULT];
  }else{
    [x setStatus:MAT_STATUS_RESULT];
    [b setStatus:MAT_STATUS_NORMAL];
  }

  [A setLabel:@"A"];
  [x setLabel:@"x"];
  [b setLabel:@"b"];
  [A update];
  [x update];
  [b update];
}



- (void)valueChanged:(id)sender{
  if(sender == x){computeforward = NA_TRUE;}
  if(sender == b){computeforward = NA_FALSE;}

  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    NAMat33d result;
    naMulM33dV3d(result, [A values], [x values]);
    [b setValues:result];
  }else{
    NAMat33d invA;
    NAMat33d result;
    double det = naDetM33d([A values]);
    if(det == 0.){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillV3d(result, 0., 0., 0.);
      [x setValues:result];
    }else if(naAlmostZero(det)){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM33d(invA, [A values]);
      naMulM33dV3d(result, invA, [b values]);
      [x setValues:result];
    }else{
      [A setStatus:MAT_STATUS_NORMAL];
      naInvM33d(invA, [A values]);
      naMulM33dV3d(result, invA, [b values]);
      [x setValues:result];
    }
  }
  
  [self update];
}

@end





@implementation MATMulM44V4

- (void)awakeFromNib{
  computeforward = NA_TRUE;
}


- (NSView*)firstResponder{
  return [A firstResponder];
}


- (void)update{
  if(computeforward){
    [x setStatus:MAT_STATUS_NORMAL];
    [b setStatus:MAT_STATUS_RESULT];
  }else{
    [x setStatus:MAT_STATUS_RESULT];
    [b setStatus:MAT_STATUS_NORMAL];
  }

  [A setLabel:@"A"];
  [x setLabel:@"x"];
  [b setLabel:@"b"];
  [A update];
  [x update];
  [b update];
}



- (void)valueChanged:(id)sender{
  if(sender == x){computeforward = NA_TRUE;}
  if(sender == b){computeforward = NA_FALSE;}

  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    NAMat44d result;
    naMulM44dV4d(result, [A values], [x values]);
    [b setValues:result];
  }else{
    NAMat44d invA;
    NAMat44d result;
    double det = naDetM44d([A values]);
    if(det == 0.){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillV4d(result, 0., 0., 0., 0.);
      [x setValues:result];
    }else if(naAlmostZero(det)){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM44d(invA, [A values]);
      naMulM44dV4d(result, invA, [b values]);
      [x setValues:result];
    }else{
      [A setStatus:MAT_STATUS_NORMAL];
      naInvM44d(invA, [A values]);
      naMulM44dV4d(result, invA, [b values]);
      [x setValues:result];
    }
  }
  
  [self update];
}

@end

