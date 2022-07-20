
#import "MATTextField.h"
#import "MATValueView.h"

#include "NAUICocoaLegacy.h"

@implementation MATTextField


-(id)initWithFrame:(NSRect)frameRect{
  self = [super initWithFrame:frameRect];
  [[self cell] setAlignment:NATextAlignmentRight];
  [[self cell] setSendsActionOnEndEditing:YES];
  [[self cell] setLineBreakMode:NSLineBreakByClipping];
  [[self cell] setScrollable:YES];
  return self;
}


- (BOOL)acceptsFirstResponder{
  return YES;
}


@end


