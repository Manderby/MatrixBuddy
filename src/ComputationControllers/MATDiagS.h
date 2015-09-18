
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewS;
@class MATViewM22;
@class MATViewM33;
@class MATViewM44;




@interface MATDiagSM22 : MATComputationView{
  IBOutlet MATViewS* s;
  IBOutlet MATViewM22* A;
}

- (void)valueChanged:(id)sender;
@end




@interface MATDiagSM33 : MATComputationView{
  IBOutlet MATViewS* s;
  IBOutlet MATViewM33* A;
}

- (void)valueChanged:(id)sender;
@end




@interface MATDiagSM44 : MATComputationView{
  IBOutlet MATViewS* s;
  IBOutlet MATViewM44* A;
}

- (void)valueChanged:(id)sender;
@end
