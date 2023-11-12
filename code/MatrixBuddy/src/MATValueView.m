
#import "MATValueView.h"
#import "MATApplication.h"

#include "NAApp.h"

#include "NAUICocoaLegacy.h"

void naTellNSButtonSetUIImage(void* nsButton, const NAUIImage* uiImage);

#include "NABabyImage.h"

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
  [errorText setAlignment:NATextAlignmentCenter];
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
  [labelText setAlignment:NATextAlignmentCenter];
  [self addSubview:labelText];

  rect.size.width = 44;
  rect.size.height = MAT_TEXTFIELD_HEIGHT;
  rect.origin.x = [self bounds].size.width / 2 - 44;
  rect.origin.y = MAT_VALUE_BORDER;
  copyButton = [[NSButton alloc] initWithFrame:rect];
  [copyButton setTitle:@"C"];
  [copyButton setImage:[NSImage imageNamed:@"copy.png"]];
  [copyButton setImageScaling:NSImageScaleProportionallyDown];
  [copyButton setBezelStyle:NSBezelStyleRounded];
  [copyButton setButtonType:NSButtonTypeMomentaryPushIn];
  [copyButton setTarget:self];
  [copyButton setAction:@selector(copy:)];
  [copyButton setShowsBorderOnlyWhileMouseInside:YES];

  NAString* copyImagePath = naNewApplicationResourcePath(NA_NULL, "copy", "png");
  NABabyImage* mainCopyImage = naCreateBabyImageFromFilePath(naGetStringUTF8Pointer(copyImagePath));
  NAUIImage* copyImage = naCreateUIImage(mainCopyImage, NA_UIIMAGE_RESOLUTION_SCREEN_2x, NA_BLEND_ERODE_LIGHT);
  //naTellNSButtonSetUIImage(copyButton, copyImage);
  naRelease(copyImage);
  
  [self addSubview:copyButton];

  rect.size.width = 44;
  rect.size.height = MAT_TEXTFIELD_HEIGHT;
  rect.origin.x = [self bounds].size.width / 2 + 0;
  rect.origin.y = MAT_VALUE_BORDER;
  pasteButton = [[NSButton alloc] initWithFrame:rect];
  [pasteButton setTitle:@"P"];
  [pasteButton setImage:[NSImage imageNamed:@"paste.png"]];
  [pasteButton setImageScaling:NSImageScaleProportionallyDown];
  [pasteButton setBezelStyle:NSBezelStyleRounded];
  [pasteButton setButtonType:NSButtonTypeMomentaryPushIn];
  [pasteButton setTarget:self];
  [pasteButton setAction:@selector(paste:)];
  [pasteButton setShowsBorderOnlyWhileMouseInside:YES];

  NAString* pasteImagePath = naNewApplicationResourcePath(NA_NULL, "paste", "png");
  NABabyImage* mainPasteImage = naCreateBabyImageFromFilePath(naGetStringUTF8Pointer(pasteImagePath));
  NAUIImage* pasteImage = naCreateUIImage(mainPasteImage, NA_UIIMAGE_RESOLUTION_SCREEN_2x, NA_BLEND_ERODE_LIGHT);
  //naTellNSButtonSetUIImage(pasteButton, pasteImage);
  naRelease(pasteImage);
  
  [self addSubview:pasteButton];
  
}



- (void)dealloc{
  [errorText release];
  [labelText release];
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

  if([(MATApplication*)NSApp hasShowCopyPaste]){
    [copyButton setHidden:NO];
    [pasteButton setHidden:NO];
  }else{
    [copyButton setHidden:YES];
    [pasteButton setHidden:YES];
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



- (NSString*)getString{
  return @"";
}

- (void)setString:(NSString*)string{
  NA_UNUSED(string);
}


- (void)copy:(NSResponder*) sender{
  NA_UNUSED(sender);
  NSPasteboard* pasteboard = [NSPasteboard generalPasteboard];
  [pasteboard clearContents];
  [pasteboard writeObjects:[NSArray arrayWithObject:[self getString]]];
}



- (void)paste:(NSResponder*) sender{
  NA_UNUSED(sender);
  NSPasteboard* pasteboard = [NSPasteboard generalPasteboard];
  NSArray *classes = [[NSArray alloc] initWithObjects:[NSString class], nil];
  NSDictionary *options = [NSDictionary dictionary];
  NSArray *copiedItems = [pasteboard readObjectsForClasses:classes options:options];
  if ([copiedItems count]) {
    [self setString: [copiedItems objectAtIndex:0]];
  }
  NA_COCOA_RELEASE(classes);
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



- (void)setStatus:(MATStatus)newStatus{
  status = newStatus;
}



- (void)setPasteEnabled:(NABool)pasteEnabled{
  [pasteButton setEnabled:pasteEnabled];
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


