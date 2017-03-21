
#import "MATInvertM.h"
#import "MATApplication.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"
#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


@implementation MATInvertM22

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAMat22d initA;
  naFillM22dWithDiag(initA, 1);
  [A setValues:initA];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{

  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setAlignment:NSCenterTextAlignment];
  
  NSDictionary *baseAttributes = @{
      NSFontAttributeName : [[NSFontManager sharedFontManager] fontWithFamily:@"Times New Roman" traits:NSItalicFontMask weight:0 size:24.],
      NSParagraphStyleAttributeName : paragraphStyle
      };
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"A" attributes:baseAttributes];
  
  NSDictionary *exponentAttributes = @{
      NSFontAttributeName : [[NSFontManager sharedFontManager] fontWithFamily:@"Times New Roman" traits:0 weight:0 size:14.],
      NSParagraphStyleAttributeName : paragraphStyle,
      NSBaselineOffsetAttributeName : @(8)
      };
  NSAttributedString *exponentAttributedString = [[NSAttributedString alloc] initWithString:@"-1" attributes:exponentAttributes];
  [attributedString appendAttributedString:exponentAttributedString];

  if(computeforward){
    [B setStatus:MAT_STATUS_RESULT];
  }else{
    [A setStatus:MAT_STATUS_RESULT];
  }
  [A setLabel:@"A"];
  [B setAttributedLabel:attributedString];
  [A update];
  [B update];
  
  [paragraphStyle release];
  [exponentAttributedString release];
  [attributedString release];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  if(sender == A){computeforward = NA_TRUE;}
  if(sender == B){computeforward = NA_FALSE;}

  if(computeforward){
    NAMat22d result;
    double det = naDetM22d([A values]);
    if(det == 0.){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillM22dWithDiag(result, 0.);
      [B setValues:result];
    }else if(naAlmostZero(det)){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM22d(result, [A values]);
      [B setValues:result];
    }else{
      [A setStatus:MAT_STATUS_NORMAL];
      naInvM22d(result, [A values]);
      [B setValues:result];
    }
  }else{
    NAMat22d result;
    double det = naDetM22d([B values]);
    if(det == 0.){
      [B setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillM22dWithDiag(result, 0.);
      [A setValues:result];
    }else if(naAlmostZero(det)){
      [B setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM22d(result, [B values]);
      [A setValues:result];
    }else{
      [B setStatus:MAT_STATUS_NORMAL];
      naInvM22d(result, [B values]);
      [A setValues:result];
    }
  }
  
  [self update];
}

@end





@implementation MATInvertM33

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAMat33d initA;
  naFillM33dWithDiag(initA, 1);
  [A setValues:initA];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setAlignment:NSCenterTextAlignment];
  
  NSDictionary *baseAttributes = @{
      NSFontAttributeName : [[NSFontManager sharedFontManager] fontWithFamily:@"Times New Roman" traits:NSItalicFontMask weight:0 size:24.],
      NSParagraphStyleAttributeName : paragraphStyle
      };
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"A" attributes:baseAttributes];
  
  NSDictionary *exponentAttributes = @{
      NSFontAttributeName : [[NSFontManager sharedFontManager] fontWithFamily:@"Times New Roman" traits:0 weight:0 size:14.],
      NSParagraphStyleAttributeName : paragraphStyle,
      NSBaselineOffsetAttributeName : @(8)
      };
  NSAttributedString *exponentAttributedString = [[NSAttributedString alloc] initWithString:@"-1" attributes:exponentAttributes];
  [attributedString appendAttributedString:exponentAttributedString];

  if(computeforward){
    [B setStatus:MAT_STATUS_RESULT];
  }else{
    [A setStatus:MAT_STATUS_RESULT];
  }
  [A setLabel:@"A"];
  [B setAttributedLabel:attributedString];
  [A update];
  [B update];

  [paragraphStyle release];
  [exponentAttributedString release];
  [attributedString release];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  if(sender == A){computeforward = NA_TRUE;}
  if(sender == B){computeforward = NA_FALSE;}

  if(computeforward){
    NAMat33d result;
    double det = naDetM33d([A values]);
    if(det == 0.){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillM33dWithDiag(result, 0.);
      [B setValues:result];
    }else if(naAlmostZero(det)){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM33d(result, [A values]);
      [B setValues:result];
    }else{
      [A setStatus:MAT_STATUS_NORMAL];
      naInvM33d(result, [A values]);
      [B setValues:result];
    }
  }else{
    NAMat33d result;
    double det = naDetM33d([B values]);
    if(det == 0.){
      [B setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillM33dWithDiag(result, 0.);
      [A setValues:result];
    }else if(naAlmostZero(det)){
      [B setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM33d(result, [B values]);
      [A setValues:result];
    }else{
      [B setStatus:MAT_STATUS_NORMAL];
      naInvM33d(result, [B values]);
      [A setValues:result];
    }
  }
  
  [self update];
}

@end





@implementation MATInvertM44

- (void)awakeFromNib{
  computeforward = NA_TRUE;
  NAMat44d initA;
  naFillM44dWithDiag(initA, 1);
  [A setValues:initA];
}



- (NSView*)firstResponder{
  return [A firstResponder];
}



- (void)update{
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setAlignment:NSCenterTextAlignment];
  
  NSDictionary *baseAttributes = @{
      NSFontAttributeName : [[NSFontManager sharedFontManager] fontWithFamily:@"Times New Roman" traits:NSItalicFontMask weight:0 size:24.],
      NSParagraphStyleAttributeName : paragraphStyle
      };
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"A" attributes:baseAttributes];
  
  NSDictionary *exponentAttributes = @{
      NSFontAttributeName : [[NSFontManager sharedFontManager] fontWithFamily:@"Times New Roman" traits:0 weight:0 size:14.],
      NSParagraphStyleAttributeName : paragraphStyle,
      NSBaselineOffsetAttributeName : @(8)
      };
  NSAttributedString *exponentAttributedString = [[NSAttributedString alloc] initWithString:@"-1" attributes:exponentAttributes];
  [attributedString appendAttributedString:exponentAttributedString];

  if(computeforward){
    [B setStatus:MAT_STATUS_RESULT];
  }else{
    [A setStatus:MAT_STATUS_RESULT];
  }
  [A setLabel:@"A"];
  [B setAttributedLabel:attributedString];
  [A update];
  [B update];

  [paragraphStyle release];
  [exponentAttributedString release];
  [attributedString release];
}



- (void)valueChanged:(id)sender{
  NA_UNUSED(sender);

  if(sender == A){computeforward = NA_TRUE;}
  if(sender == B){computeforward = NA_FALSE;}

  if(computeforward){
    NAMat44d result;
    double det = naDetM44d([A values]);
    if(det == 0.){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillM44dWithDiag(result, 0.);
      [B setValues:result];
    }else if(naAlmostZero(det)){
      [A setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM44d(result, [A values]);
      [B setValues:result];
    }else{
      [A setStatus:MAT_STATUS_NORMAL];
      naInvM44d(result, [A values]);
      [B setValues:result];
    }
  }else{
    NAMat44d result;
    double det = naDetM44d([B values]);
    if(det == 0.){
      [B setStatus:MAT_STATUS_MATRIX_DETERMINANT_ZERO];
      naFillM44dWithDiag(result, 0.);
      [A setValues:result];
    }else if(naAlmostZero(det)){
      [B setStatus:MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO];
      naInvM44d(result, [B values]);
      [A setValues:result];
    }else{
      [B setStatus:MAT_STATUS_NORMAL];
      naInvM44d(result, [B values]);
      [A setValues:result];
    }
  }
  
  [self update];
}

@end


