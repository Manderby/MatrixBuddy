
#import "MATViewS.h"
#import "MATApplication.h"


@implementation MATViewS



- (void)awakeFromNib{

  [super awakeFromNib];

  #ifndef NDEBUG
    if(([self bounds].size.width != MAT_VIEW_WIDTH_1) || ([self bounds].size.height != MAT_VIEW_HEIGHT_1))
      printf("MATViewS view should have size %d x %d\n", MAT_VIEW_WIDTH_1, MAT_VIEW_HEIGHT_1);
  #endif

  NSRect rect;
  rect.size.width = MAT_TEXTFIELD_WIDTH;
  rect.size.height = MAT_TEXTFIELD_HEIGHT;
  
  rect.origin.y = [self bounds].size.height - 0 * (MAT_TEXTFIELD_HEIGHT + MAT_TEXTFIELD_SPACE_V) - (MAT_TEXTFIELD_HEIGHT + MAT_VALUE_BORDER) - (MAT_LABEL_HEIGHT + MAT_TOP_SURROUNDING_SPACE_H);
  rect.origin.x = 0 * (MAT_TEXTFIELD_WIDTH + MAT_TEXTFIELD_SPACE_H) + MAT_VALUE_BORDER;
  textfield = [[MATTextField alloc] initWithFrame:rect];
  [textfield setAction:@selector(valueChanged:)];
  [textfield setTarget:self];
  [self addSubview:textfield];
  
// The value will be set by the awakeFromNib method of the computation using
// setValues
// value = 1.;  
//  [self update];
}



- (void)dealloc{
  for(int i=0; i<1; i++){[textfield release];}
  [super dealloc];
}



- (NSView*)firstResponder{
  return textfield;
}



- (void)update{
  [super update];
  [textfield setStringValue:[self getString]];
  [textfield setNextKeyView:textfield];
}



- (double*)values{
  return &value;
}



- (void)setValues:(double*)newvalues{
  value = *newvalues;
  [self update];
}



- (void)valueChanged:(MATTextField*)sender{
  double newvalue = [sender doubleValue];
  for(int y=0; y<1; y++){
    for(int x=0; x<1; x++){
      if(sender == textfield){
        if(newvalue == value){
          [textfield setStringValue:[NSString stringWithFormat:@"%@", formatValue(value)]];
        }else{
          value = newvalue;
          [(MATComputationView*)[self superview] valueChanged:self];
        }
        return;
      }
    }
  }
}



- (NSString*)getString{
  return [NSString stringWithFormat:@"%@", formatValue(value)];
}



- (void)setString:(NSString*)string{
  const char* codeStr = [string UTF8String];

  char* newEndPtr;
  double newValue = 0.;
  NAVec2d newvalues;
  int curValue = 0;
  while(1){
    if(curValue == 1){break;}
    if(*codeStr == '\0'){break;}
    newvalues[curValue] = strtod(codeStr, &newEndPtr);

    if(newEndPtr == codeStr){
      // No conversion found.
      codeStr++;
    }else{
      codeStr = newEndPtr;
      curValue++;
    }
  }
  
  if(value != newValue){
    value = newValue;
    [(MATComputationView*)[self superview] valueChanged:self];
  }
}



@end


