
#include "MATCommon.h"
#import "MATValueView.h"


@interface MATViewM33 : MATValueView{
  NAMat33d values;
  MATTextField* textfields[9];
}

- (void)update;

- (double*)values;
- (void)setValues:(NAMat33d)newvalues;
- (void)valueChanged:(MATTextField*)sender;

@end

