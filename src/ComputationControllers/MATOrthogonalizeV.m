
#import "MATOrthogonalizeV.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"

#import "MATApplication.h"


@implementation MATOrthogonalizeV2

- (void)awakeFromNib{
  NAVec2d inita;
  naFillV2d(inita, 1, 0);
  [a setValues:inita];
  NAVec2d initb;
  naFillV2d(initb, 0, 1);
  [b setValues:initb];
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
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

  MATStatus newastatus = MAT_STATUS_NORMAL;
  double lengtha = naLengthV2d([a values]);
  if(lengtha == 0.){newastatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(lengtha)){newastatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [a setStatus:newastatus];

  MATStatus newbstatus = MAT_STATUS_NORMAL;
  double lengthb = naLengthV2d([b values]);
  if(lengthb == 0.){newbstatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(lengthb)){newbstatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [b setStatus:newbstatus];

  if((newastatus != MAT_STATUS_VECTOR_LENGTH_ZERO) && (newbstatus != MAT_STATUS_VECTOR_LENGTH_ZERO)){
    NAVec2d norma;
    NAVec2d normb;
    NAVec2d diff;
    naNormalizeV2d(norma, [a values]);
    naNormalizeV2d(normb, [b values]);
    naSubV2d(diff, norma, normb);
    double difflen = naLengthV2d(diff);
    if(difflen == 0.){newastatus = MAT_STATUS_VECTORS_COLINEAR;}
    else if(naAlmostZero(difflen)){newastatus = MAT_STATUS_VECTORS_ALMOST_COLINEAR;}
    [a setStatus:newastatus];
  }

  if(newbstatus == MAT_STATUS_VECTOR_LENGTH_ZERO){
    NAVec2d result;
    naFillV2d(result, 0., 0.);
    [b setValues:result];
  }else{
    NAVec2d result;
    naOrthogonalizeV2d(result, [a values], [b values]);
    [c setValues:result];
  }

  [self update];
}

@end





@implementation MATOrthogonalizeV3

- (void)awakeFromNib{
  NAVec3d inita;
  naFillV3d(inita, 1, 0, 0);
  [a setValues:inita];
  NAVec3d initb;
  naFillV3d(initb, 0, 1, 0);
  [b setValues:initb];
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
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

  MATStatus newastatus = MAT_STATUS_NORMAL;
  double lengtha = naLengthV3d([a values]);
  if(lengtha == 0.){newastatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(lengtha)){newastatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [a setStatus:newastatus];

  MATStatus newbstatus = MAT_STATUS_NORMAL;
  double lengthb = naLengthV3d([b values]);
  if(lengthb == 0.){newbstatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(lengthb)){newbstatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [b setStatus:newbstatus];

  if((newastatus != MAT_STATUS_VECTOR_LENGTH_ZERO) && (newbstatus != MAT_STATUS_VECTOR_LENGTH_ZERO)){
    NAVec3d norma;
    NAVec3d normb;
    NAVec3d diff;
    naNormalizeV3d(norma, [a values]);
    naNormalizeV3d(normb, [b values]);
    naSubV3d(diff, norma, normb);
    double difflen = naLengthV3d(diff);
    if(difflen == 0.){newastatus = MAT_STATUS_VECTORS_COLINEAR;}
    else if(naAlmostZero(difflen)){newastatus = MAT_STATUS_VECTORS_ALMOST_COLINEAR;}
    [a setStatus:newastatus];
  }

  if(newbstatus == MAT_STATUS_VECTOR_LENGTH_ZERO){
    NAVec3d result;
    naFillV3d(result, 0., 0., 0.);
    [b setValues:result];
  }else{
    NAVec3d result;
    naOrthogonalizeV3d(result, [a values], [b values]);
    [c setValues:result];
  }

  [self update];
}

@end





@implementation MATOrthogonalizeV4

- (void)awakeFromNib{
  NAVec4d inita;
  naFillV4d(inita, 1, 0, 0, 0);
  [a setValues:inita];
  NAVec4d initb;
  naFillV4d(initb, 0, 1, 0, 0);
  [b setValues:initb];
}


- (NSView*)firstResponder{
  return [a firstResponder];
}


- (void)update{
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

  MATStatus newastatus = MAT_STATUS_NORMAL;
  double lengtha = naLengthV4d([a values]);
  if(lengtha == 0.){newastatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(lengtha)){newastatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [a setStatus:newastatus];

  MATStatus newbstatus = MAT_STATUS_NORMAL;
  double lengthb = naLengthV4d([b values]);
  if(lengthb == 0.){newbstatus = MAT_STATUS_VECTOR_LENGTH_ZERO;}
  else if(naAlmostZero(lengthb)){newbstatus = MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO;}
  [b setStatus:newbstatus];

  if((newastatus != MAT_STATUS_VECTOR_LENGTH_ZERO) && (newbstatus != MAT_STATUS_VECTOR_LENGTH_ZERO)){
    NAVec4d norma;
    NAVec4d normb;
    NAVec4d diff;
    naNormalizeV4d(norma, [a values]);
    naNormalizeV4d(normb, [b values]);
    naSubV4d(diff, norma, normb);
    double difflen = naLengthV4d(diff);
    if(difflen == 0.){newastatus = MAT_STATUS_VECTORS_COLINEAR;}
    else if(naAlmostZero(difflen)){newastatus = MAT_STATUS_VECTORS_ALMOST_COLINEAR;}
    [a setStatus:newastatus];
  }

  if(newbstatus == MAT_STATUS_VECTOR_LENGTH_ZERO){
    NAVec4d result;
    naFillV4d(result, 0., 0., 0., 0.);
    [b setValues:result];
  }else{
    NAVec4d result;
    naOrthogonalizeV4d(result, [a values], [b values]);
    [c setValues:result];
  }

  [self update];
}

@end

