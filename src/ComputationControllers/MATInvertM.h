
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewM22;
@class MATViewM33;
@class MATViewM44;




@interface MATInvertM22 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewM22* A;
  IBOutlet MATViewM22* B;
}

- (void)valueChanged:(id)sender;
@end




@interface MATInvertM33 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewM33* A;
  IBOutlet MATViewM33* B;
}

- (void)valueChanged:(id)sender;
@end




@interface MATInvertM44 : MATComputationView{
  NABool computeforward;
  IBOutlet MATViewM44* A;
  IBOutlet MATViewM44* B;
}

- (void)valueChanged:(id)sender;
@end
