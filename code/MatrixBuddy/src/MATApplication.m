
#import "MATApplication.h"
#include "MATTranslations.h"
#include "MATCommonC.h"


NSString* formatValue(float value){
  MATValueAccuracy valueAccuracy = [(MATApplication*)NSApp valueAccuracy];
  if(valueAccuracy == MAT_VALUE_ACCURACY_NATURAL){
    for(int digit = 0; digit < 10; digit++){
      float testValue = value * naPow(10, digit);
      if(naRoundf(testValue) == testValue){
        NSString* formatstring = [NSString stringWithFormat:@"%%.%df", digit];
        return [NSString stringWithFormat:formatstring, value];
      }
    }
  }
  return [NSString stringWithFormat:@"%f", value];
}


NAString* matNewStringWithFormatValue(float value){
  MATValueAccuracy valueAccuracy = [(MATApplication*)NSApp valueAccuracy];
  if(valueAccuracy == MAT_VALUE_ACCURACY_NATURAL){
    for(int digit = 0; digit < 10; digit++){
      float testValue = value * naPow(10, digit);
      if(naRoundf(testValue) == testValue){
        NAUTF8Char* formatString = naAllocSprintf(NA_TRUE, "%%.%df", digit);
        return naNewStringWithFormat(formatString, value);
      }
    }
  }
  return naNewStringWithFormat("%f", value);
}

void matPrepareFirstView(){
  [(MATApplication*)NSApp prepareFirstView];
}

NAFont* matGetMathFont(){
  return ((MATApplication*)NSApp)->mathFont;
}
NAUIImage* matGetCopyImage(){
  return ((MATApplication*)NSApp)->copyImage;
}
NAUIImage* matGetPasteImage(){
  return ((MATApplication*)NSApp)->pasteImage;
}

void matPutStringToPasteboard(const NAString* string){
  NSPasteboard* pasteboard = [NSPasteboard generalPasteboard];
  [pasteboard clearContents];
  [pasteboard writeObjects:
    [NSArray arrayWithObject:
      [NSString stringWithUTF8String:naGetStringUTF8Pointer(string)]]];
}

NAString* matNewStringFromPasteboard(){
  NAString* string = NA_NULL;
  NSPasteboard* pasteboard = [NSPasteboard generalPasteboard];
  NSArray *classes = [[NSArray alloc] initWithObjects:[NSString class], nil];
  NSDictionary *options = [NSDictionary dictionary];
  NSArray *copiedItems = [pasteboard readObjectsForClasses:classes options:options];
  if ([copiedItems count]) {
    NSString* nsString = [copiedItems objectAtIndex:0];
    string = naNewStringWithFormat("%s", [nsString UTF8String]);
  }else{
    string = naNewString();
  }
  NA_COCOA_RELEASE(classes);
  return string;
}

void matSetTextFieldCellProperties(NATextField* textField){
  NSTextField* nsTextField = (NSTextField*)naGetUIElementNativePtr(textField);
  [[nsTextField cell] setAlignment:NSTextAlignmentRight];
  [[nsTextField cell] setSendsActionOnEndEditing:YES];
  [[nsTextField cell] setLineBreakMode:NSLineBreakByClipping];
  [[nsTextField cell] setScrollable:YES];
}



@implementation MATApplication

- (id)init{
  self = [super init];
  [self setDelegate:self];
  
  mathFont = naCreateFontWithPreset(NA_FONT_KIND_MATH, NA_FONT_SIZE_HUGE);
  
  NAString* copyImagePath = naNewApplicationResourcePath(NA_NULL, "copy", "png");
  NABabyImage* mainCopyImage = naCreateBabyImageFromFilePath(naGetStringUTF8Pointer(copyImagePath));
  copyImage = naCreateUIImage(mainCopyImage, NA_UIIMAGE_RESOLUTION_SCREEN_2x, NA_BLEND_ERODE_LIGHT);

  NAString* pasteImagePath = naNewApplicationResourcePath(NA_NULL, "paste", "png");
  NABabyImage* mainPasteImage = naCreateBabyImageFromFilePath(naGetStringUTF8Pointer(pasteImagePath));
  pasteImage = naCreateUIImage(mainPasteImage, NA_UIIMAGE_RESOLUTION_SCREEN_2x, NA_BLEND_ERODE_LIGHT);
  
  return self;
}


- (void)dealloc{
  naRelease(mathFont);
  naRelease(copyImage);
  naRelease(pasteImage);
  [super dealloc];
}

- (void)prepareFirstView{
  aboutController = matAllocAboutController();
  [windowController prepareFirstView];
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification{
  NA_UNUSED(notification);
}


- (void)applicationWillTerminate:(NSNotification*)notification{
  NA_UNUSED(notification);
  
  naStopTranslator();
  naStopRuntime();
}


- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication{
  NA_UNUSED(theApplication);
  return YES;
}



- (IBAction)openAbout:(NSMenuItem*)sender{
  NA_UNUSED(sender);
  matShowAboutController(aboutController);
}

- (IBAction)openHelp:(NSMenuItem*)sender{
  NA_UNUSED(sender);
  naOpenURLInBrowser(matTranslate(MATApplicationHelpURL));
}



- (NABool)hasShowHelp{
  return [windowController hasShowHelp];
}
- (NABool)hasShowIdentifier{
  return [windowController hasShowIdentifiers];
}
- (NABool)hasShowCopyPaste{
  return [windowController hasShowCopyPaste];
}
- (NABool)hasRowFirstTabOrder{
  return [windowController hasRowFirstTabOrder];
}
- (MATCodeStyle)codeStyle{
  return [windowController codeStyle];
}
- (MATValueAccuracy)valueAccuracy{
  return [windowController valueAccuracy];
}


- (NSString*)statusString:(MATStatus)statusnum retColor:(MATColor*)retcolor{
  NSString* errorstring;
  MATColor color;
  switch(statusnum){
  case MAT_STATUS_NORMAL:
    errorstring = @"";
    color = MAT_COLOR_NORMAL;
    break;
  case MAT_STATUS_RESULT:
    errorstring = @"";
    color = MAT_COLOR_RESULT;
    break;
  case MAT_STATUS_MATRIX_DETERMINANT_ZERO:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorMatrixDeterminantZero)];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorMatrixDeterminantAlmostZero)];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_VECTOR_COMPONENT_ZERO:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorVectorComponentZero)];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorVectorComponentAlmostZero)];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_MATRIX_COMPONENT_ZERO:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorMatrixComponentZero)];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_MATRIX_COMPONENT_ALMOST_ZERO:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorMatrixComponentAlmostZero)];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_SCALAR_ZERO:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorScalarZero)];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_SCALAR_ALMOST_ZERO:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorScalarAlmostZero)];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_VECTOR_LENGTH_ZERO:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorVectorLengthZero)];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorVectorLengthAlmostZero)];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_VECTORS_COLINEAR:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorVectorsCollinear)];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_VECTORS_ALMOST_COLINEAR:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorVectorsAlmostCollinear)];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_VECTOR_LENGTH_UNEQUAL_ONE:
    errorstring = [NSString stringWithUTF8String:matTranslate(MATErrorVectorLengthUnequalOne)];
    color = MAT_COLOR_WARNING;
    break;
  }
  if(retcolor){*retcolor = color;}
  return errorstring;
}



- (NSColor*)color:(MATColor)colornum{
  NSColor* color;
  switch(colornum){
  case MAT_COLOR_NORMAL:  color = [NSColor controlTextColor]; break;
  case MAT_COLOR_ERROR:   color = [NSColor colorWithCalibratedRed:1. green:0. blue:0. alpha:1.]; break;
  case MAT_COLOR_WARNING: color = [NSColor colorWithCalibratedRed:.7 green:.5 blue:0. alpha:1.]; break;
  case MAT_COLOR_RESULT:  color = [NSColor colorWithCalibratedRed:0. green:.6 blue:0. alpha:1.]; break;
  }
  return color;
}



- (void)applicationWillFinishLaunching:(NSNotification *)notification
{
//  naLoadNib("MainMenu", NA_NULL);
}


@end
