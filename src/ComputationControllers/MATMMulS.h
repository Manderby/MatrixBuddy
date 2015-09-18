
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewS;
@class MATViewM22;
@class MATViewM33;
@class MATViewM44;




@interface MATMulM22S : MATComputationView{
  IBOutlet MATViewM22* A;
  IBOutlet MATViewS* s;
  IBOutlet MATViewM22* B;
}

- (void)valueChanged:(id)sender;
@end




@interface MATMulM33S : MATComputationView{
  IBOutlet MATViewM33* A;
  IBOutlet MATViewS* s;
  IBOutlet MATViewM33* B;
}

- (void)valueChanged:(id)sender;
@end




@interface MATMulM44S : MATComputationView{
  IBOutlet MATViewM44* A;
  IBOutlet MATViewS* s;
  IBOutlet MATViewM44* B;
}

- (void)valueChanged:(id)sender;
@end
