
#import "MATMMulCompM.h"

#import "MATViewV2.h"
#import "MATViewM22.h"
#import "MATViewV3.h"
#import "MATViewM33.h"
#import "MATViewV4.h"
#import "MATViewM44.h"

#import "MATApplication.h"


@implementation MATMulCompM22M22

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
  [B setStatus:MAT_STATUS_NORMAL];
  [C setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [B setLabel:@"B"];
  [C setLabel:@"C"];
  [A update];
  [B update];
  [C update];
  [C setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat22d result;
  naMulCompM22dM22d(result, [A values], [B values]);
  [C setValues:result];
  
  [self update];
}

@end





@implementation MATMulCompM33M33

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
  [B setStatus:MAT_STATUS_NORMAL];
  [C setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [B setLabel:@"B"];
  [C setLabel:@"C"];
  [A update];
  [B update];
  [C update];
  [C setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat33d result;
  naMulCompM33dM33d(result, [A values], [B values]);
  [C setValues:result];
  
  [self update];
}

@end





@implementation MATMulCompM44M44

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
  [B setStatus:MAT_STATUS_NORMAL];
  [C setStatus:MAT_STATUS_RESULT];
  [A setLabel:@"A"];
  [B setLabel:@"B"];
  [C setLabel:@"C"];
  [A update];
  [B update];
  [C update];
  [C setPasteEnabled:NA_FALSE];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  NAMat44d result;
  naMulCompM44dM44d(result, [A values], [B values]);
  [C setValues:result];
  
  [self update];
}

@end

