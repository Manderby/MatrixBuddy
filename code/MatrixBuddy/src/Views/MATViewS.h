
#include "MATCommon.h"
#import "MATValueView.h"


@interface MATViewS : MATValueView{
  double value;
  MATTextField* textfield;
}

- (void)update;

- (double*)values;
- (void)setValues:(double*)newvalues;
- (void)valueChanged:(MATTextField*)sender;

@end

