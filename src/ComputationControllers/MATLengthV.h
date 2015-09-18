
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewS;
@class MATViewV2;
@class MATViewV3;
@class MATViewV4;




@interface MATLengthV2 : MATComputationView{
  IBOutlet MATViewV2* v;
  IBOutlet MATViewS* l;
}

- (void)valueChanged:(id)sender;
@end




@interface MATLengthV3 : MATComputationView{
  IBOutlet MATViewV3* v;
  IBOutlet MATViewS* l;
}

- (void)valueChanged:(id)sender;
@end




@interface MATLengthV4 : MATComputationView{
  IBOutlet MATViewV4* v;
  IBOutlet MATViewS* l;
}

- (void)valueChanged:(id)sender;
@end
