
#include "MATCommon.h"
#import "MATValueView.h"


@interface MATViewM44 : MATValueView{
  NAMat44d values;
  MATTextField* textfields[16];
}

- (void)update;

- (double*)values;
- (void)setValues:(NAMat44d)newvalues;
- (void)valueChanged:(MATTextField*)sender;

@end

