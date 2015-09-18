
#import "MATTransposeM.h"
#import "MATApplication.h"

#import "MATViewV2.h"
#import "MATViewV3.h"
#import "MATViewV4.h"
#import "MATViewM22.h"
#import "MATViewM33.h"
#import "MATViewM44.h"


@implementation MATTransposeM22

- (void)awakeFromNib{
  computeforward = NA_TRUE;
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
  NSAttributedString *exponentAttributedString = [[NSAttributedString alloc] initWithString:@"T" attributes:exponentAttributes];
  [attributedString appendAttributedString:exponentAttributedString];

  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    [B setStatus:MAT_STATUS_RESULT];
  }else{
    [A setStatus:MAT_STATUS_RESULT];
    [B setStatus:MAT_STATUS_NORMAL];
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
    naTransposeM22d(result, [A values]);
    [B setValues:result];
  }else{
    NAMat22d result;
    naTransposeM22d(result, [B values]);
    [A setValues:result];
  }
  
  [self update];
}

@end





@implementation MATTransposeM33

- (void)awakeFromNib{
  computeforward = NA_TRUE;
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
  NSAttributedString *exponentAttributedString = [[NSAttributedString alloc] initWithString:@"T" attributes:exponentAttributes];
  [attributedString appendAttributedString:exponentAttributedString];

  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    [B setStatus:MAT_STATUS_RESULT];
  }else{
    [A setStatus:MAT_STATUS_RESULT];
    [B setStatus:MAT_STATUS_NORMAL];
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
    naTransposeM33d(result, [A values]);
    [B setValues:result];
  }else{
    NAMat33d result;
    naTransposeM33d(result, [B values]);
    [A setValues:result];
  }
  
  [self update];
}

@end





@implementation MATTransposeM44

- (void)awakeFromNib{
  computeforward = NA_TRUE;
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
  NSAttributedString *exponentAttributedString = [[NSAttributedString alloc] initWithString:@"T" attributes:exponentAttributes];
  [attributedString appendAttributedString:exponentAttributedString];

  if(computeforward){
    [A setStatus:MAT_STATUS_NORMAL];
    [B setStatus:MAT_STATUS_RESULT];
  }else{
    [A setStatus:MAT_STATUS_RESULT];
    [B setStatus:MAT_STATUS_NORMAL];
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
    naTransposeM44d(result, [A values]);
    [B setValues:result];
  }else{
    NAMat44d result;
    naTransposeM44d(result, [B values]);
    [A setValues:result];
  }
  
  [self update];
}

@end


