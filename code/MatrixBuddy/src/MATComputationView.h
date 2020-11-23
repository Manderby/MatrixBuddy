
#include "MATCommon.h"


@interface MATComputationView : NSView{

}

- (NSView*)firstResponder;
- (void)update;
- (void)valueChanged:(id)sender;

@end

