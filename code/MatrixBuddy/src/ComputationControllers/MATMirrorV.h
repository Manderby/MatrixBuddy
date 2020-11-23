
#include "MATCommon.h"
#import "MATComputationView.h"


@class MATViewV2;
@class MATViewV3;
@class MATViewV4;


@interface MATMirrorV2 : MATComputationView{
  IBOutlet MATViewV2*   a;
  IBOutlet MATViewV2*   n;
  IBOutlet MATViewV2*   b;
}

- (void)valueChanged:(id)sender;
@end



@interface MATMirrorV3 : MATComputationView{
  IBOutlet MATViewV3*   a;
  IBOutlet MATViewV3*   n;
  IBOutlet MATViewV3*   b;
}

- (void)valueChanged:(id)sender;
@end



@interface MATMirrorV4 : MATComputationView{
  IBOutlet MATViewV4*   a;
  IBOutlet MATViewV4*   n;
  IBOutlet MATViewV4*   b;
}

- (void)valueChanged:(id)sender;
@end
