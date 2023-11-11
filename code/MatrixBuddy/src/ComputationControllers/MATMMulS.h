
#include "MATCommon.h"
#import "MATComputationView.h"

#include "MATView.h"

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
  MATView* viewA;
  NALabel* mulSignLabel;
  MATView* viewS;
  NALabel* equalSignLabel;
  MATView* viewB;
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
