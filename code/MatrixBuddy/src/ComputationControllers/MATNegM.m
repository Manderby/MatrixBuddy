
#import "MATNegM.h"
#import "MATApplication.h"

#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


@implementation MATNegM22

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAMat22d initA;
  naFillM22dWithDiag(initA, 0);
  [A setValues:initA];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{
  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    [B setStatus:MAT_STATUS_RESULT];
  }else{
    [A setStatus:MAT_STATUS_RESULT];
    [B setStatus:MAT_STATUS_NORMAL];
  }

  [A setLabel:@"A"];
  [B setLabel:@"-A"];
  [A update];
  [B update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  if(sender == A){computeforward = NA_TRUE;}
  if(sender == B){computeforward = NA_FALSE;}

  if(computeforward){
    NAMat22d result;
    naNegM22d(result, [A values]);
    [B setValues:result];
  }else{
    NAMat22d result;
    naNegM22d(result, [B values]);
    [A setValues:result];
  }
  
  [self update];
}

@end





@implementation MATNegM33

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAMat33d initA;
  naFillM33dWithDiag(initA, 0);
  [A setValues:initA];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{
  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    [B setStatus:MAT_STATUS_RESULT];
  }else{
    [A setStatus:MAT_STATUS_RESULT];
    [B setStatus:MAT_STATUS_NORMAL];
  }

  [A setLabel:@"A"];
  [B setLabel:@"-A"];
  [A update];
  [B update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  if(sender == A){computeforward = NA_TRUE;}
  if(sender == B){computeforward = NA_FALSE;}

  if(computeforward){
    NAMat33d result;
    naNegM33d(result, [A values]);
    [B setValues:result];
  }else{
    NAMat33d result;
    naNegM33d(result, [B values]);
    [A setValues:result];
  }
  
  [self update];
}

@end





@implementation MATNegM44

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAMat44d initA;
  naFillM44dWithDiag(initA, 0);
  [A setValues:initA];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{
  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    [B setStatus:MAT_STATUS_RESULT];
  }else{
    [A setStatus:MAT_STATUS_RESULT];
    [B setStatus:MAT_STATUS_NORMAL];
  }

  [A setLabel:@"A"];
  [B setLabel:@"-A"];
  [A update];
  [B update];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  if(sender == A){computeforward = NA_TRUE;}
  if(sender == B){computeforward = NA_FALSE;}

  if(computeforward){
    NAMat44d result;
    naNegM44d(result, [A values]);
    [B setValues:result];
  }else{
    NAMat44d result;
    naNegM44d(result, [B values]);
    [A setValues:result];
  }
  
  [self update];
}

@end


