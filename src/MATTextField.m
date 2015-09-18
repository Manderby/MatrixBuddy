
#import "MATTextField.h"
#import "MATValueView.h"


@implementation MATTextField


-(id)initWithFrame:(NSRect)frameRect{
  self = [super initWithFrame:frameRect];
  [[self cell] setAlignment:NSLeftTextAlignment];
  [[self cell] setSendsActionOnEndEditing:YES];
  [[self cell] setLineBreakMode:NSLineBreakByClipping];
  [[self cell] setScrollable:YES];
  return self;
}


- (BOOL)acceptsFirstResponder{
  return YES;
}


@end


