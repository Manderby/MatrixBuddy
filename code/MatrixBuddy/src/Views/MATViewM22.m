
#import "MATViewM22.h"
#import "MATApplication.h"


@implementation MATViewM22



- (void)awakeFromNib{

  [super awakeFromNib];

  #ifndef NDEBUG
    if(([self bounds].size.width != MAT_VIEW_WIDTH_2) || ([self bounds].size.height != MAT_VIEW_HEIGHT_2))
      printf("MATViewM22 view should have size %d x %d\n", MAT_VIEW_WIDTH_2, MAT_VIEW_HEIGHT_2);
  #endif

  NSRect rect;
  rect.size.width = MAT_TEXTFIELD_WIDTH;
  rect.size.height = MAT_TEXTFIELD_HEIGHT;
  
  for(int y=0; y<2; y++){
    rect.origin.y = [self bounds].size.height - y * (MAT_TEXTFIELD_HEIGHT + MAT_TEXTFIELD_SPACE_V) - (MAT_TEXTFIELD_HEIGHT + MAT_VALUE_BORDER) - (MAT_LABEL_HEIGHT + MAT_TOP_SURROUNDING_SPACE_H);
    for(int x=0; x<2; x++){
      rect.origin.x = x * (MAT_TEXTFIELD_WIDTH + MAT_TEXTFIELD_SPACE_H) + MAT_VALUE_BORDER;
      textfields[y*2+x] = [[MATTextField alloc] initWithFrame:rect];
      [textfields[y*2+x] setAction:@selector(valueChanged:)];
      [textfields[y*2+x] setTarget:self];
      [self addSubview:textfields[y*2+x]];
    }
  }
  
// The value will be set by the awakeFromNib method of the computation using
// setValues
//  naFillM22dWithDiag(values, 1.);
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
  for(int y=0; y<2; y++){
    for(int x=0; x<2; x++){
      [textfields[y*2+x] setStringValue:[NSString stringWithFormat:@"%@", formatValue(values[x*2+y])]];
      if([(MATApplication*)NSApp hasRowFirstTabOrder]){
        [textfields[y*2+x] setNextKeyView:textfields[(y*2+x + 1) % 4]];
      }else{
        if(y==2-1 && x==2-1){
          [textfields[y*2+x] setNextKeyView:textfields[0]];
        }else if(y==2-1){
          [textfields[y*2+x] setNextKeyView:textfields[(x + 1) % 4]];
        }else{
          [textfields[y*2+x] setNextKeyView:textfields[(y*2+x + 2) % 4]];
        }
      }
    }
  }


  [codeText setHidden:NO];
  switch([(MATApplication*)NSApp codeStyle]){
  case MAT_CODE_STYLE_C_ROW_FIRST_1D:
    [codeText setStringValue:[NSString stringWithFormat:@"{%@, %@, %@, %@}", formatValue(values[0]), formatValue(values[2]), formatValue(values[1]), formatValue(values[3])]];
    break;
  case MAT_CODE_STYLE_C_ROW_FIRST_2D:
    [codeText setStringValue:[NSString stringWithFormat:@"{{%@, %@}, {%@, %@}}", formatValue(values[0]), formatValue(values[2]), formatValue(values[1]), formatValue(values[3])]];
    break;
  case MAT_CODE_STYLE_C_COLUMN_FIRST_1D:
    [codeText setStringValue:[NSString stringWithFormat:@"{%@, %@, %@, %@}", formatValue(values[0]), formatValue(values[1]), formatValue(values[2]), formatValue(values[3])]];
    break;
  case MAT_CODE_STYLE_C_COLUMN_FIRST_2D:
    [codeText setStringValue:[NSString stringWithFormat:@"{{%@, %@}, {%@, %@}}", formatValue(values[0]), formatValue(values[1]), formatValue(values[2]), formatValue(values[3])]];
    break;
  case MAT_CODE_STYLE_MATHEMATICA:
    [codeText setStringValue:[NSString stringWithFormat:@"{{%@, %@}, {%@, %@}}", formatValue(values[0]), formatValue(values[2]), formatValue(values[1]), formatValue(values[3])]];
    break;
  case MAT_CODE_STYLE_MATLAB:
    [codeText setStringValue:[NSString stringWithFormat:@"[%@ %@; %@ %@]", formatValue(values[0]), formatValue(values[2]), formatValue(values[1]), formatValue(values[3])]];
    break;
  case MAT_CODE_STYLE_MAPLE:
    [codeText setStringValue:[NSString stringWithFormat:@"[[%@, %@], [%@, %@]]", formatValue(values[0]), formatValue(values[2]), formatValue(values[1]), formatValue(values[3])]];
    break;
  case MAT_CODE_STYLE_NONE:
    [codeText setHidden:YES];
    break;
  }
}



- (double*)values{
  return values;
}

- (void)setValues:(NAMat22d)newvalues{
  naCopyM22d(values, newvalues);
  [self update];
}


- (void)valueChanged:(MATTextField*)sender{
  double newvalue = [sender doubleValue];
  for(int y=0; y<2; y++){
    for(int x=0; x<2; x++){
      if(sender == textfields[y*2+x]){
        if(newvalue == values[x*2+y]){
          [textfields[y*2+x] setStringValue:[NSString stringWithFormat:@"%@", formatValue(values[x*2+y])]];
          return;
        }else{
          values[x*2+y] = newvalue;
          [(MATComputationView*)[self superview] valueChanged:self];
        }
      }
    }
  }
}


- (void)codeChanged:(NSTextField*)sender{
  const char* codestr = [[sender stringValue] UTF8String];

  // Strip the first whitespaces and find out if there is a curly bracket. If
  // so, we assume, this is a C code string and will treat the ordering
  // according to the setting.
  NABool mightbeCcode = NA_FALSE;
  while((*codestr != '\0') && (*codestr <= ' ')){codestr++;}
  if(*codestr == '{'){
    mightbeCcode = NA_TRUE;
    codestr++;
  }

  char* newendptr;
  NAMat22d newvalues;
  naFillM22dWithDiag(newvalues, 0.);
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
  
  MATCodeStyle codeStyle = [(MATApplication*)NSApp codeStyle];
  if(mightbeCcode && ((codeStyle == MAT_CODE_STYLE_C_COLUMN_FIRST_1D) || (codeStyle == MAT_CODE_STYLE_C_COLUMN_FIRST_2D))){
    // The values are expected colum first. And as NALib matrices are stored
    // column first, we do nothing.
  }else{
    // We transform the values to column first ordering.
    naTransposeM22dS(newvalues);
  }
  
  if(!naEqualM22d(values, newvalues)){
    for(int i=0; i<4; i++){
      values[i] = newvalues[i];
    }
    [(MATComputationView*)[self superview] valueChanged:self];
  }
}


@end


