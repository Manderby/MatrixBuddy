
#import "MATMSubM.h"
#import "MATApplication.h"

#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


@implementation MATSubM22M22

- (void)awakeFromNib{
  computeforward = NA_TRUE;
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
    NAMat22d result;
    naSubM22d(result, [A values], [B values]);
    [C setValues:result];
  }else{
    NAMat22d result;
    naSubM22d(result, [A values], [C values]);
    [B setValues:result];
  }
  
  [self update];
}

@end





@implementation MATSubM33M33

- (void)awakeFromNib{
  computeforward = NA_TRUE;
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
    NAMat33d result;
    naSubM33d(result, [A values], [B values]);
    [C setValues:result];
  }else{
    NAMat33d result;
    naSubM33d(result, [A values], [C values]);
    [B setValues:result];
  }
  
  [self update];
}

@end





@implementation MATSubM44M44

- (void)awakeFromNib{
  computeforward = NA_TRUE;
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
    NAMat44d result;
    naSubM44d(result, [A values], [B values]);
    [C setValues:result];
  }else{
    NAMat44d result;
    naSubM44d(result, [A values], [C values]);
    [B setValues:result];
  }
  
  [self update];
}

@end


