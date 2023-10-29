
#import "MATViewV3.h"
#import "MATApplication.h"


@implementation MATViewV3



- (void)awakeFromNib{

  [super awakeFromNib];

  #ifndef NDEBUG
    if(([self bounds].size.width != MAT_VIEW_WIDTH_1) || ([self bounds].size.height != MAT_VIEW_HEIGHT_3))
      printf("MATViewV3 view should have size %d x %d\n", MAT_VIEW_WIDTH_1, MAT_VIEW_HEIGHT_3);
  #endif

  NSRect rect;
  rect.size.width = MAT_TEXTFIELD_WIDTH;
  rect.size.height = MAT_TEXTFIELD_HEIGHT;
  
  for(int y=0; y<3; y++){
    rect.origin.y = [self bounds].size.height - y * (MAT_TEXTFIELD_HEIGHT + MAT_TEXTFIELD_SPACE_V) - (MAT_TEXTFIELD_HEIGHT + MAT_VALUE_BORDER) - (MAT_LABEL_HEIGHT + MAT_TOP_SURROUNDING_SPACE_H);
    for(int x=0; x<1; x++){
      rect.origin.x = x * (MAT_TEXTFIELD_WIDTH + MAT_TEXTFIELD_SPACE_H) + MAT_VALUE_BORDER;
      textfields[y*1+x] = [[MATTextField alloc] initWithFrame:rect];
      [textfields[y*1+x] setAction:@selector(valueChanged:)];
      [textfields[y*1+x] setTarget:self];
      [self addSubview:textfields[y*1+x]];
    }
  }
  
// The value will be set by the awakeFromNib method of the computation using
// setValues
//  naFillV3d(values, 0., 0., 0.);  
//  [self update];
}



- (void)dealloc{
  for(int i=0; i<3; i++){[textfields[i] release];}
  [super dealloc];
}



- (NSView*)firstResponder{
  return textfields[0];
}



- (void)update{
  [super update];
  for(int y=0; y<3; y++){
    for(int x=0; x<1; x++){
      [textfields[y*1+x] setStringValue:[NSString stringWithFormat:@"%@", formatValue(values[x*1+y])]];
      [textfields[y*1+x] setNextKeyView:textfields[(y*1+x + 1) % 3]];
    }
  }
}



- (double*)values{
  return values;
}



- (void)setValues:(NAVec3d)newvalues{
  naCopyV3d(values, newvalues);
  [self update];
}



- (void)valueChanged:(MATTextField*)sender{
  double newvalue = [sender doubleValue];
  for(int y=0; y<3; y++){
    for(int x=0; x<1; x++){
      if(sender == textfields[y*1+x]){
        if(newvalue == values[x*1+y]){
          [textfields[y*1+x] setStringValue:[NSString stringWithFormat:@"%@", formatValue(values[x*1+y])]];
        }else{
          values[x*1+y] = newvalue;
          [(MATComputationView*)[self superview] valueChanged:self];
        }
        return;
      }
    }
  }
}



- (NSString*)getString{
  switch([(MATApplication*)NSApp codeStyle]){
  case MAT_CODE_STYLE_C_ROW_FIRST_1D:
  case MAT_CODE_STYLE_C_ROW_FIRST_2D:
  case MAT_CODE_STYLE_C_COLUMN_FIRST_1D:
  case MAT_CODE_STYLE_C_COLUMN_FIRST_2D:
    return [NSString stringWithFormat:@"{%@, %@, %@}", formatValue(values[0]), formatValue(values[1]), formatValue(values[2])];
    break;
  case MAT_CODE_STYLE_MATHEMATICA:
    return [NSString stringWithFormat:@"{%@, %@, %@}", formatValue(values[0]), formatValue(values[1]), formatValue(values[2])];
    break;
  case MAT_CODE_STYLE_MATLAB:
    return [NSString stringWithFormat:@"[%@ %@ %@]", formatValue(values[0]), formatValue(values[1]), formatValue(values[2])];
    break;
  case MAT_CODE_STYLE_MAPLE:
    return [NSString stringWithFormat:@"[%@, %@, %@]", formatValue(values[0]), formatValue(values[1]), formatValue(values[2])];
    break;
  }
}



- (void)setString:(NSString*)string{
  const char* codeStr = [string UTF8String];

  char* newEndPtr;
  NAVec3d newvalues;
  naFillV3d(newvalues, 0., 0., 0.);
  int curValue = 0;
  while(1){
    if(curValue == 3){break;}
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
  
  if(!naEqualV3d(values, newvalues)){
    for(int i=0; i<3; i++){
      values[i] = newvalues[i];
    }
    [(MATComputationView*)[self superview] valueChanged:self];
  }
}


@end


