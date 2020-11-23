
#include "MATCommon.h"
#import "MATComputationView.h"


@interface MATValueView : NSView{
  MATStatus status;
  MATColor color;
  NSTextField* errorText;
  NSTextField* labelText;
  NSTextField* codeText;
}

- (NSView*)firstResponder;
- (void)valueChanged:(MATTextField*)sender;

- (void)update;

- (void)setStatus:(MATStatus)newstatus;
- (void)setLabel:(NSString*)newlabel;
- (void)setAttributedLabel:(NSAttributedString*)newlabel;

- (void)codeChanged:(NSTextField*)sender;

@end

