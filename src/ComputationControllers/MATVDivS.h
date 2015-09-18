
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewS;
@class MATViewV2;
@class MATViewV3;
@class MATViewV4;




@interface MATDivV2S : MATComputationView{
  IBOutlet MATViewV2* a;
  IBOutlet MATViewS* s;
  IBOutlet MATViewV2* b;
}

- (void)valueChanged:(id)sender;
@end




@interface MATDivV3S : MATComputationView{
  IBOutlet MATViewV3* a;
  IBOutlet MATViewS* s;
  IBOutlet MATViewV3* b;
}

- (void)valueChanged:(id)sender;
@end




@interface MATDivV4S : MATComputationView{
  IBOutlet MATViewV4* a;
  IBOutlet MATViewS* s;
  IBOutlet MATViewV4* b;
}

- (void)valueChanged:(id)sender;
@end
