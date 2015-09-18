
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewM22;
@class MATViewM33;
@class MATViewM44;


@interface MATMulCompM22M22 : MATComputationView{
  IBOutlet MATViewM22*   A;
  IBOutlet MATViewM22*   B;
  IBOutlet MATViewM22*   C;
}

- (void)valueChanged:(id)sender;
@end



@interface MATMulCompM33M33 : MATComputationView{
  IBOutlet MATViewM33*   A;
  IBOutlet MATViewM33*   B;
  IBOutlet MATViewM33*   C;
}

- (void)valueChanged:(id)sender;
@end



@interface MATMulCompM44M44 : MATComputationView{
  IBOutlet MATViewM44*   A;
  IBOutlet MATViewM44*   B;
  IBOutlet MATViewM44*   C;
}

- (void)valueChanged:(id)sender;
@end
