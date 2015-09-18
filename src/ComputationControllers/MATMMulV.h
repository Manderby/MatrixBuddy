
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewV2;
@class MATViewV3;
@class MATViewV4;
@class MATViewM22;
@class MATViewM33;
@class MATViewM44;


@interface MATMulM22V2 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewM22*   A;
  IBOutlet MATViewV2*    b;
  IBOutlet MATViewV2*    x;
}

- (void)valueChanged:(id)sender;
@end



@interface MATMulM33V3 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewM33*   A;
  IBOutlet MATViewV3*    b;
  IBOutlet MATViewV3*    x;
}

- (void)valueChanged:(id)sender;
@end



@interface MATMulM44V4 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewM44*   A;
  IBOutlet MATViewV4*    b;
  IBOutlet MATViewV4*    x;
}

- (void)valueChanged:(id)sender;
@end
