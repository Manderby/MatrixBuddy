
#include "MATCommon.h"
#import "MATValueView.h"


@interface MATViewV3 : MATValueView{
  NAVec3d values;
  MATTextField* textfields[3];
}

- (void)update;

- (double*)values;
- (void)setValues:(NAVec3d)newvalues;
- (void)valueChanged:(MATTextField*)sender;

@end

