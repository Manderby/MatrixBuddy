
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewV2;
@class MATViewV3;
@class MATViewV4;
@class MATViewM22;
@class MATViewM33;
@class MATViewM44;




@interface MATDiagV2M22 : MATComputationView{
  IBOutlet MATViewV2* v;
  IBOutlet MATViewM22* A;
}

- (void)valueChanged:(id)sender;
@end




@interface MATDiagV3M33 : MATComputationView{
  IBOutlet MATViewV3* v;
  IBOutlet MATViewM33* A;
}

- (void)valueChanged:(id)sender;
@end




@interface MATDiagV4M44 : MATComputationView{
  IBOutlet MATViewV4* v;
  IBOutlet MATViewM44* A;
}

- (void)valueChanged:(id)sender;
@end
