
#import "MATViewM44.h"
#import "MATApplication.h"


@implementation MATViewM44



- (void)awakeFromNib{

  [super awakeFromNib];

  #ifndef NDEBUG
    if(([self bounds].size.width != MAT_VIEW_WIDTH_4) || ([self bounds].size.height != MAT_VIEW_HEIGHT_4))
      printf("MATViewM44 view should have size %d x %d\n", MAT_VIEW_WIDTH_4, MAT_VIEW_HEIGHT_4);
  #endif

  NSRect rect;
  rect.size.width = MAT_TEXTFIELD_WIDTH;
  rect.size.height = MAT_TEXTFIELD_HEIGHT;
  
  for(int y=0; y<4; y++){
    rect.origin.y = [self bounds].size.height - y * (MAT_TEXTFIELD_HEIGHT + MAT_TEXTFIELD_SPACE_V) - (MAT_TEXTFIELD_HEIGHT + MAT_VALUE_BORDER) - (MAT_LABEL_HEIGHT + MAT_TOP_SURROUNDING_SPACE_H);
    for(int x=0; x<4; x++){
      rect.origin.x = x * (MAT_TEXTFIELD_WIDTH + MAT_TEXTFIELD_SPACE_H) + MAT_VALUE_BORDER;
      textfields[y*4+x] = [[MATTextField alloc] initWithFrame:rect];
      [textfields[y*4+x] setAction:@selector(valueChanged:)];
      [textfields[y*4+x] setTarget:self];
      [self addSubview:textfields[y*4+x]];
    }
  }
  
// The value will be set by the awakeFromNib method of the computation using
// setValues
//  naFillM44dWithDiag(values, 1.);
//  [self update];
}



- (void)dealloc{
  for(int i=0; i<16; i++){[textfields[i] release];}
  [super dealloc];
}



- (NSView*)firstResponder{
  return textfields[0];
}


- (void)update{
  [super update];
  for(int y=0; y<4; y++){
    for(int x=0; x<4; x++){
      [textfields[y*4+x] setStringValue:[NSString stringWithFormat:@"%f", values[x*4+y]]];
      if([(MATApplication*)NSApp hasRowFirstTabOrder]){
        [textfields[y*4+x] setNextKeyView:textfields[(y*4+x + 1) % 16]];
      }else{
        if(y==4-1 && x==4-1){
          [textfields[y*4+x] setNextKeyView:textfields[0]];
        }else if(y==4-1){
          [textfields[y*4+x] setNextKeyView:textfields[(x + 1) % 16]];
        }else{
          [textfields[y*4+x] setNextKeyView:textfields[(y*4+x + 4) % 16]];
        }
      }
    }
  }


  [codeText setHidden:NO];
  switch([(MATApplication*)NSApp codeStyle]){
  case MAT_CODE_STYLE_C_ROW_FIRST_1D:
    [codeText setStringValue:[NSString stringWithFormat:@"{%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f}", values[0], values[4], values[8], values[12], values[1], values[5], values[9], values[13], values[2], values[6], values[10], values[14], values[3], values[7], values[11], values[15]]];
    break;
  case MAT_CODE_STYLE_C_ROW_FIRST_2D:
    [codeText setStringValue:[NSString stringWithFormat:@"{{%f, %f, %f, %f}, {%f, %f, %f, %f}, {%f, %f, %f, %f}, {%f, %f, %f, %f}}", values[0], values[4], values[8], values[12], values[1], values[5], values[9], values[13], values[2], values[6], values[10], values[14], values[3], values[7], values[11], values[15]]];
    break;
  case MAT_CODE_STYLE_C_COLUMN_FIRST_1D:
    [codeText setStringValue:[NSString stringWithFormat:@"{%f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f, %f}", values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15]]];
    break;
  case MAT_CODE_STYLE_C_COLUMN_FIRST_2D:
    [codeText setStringValue:[NSString stringWithFormat:@"{{%f, %f, %f, %f}, {%f, %f, %f, %f}, {%f, %f, %f, %f}, {%f, %f, %f, %f}}", values[0], values[1], values[2], values[3], values[4], values[5], values[6], values[7], values[8], values[9], values[10], values[11], values[12], values[13], values[14], values[15]]];
    break;
  case MAT_CODE_STYLE_MATHEMATICA:
    [codeText setStringValue:[NSString stringWithFormat:@"{{%f, %f, %f, %f}, {%f, %f, %f, %f}, {%f, %f, %f, %f}, {%f, %f, %f, %f}}", values[0], values[4], values[8], values[12], values[1], values[5], values[9], values[13], values[2], values[6], values[10], values[14], values[3], values[7], values[11], values[15]]];
    break;
  case MAT_CODE_STYLE_MATLAB:
    [codeText setStringValue:[NSString stringWithFormat:@"[%f %f %f %f; %f %f %f %f; %f %f %f %f; %f %f %f %f]", values[0], values[4], values[8], values[12], values[1], values[5], values[9], values[13], values[2], values[6], values[10], values[14], values[3], values[7], values[11], values[15]]];
    break;
  case MAT_CODE_STYLE_MAPLE:
    [codeText setStringValue:[NSString stringWithFormat:@"[[%f, %f, %f, %f], [%f, %f, %f, %f], [%f, %f, %f, %f], [%f, %f, %f, %f]]", values[0], values[4], values[8], values[12], values[1], values[5], values[9], values[13], values[2], values[6], values[10], values[14], values[3], values[7], values[11], values[15]]];
    break;
  case MAT_CODE_STYLE_NONE:
    [codeText setHidden:YES];
    break;
  }
}



- (double*)values{
  return values;
}

- (void)setValues:(NAMat44d)newvalues{
  naCopyM44d(values, newvalues);
  [self update];
}


- (void)valueChanged:(MATTextField*)sender{
  double newvalue = [sender doubleValue];
  for(int y=0; y<4; y++){
    for(int x=0; x<4; x++){
      if(sender == textfields[y*4+x]){
        if(newvalue == values[x*4+y]){
          [textfields[y*4+x] setStringValue:[NSString stringWithFormat:@"%f", values[x*4+y]]];
          return;
        }else{
          values[x*4+y] = newvalue;
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
  NAMat44d newvalues;
  naFillM44dWithDiag(newvalues, 0.);
  int curvalue = 0;
  while(1){
    if(curvalue == 16){break;}
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
    naTransposeM44dS(newvalues);
  }
  
  if(!naEqualM44d(values, newvalues)){
    for(int i=0; i<16; i++){
      values[i] = newvalues[i];
    }
    [(MATComputationView*)[self superview] valueChanged:self];
  }
}


@end


