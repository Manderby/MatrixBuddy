
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewS;
@class MATViewV2;
@class MATViewV3;
@class MATViewV4;




@interface MATDotV2V2 : MATComputationView{
  IBOutlet MATViewV2* a;
  IBOutlet MATViewV2* b;
  IBOutlet MATViewS* s;
}

- (void)valueChanged:(id)sender;
@end




@interface MATDotV3V3 : MATComputationView{
  IBOutlet MATViewV3* a;
  IBOutlet MATViewV3* b;
  IBOutlet MATViewS* s;
}

- (void)valueChanged:(id)sender;
@end




@interface MATDotV4V4 : MATComputationView{
  IBOutlet MATViewV4* a;
  IBOutlet MATViewV4* b;
  IBOutlet MATViewS* s;
}

- (void)valueChanged:(id)sender;
@end
