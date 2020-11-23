
#import "MATValueView.h"
#import "MATApplication.h"


@implementation MATValueView



- (void)awakeFromNib{
  status = MAT_STATUS_NORMAL;

  NSRect rect;
  
  rect.size.width = [self bounds].size.width;
  rect.size.height = MAT_ERRORTEXT_HEIGHT;
  rect.origin.x = 0;
  rect.origin.y = [self bounds].size.height - MAT_LABEL_HEIGHT;
  errorText = [[NSTextField alloc] initWithFrame:rect];
  [errorText setStringValue:@""];
  [errorText setEditable:NO];
  [errorText setBordered:NO];
  [errorText setDrawsBackground:NO];
  [errorText setAlignment:NSCenterTextAlignment];
  [[errorText cell] setLineBreakMode:NSLineBreakByClipping];
  [[errorText cell] setScrollable:YES];
  [self addSubview:errorText];

  rect.size.width = [self bounds].size.width;
  rect.size.height = MAT_LABEL_HEIGHT;
  rect.origin.x = 0;
  rect.origin.y = [self bounds].size.height - MAT_LABEL_HEIGHT - MAT_VALUE_BORDER;
  labelText = [[NSTextField alloc] initWithFrame:rect];
  [labelText setStringValue:@""];
  NSFont* mathfont = [[NSFontManager sharedFontManager] fontWithFamily:@"Times New Roman" traits:NSItalicFontMask weight:0 size:24.];
  [labelText setFont:mathfont];
  [labelText setEditable:NO];
  [labelText setBordered:NO];
  [labelText setDrawsBackground:NO];
  [labelText setAlignment:NSCenterTextAlignment];
  [self addSubview:labelText];

  rect.size.width = [self bounds].size.width - 30;
  rect.size.height = MAT_TEXTFIELD_HEIGHT;
  rect.origin.x = 15;
  rect.origin.y = MAT_VALUE_BORDER;
  codeText = [[NSTextField alloc] initWithFrame:rect];
  [codeText setStringValue:@""];
  NSFont* codefont = [[NSFontManager sharedFontManager] fontWithFamily:@"Menlo" traits:0 weight:0 size:11.];
  [codeText setFont:codefont];
  [codeText setDrawsBackground:NO];
  [codeText setAlignment:NSNaturalTextAlignment];
  [[codeText cell] setLineBreakMode:NSLineBreakByClipping];
  [[codeText cell] setScrollable:YES];
  [[codeText cell] setSendsActionOnEndEditing:YES];
  [codeText setAction:@selector(codeChanged:)];
  [codeText setTarget:self];
  [self addSubview:codeText];

}



- (void)dealloc{
  [errorText release];
  [labelText release];
  [codeText release];
  [super dealloc];
}




- (NSView*)firstResponder{
  // Placeholder. Do not delete.
  return nil;
}



- (void)update{
  if([(MATApplication*)NSApp hasShowIdentifier]){
    [labelText setHidden:NO];
  }else{
    [labelText setHidden:YES];
  }

  switch(status){
  case MAT_STATUS_NORMAL:
    [errorText setHidden:YES];
    color = MAT_COLOR_NORMAL;
    break;
  case MAT_STATUS_RESULT:
    [errorText setHidden:YES];
    color = MAT_COLOR_RESULT;
    break;
  default:
    [labelText setHidden:YES];
    [errorText setHidden:NO];
    [errorText setStringValue:[(MATApplication*)NSApp statusString:status retColor:&color]];
    [errorText setTextColor:[(MATApplication*)NSApp color:color]];
    break;
  }
  [labelText setTextColor:[(MATApplication*)NSApp color:color]];
  
  [self setNeedsDisplay:YES];
}



- (void)drawRect:(NSRect)dirtyRect {
  NA_UNUSED(dirtyRect);
  
  if(color != MAT_COLOR_NORMAL){
    // Fill in background Color
    NSColor* nscolor = [(MATApplication*)NSApp color:color];
    NSColor* backcolor = [NSColor colorWithCalibratedRed:[nscolor redComponent] green:[nscolor greenComponent] blue:[nscolor blueComponent] alpha:0.15];
    
    NSRect rect;
    rect.origin.x = 0;
    rect.origin.y = MAT_BOTTOM_SURROUNDING_SPACE_H + MAT_TEXTFIELD_HEIGHT;
    rect.size.width = [self bounds].size.width;
    rect.size.height = [self bounds].size.height - MAT_VIEW_SURROUNDING_ELEMENTS_HEIGHT;
    
    NSBezierPath *path = [NSBezierPath bezierPath];
    [path appendBezierPathWithRoundedRect:rect xRadius:MAT_VALUE_BORDER yRadius:MAT_VALUE_BORDER];

    [backcolor set];
    [path fill];

//  Will not rund under Snow Leopard:
//
//    CGContextRef context = (CGContextRef) [[NSGraphicsContext currentContext] graphicsPort];
//    CGContextSetRGBFillColor(context, [nscolor redComponent], [nscolor greenComponent], [nscolor blueComponent], 0.1);
//
//    CGRect rect;
//    rect.origin.x = 0;
//    rect.origin.y = MAT_BOTTOM_SURROUNDING_SPACE_H + MAT_TEXTFIELD_HEIGHT;
//    rect.size.width = [self bounds].size.width;
//    rect.size.height = [self bounds].size.height - MAT_VIEW_SURROUNDING_ELEMENTS_HEIGHT;
//
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathAddRoundedRect(path, NULL, rect, MAT_VALUE_BORDER, MAT_VALUE_BORDER);
//    CGContextAddPath(context, path);
//    CGContextFillPath(context);
//    CGPathRelease(path);

  }
}



- (void)valueChanged:(MATTextField*)sender{
  // Placeholder
  NA_UNUSED(sender);
}



- (void)setStatus:(MATStatus)newstatus{
  status = newstatus;
}



- (void)setLabel:(NSString*)newlabel{
  [labelText setStringValue:newlabel];
}


- (void)setAttributedLabel:(NSAttributedString*)newlabel{
  [labelText setAttributedStringValue:newlabel];
}


- (void)codeChanged:(NSTextField*)sender{
  // Placeholder
  NA_UNUSED(sender);
}


@end


