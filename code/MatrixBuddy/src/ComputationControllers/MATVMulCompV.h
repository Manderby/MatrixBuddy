
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewV2;
@class MATViewV3;
@class MATViewV4;




@interface MATMulCompV2V2 : MATComputationView{
  IBOutlet MATViewV2* a;
  IBOutlet MATViewV2* b;
  IBOutlet MATViewV2* c;
}

- (void)valueChanged:(id)sender;
@end




@interface MATMulCompV3V3 : MATComputationView{
  IBOutlet MATViewV3* a;
  IBOutlet MATViewV3* b;
  IBOutlet MATViewV3* c;
}

- (void)valueChanged:(id)sender;
@end




@interface MATMulCompV4V4 : MATComputationView{
  IBOutlet MATViewV4* a;
  IBOutlet MATViewV4* b;
  IBOutlet MATViewV4* c;
}

- (void)valueChanged:(id)sender;
@end
