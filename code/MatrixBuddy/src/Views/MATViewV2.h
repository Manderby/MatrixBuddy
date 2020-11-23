
#include "MATCommon.h"
#import "MATValueView.h"


@interface MATViewV2 : MATValueView{
  NAVec2d values;
  MATTextField* textfields[2];
}

- (void)update;

- (double*)values;
- (void)setValues:(NAVec2d)newvalues;
- (void)valueChanged:(MATTextField*)sender;

@end

