
#import "MATViewM33.h"
#import "MATApplication.h"


@implementation MATViewM33



- (void)awakeFromNib{

  [super awakeFromNib];

  #ifndef NDEBUG
    if(([self bounds].size.width != MAT_VIEW_WIDTH_3) || ([self bounds].size.height != MAT_VIEW_HEIGHT_3))
      printf("MATViewM33 view should have size %d x %d\n", MAT_VIEW_WIDTH_3, MAT_VIEW_HEIGHT_3);
  #endif

  NSRect rect;
  rect.size.width = MAT_TEXTFIELD_WIDTH;
  rect.size.height = MAT_TEXTFIELD_HEIGHT;
  
  for(int y=0; y<3; y++){
    rect.origin.y = [self bounds].size.height - y * (MAT_TEXTFIELD_HEIGHT + MAT_TEXTFIELD_SPACE_V) - (MAT_TEXTFIELD_HEIGHT + MAT_VALUE_BORDER) - (MAT_LABEL_HEIGHT + MAT_TOP_SURROUNDING_SPACE_H);
    for(int x=0; x<3; x++){
      rect.origin.x = x * (MAT_TEXTFIELD_WIDTH + MAT_TEXTFIELD_SPACE_H) + MAT_VALUE_BORDER;
      textfields[y*3+x] = [[MATTextField alloc] initWithFrame:rect];
      [textfields[y*3+x] setAction:@selector(valueChanged:)];
      [textfields[y*3+x] setTarget:self];
      [self addSubview:textfields[y*3+x]];
    }
  }
  
// The value will be set by the awakeFromNib method of the computation using
// setValues
//  naFillM33dWithDiag(values, 1.);
//  [self update];
}



- (void)dealloc{
  for(int i=0; i<9; i++){[textfields[i] release];}
  [super dealloc];
}



- (NSView*)firstResponder{
  return textfields[0];
}



- (void)update{
  [super update];
  for(int y=0; y<3; y++){
    for(int x=0; x<3; x++){
      [textfields[y*3+x] setStringValue:[NSString stringWithFormat:@"%@", formatValue(values[x*3+y])]];
      if([(MATApplication*)NSApp hasRowFirstTabOrder]){
        [textfields[y*3+x] setNextKeyView:textfields[(y*3+x + 1) % 9]];
      }else{
        if(y==3-1 && x==3-1){
          [textfields[y*3+x] setNextKeyView:textfields[0]];
        }else if(y==3-1){
          [textfields[y*3+x] setNextKeyView:textfields[(x + 1) % 9]];
        }else{
          [textfields[y*3+x] setNextKeyView:textfields[(y*3+x + 3) % 9]];
        }
      }
    }
  }
}



- (double*)values{
  return values;
}

- (void)setValues:(NAMat33d)newvalues{
  naCopyM33d(values, newvalues);
  [self update];
}


- (void)valueChanged:(MATTextField*)sender{
  double newvalue = [sender doubleValue];
  for(int y=0; y<3; y++){
    for(int x=0; x<3; x++){
      if(sender == textfields[y*3+x]){
        if(newvalue == values[x*3+y]){
          [textfields[y*3+x] setStringValue:[NSString stringWithFormat:@"%@", formatValue(values[x*3+y])]];
          return;
        }else{
          values[x*3+y] = newvalue;
          [(MATComputationView*)[self superview] valueChanged:self];
        }
      }
    }
  }
}



- (NSString*)getString{
  switch([(MATApplication*)NSApp codeStyle]){
  case MAT_CODE_STYLE_C_ROW_FIRST_1D:
    return [NSString stringWithFormat:@"{%@, %@, %@, %@, %@, %@, %@, %@, %@}", formatValue(values[0]), formatValue(values[3]), formatValue(values[6]), formatValue(values[1]), formatValue(values[4]), formatValue(values[7]), formatValue(values[2]), formatValue(values[5]), formatValue(values[8])];
    break;
  case MAT_CODE_STYLE_C_ROW_FIRST_2D:
    return [NSString stringWithFormat:@"{{%@, %@, %@}, {%@, %@, %@}, {%@, %@, %@}}", formatValue(values[0]), formatValue(values[3]), formatValue(values[6]), formatValue(values[1]), formatValue(values[4]), formatValue(values[7]), formatValue(values[2]), formatValue(values[5]), formatValue(values[8])];
    break;
  case MAT_CODE_STYLE_C_COLUMN_FIRST_1D:
    return [NSString stringWithFormat:@"{%@, %@, %@, %@, %@, %@, %@, %@, %@}", formatValue(values[0]), formatValue(values[1]), formatValue(values[2]), formatValue(values[3]), formatValue(values[4]), formatValue(values[5]), formatValue(values[6]), formatValue(values[7]), formatValue(values[8])];
    break;
  case MAT_CODE_STYLE_C_COLUMN_FIRST_2D:
    return [NSString stringWithFormat:@"{{%@, %@, %@}, {%@, %@, %@}, {%@, %@, %@}}", formatValue(values[0]), formatValue(values[1]), formatValue(values[2]), formatValue(values[3]), formatValue(values[4]), formatValue(values[5]), formatValue(values[6]), formatValue(values[7]), formatValue(values[8])];
    break;
  case MAT_CODE_STYLE_MATHEMATICA:
    return [NSString stringWithFormat:@"{{%@, %@, %@}, {%@, %@, %@}, {%@, %@, %@}}", formatValue(values[0]), formatValue(values[3]), formatValue(values[6]), formatValue(values[1]), formatValue(values[4]), formatValue(values[7]), formatValue(values[2]), formatValue(values[5]), formatValue(values[8])];
    break;
  case MAT_CODE_STYLE_MATLAB:
    return [NSString stringWithFormat:@"[%@ %@ %@; %@ %@ %@; %@ %@ %@]", formatValue(values[0]), formatValue(values[3]), formatValue(values[6]), formatValue(values[1]), formatValue(values[4]), formatValue(values[7]), formatValue(values[2]), formatValue(values[5]), formatValue(values[8])];
    break;
  case MAT_CODE_STYLE_MAPLE:
    return [NSString stringWithFormat:@"[[%@, %@, %@], [%@, %@, %@], [%@, %@, %@]]", formatValue(values[0]), formatValue(values[3]), formatValue(values[6]), formatValue(values[1]), formatValue(values[4]), formatValue(values[7]), formatValue(values[2]), formatValue(values[5]), formatValue(values[8])];
    break;
  }
}



- (void)setString:(NSString*)string{
  const char* codeStr = [string UTF8String];

  // Strip the first whitespaces and find out if there is a curly bracket. If
  // so, we assume, this is a C code string and will treat the ordering
  // according to the setting.
  NABool mightBeCEncoding = NA_FALSE;
  while((*codeStr != '\0') && (*codeStr <= ' ')){codeStr++;}
  if(*codeStr == '{'){
    mightBeCEncoding = NA_TRUE;
    codeStr++;
  }

  char* newEndPtr;
  NAMat33d newvalues;
  naFillM33dWithDiag(newvalues, 0.);
  int curValue = 0;
  while(1){
    if(curValue == 9){break;}
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
  
  MATCodeStyle codeStyle = [(MATApplication*)NSApp codeStyle];
  if(mightBeCEncoding && ((codeStyle == MAT_CODE_STYLE_C_COLUMN_FIRST_1D) || (codeStyle == MAT_CODE_STYLE_C_COLUMN_FIRST_2D))){
    // The values are expected colum first. And as NALib matrices are stored
    // column first, we do nothing.
  }else{
    // We transform the values to column first ordering.
    naTransposeM33dS(newvalues);
  }
  
  if(!naEqualM33d(values, newvalues)){
    for(int i=0; i<9; i++){
      values[i] = newvalues[i];
    }
    [(MATComputationView*)[self superview] valueChanged:self];
  }
}


@end


