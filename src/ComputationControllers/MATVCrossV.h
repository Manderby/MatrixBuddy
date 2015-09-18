
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewV2;
@class MATViewV3;
@class MATViewV4;






@interface MATCrossV3V3 : MATComputationView{
  IBOutlet MATViewV3* a;
  IBOutlet MATViewV3* b;
  IBOutlet MATViewV3* c;
}

- (void)valueChanged:(id)sender;
@end


