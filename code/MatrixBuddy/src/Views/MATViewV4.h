
#include "MATCommon.h"
#import "MATValueView.h"


@interface MATViewV4 : MATValueView{
  NAVec4d values;
  MATTextField* textfields[4];
}

- (void)update;

- (double*)values;
- (void)setValues:(NAVec4d)newvalues;
- (void)valueChanged:(MATTextField*)sender;

@end

