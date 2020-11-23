
#include "MATCommon.h"
#import "MATValueView.h"


@interface MATViewM22 : MATValueView{
  NAMat22d values;
  MATTextField* textfields[4];
}

- (void)update;

- (double*)values;
- (void)setValues:(NAMat22d)newvalues;
- (void)valueChanged:(MATTextField*)sender;

@end

