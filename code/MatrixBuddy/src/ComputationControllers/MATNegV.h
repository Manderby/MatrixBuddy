
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewV2;
@class MATViewV3;
@class MATViewV4;




@interface MATNegV2 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewV2* a;
  IBOutlet MATViewV2* b;
}

- (void)valueChanged:(id)sender;
@end




@interface MATNegV3 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewV3* a;
  IBOutlet MATViewV3* b;
}

- (void)valueChanged:(id)sender;
@end




@interface MATNegV4 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewV4* a;
  IBOutlet MATViewV4* b;
}

- (void)valueChanged:(id)sender;
@end
