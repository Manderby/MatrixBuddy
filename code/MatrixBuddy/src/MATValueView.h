
#include "MATCommon.h"
#import "MATComputationView.h"


@interface MATValueView : NSView{
  MATStatus status;
  MATColor color;
  NSTextField* errorText;
  NSTextField* labelText;
  NSButton* copyButton;
  NSButton* pasteButton;
}

- (NSView*)firstResponder;
- (void)valueChanged:(MATTextField*)sender;

- (void)update;

- (NSString*)getString;
- (void)setString:(NSString*)string;

- (void)copy:(NSResponder*) sender;
- (void)paste:(NSResponder*) sender;

- (void)setStatus:(MATStatus)newStatus;
- (void)setPasteEnabled:(NABool)pasteEnabled;
- (void)setLabel:(NSString*)newlabel;
- (void)setAttributedLabel:(NSAttributedString*)newlabel;

- (void)codeChanged:(NSTextField*)sender;

@end

