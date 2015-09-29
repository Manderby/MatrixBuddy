
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
  IBOutlet MATViewV2*    x;
  IBOutlet MATViewV2*    b;
}

- (void)valueChanged:(id)sender;
@end



@interface MATMulM33V3 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewM33*   A;
  IBOutlet MATViewV3*    x;
  IBOutlet MATViewV3*    b;
}

- (void)valueChanged:(id)sender;
@end



@interface MATMulM44V4 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewM44*   A;
  IBOutlet MATViewV4*    x;
  IBOutlet MATViewV4*    b;
}

- (void)valueChanged:(id)sender;
@end
