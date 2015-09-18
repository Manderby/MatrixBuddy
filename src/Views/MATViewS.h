
#include "MATCommon.h"
#import "MATValueView.h"


@interface MATViewS : MATValueView{
  double value;
  MATTextField* textfield;
}

- (void)update;

- (double*)values;
- (void)setValues:(NAVec4d)newvalues;
- (void)valueChanged:(MATTextField*)sender;

@end

