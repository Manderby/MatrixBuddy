
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewV2;
@class MATViewV3;
@class MATViewV4;
@class MATViewM22;
@class MATViewM33;
@class MATViewM44;


@interface MATDivCompM22V2 : MATComputationView{
  IBOutlet MATViewM22*   A;
  IBOutlet MATViewV2*    v;
  IBOutlet MATViewM22*   B;
}

- (void)valueChanged:(id)sender;
@end



@interface MATDivCompM33V3 : MATComputationView{
  IBOutlet MATViewM33*   A;
  IBOutlet MATViewV3*    v;
  IBOutlet MATViewM33*   B;
}

- (void)valueChanged:(id)sender;
@end



@interface MATDivCompM44V4 : MATComputationView{
  IBOutlet MATViewM44*   A;
  IBOutlet MATViewV4*    v;
  IBOutlet MATViewM44*   B;
}

- (void)valueChanged:(id)sender;
@end
