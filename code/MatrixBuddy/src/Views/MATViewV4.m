
#import "MATViewV4.h"
#import "MATApplication.h"


@implementation MATViewV4



- (void)awakeFromNib{

  [super awakeFromNib];

  #ifndef NDEBUG
    if(([self bounds].size.width != MAT_VIEW_WIDTH_1) || ([self bounds].size.height != MAT_VIEW_HEIGHT_4))
      printf("MATViewV4 view should have size %d x %d\n", MAT_VIEW_WIDTH_1, MAT_VIEW_HEIGHT_4);
  #endif

  NSRect rect;
  rect.size.width = MAT_TEXTFIELD_WIDTH;
  rect.size.height = MAT_TEXTFIELD_HEIGHT;
  
  for(int y=0; y<4; y++){
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
//  naFillV4d(values, 0., 0., 0., 0.);  
//  [self update];
}



- (void)dealloc{
  for(int i=0; i<4; i++){[textfields[i] release];}
  [super dealloc];
}



- (NSView*)firstResponder{
  return textfields[0];
}



- (void)update{
  [super update];
  for(int y=0; y<4; y++){
    for(int x=0; x<1; x++){
      [textfields[y*1+x] setStringValue:[NSString stringWithFormat:@"%@", formatValue(values[x*1+y])]];
      [textfields[y*1+x] setNextKeyView:textfields[(y*1+x + 1) % 4]];
    }
  }
}



- (double*)values{
  return values;
}



- (void)setValues:(NAVec4d)newvalues{
  naCopyV4d(values, newvalues);
  [self update];
}



- (void)valueChanged:(MATTextField*)sender{
  double newvalue = [sender doubleValue];
  for(int y=0; y<4; y++){
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
    return [NSString stringWithFormat:@"{%@, %@, %@, %@}", formatValue(values[0]), formatValue(values[1]), formatValue(values[2]), formatValue(values[3])];
    break;
  case MAT_CODE_STYLE_MATHEMATICA:
    return [NSString stringWithFormat:@"{%@, %@, %@, %@}", formatValue(values[0]), formatValue(values[1]), formatValue(values[2]), formatValue(values[3])];
    break;
  case MAT_CODE_STYLE_MATLAB:
    return [NSString stringWithFormat:@"[%@ %@ %@ %@]", formatValue(values[0]), formatValue(values[1]), formatValue(values[2]), formatValue(values[3])];
    break;
  case MAT_CODE_STYLE_MAPLE:
    return [NSString stringWithFormat:@"[%@, %@, %@, %@]", formatValue(values[0]), formatValue(values[1]), formatValue(values[2]), formatValue(values[3])];
    break;
  case MAT_CODE_STYLE_NONE:
    return @"";
    break;
  }
}



- (void)setString:(NSString*)string{
  const char* codestr = [string UTF8String];

  char* newendptr;
  NAVec4d newvalues;
  naFillV4d(newvalues, 0., 0., 0., 0.);
  int curvalue = 0;
  while(1){
    if(curvalue == 4){break;}
    if(*codestr == '\0'){break;}
    newvalues[curvalue] = strtod(codestr, &newendptr);

    if(newendptr == codestr){
      // No conversion found.
      codestr++;
    }else{
      codestr = newendptr;
      curvalue++;
    }
  }
  
  if(!naEqualV4d(values, newvalues)){
    for(int i=0; i<4; i++){
      values[i] = newvalues[i];
    }
    [(MATComputationView*)[self superview] valueChanged:self];
  }
}


@end


