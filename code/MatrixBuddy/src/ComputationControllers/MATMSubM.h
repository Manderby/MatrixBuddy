
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewM22;
@class MATViewM33;
@class MATViewM44;




@interface MATSubM22M22 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewM22* A;
  IBOutlet MATViewM22* B;
  IBOutlet MATViewM22* C;
}

- (void)valueChanged:(id)sender;
@end




@interface MATSubM33M33 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewM33* A;
  IBOutlet MATViewM33* B;
  IBOutlet MATViewM33* C;
}

- (void)valueChanged:(id)sender;
@end




@interface MATSubM44M44 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewM44* A;
  IBOutlet MATViewM44* B;
  IBOutlet MATViewM44* C;
}

- (void)valueChanged:(id)sender;
@end
