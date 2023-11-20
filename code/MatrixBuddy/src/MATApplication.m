
#import "MATApplication.h"
#include "MATTranslations.h"
#include "MATCommonC.h"
#include "MATWindowControllerASDF.h"


void matPrepareFirstView(){
  [(MATApplication*)NSApp prepareFirstView];
}



NAFont* matGetMathFont(){
  return ((MATApplication*)NSApp)->mathFont;
}



NAFont* matGetHelpLineFont(){
  return ((MATApplication*)NSApp)->helpLineFont;
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



const NAUTF8Char* matGetUTF8StringWithStatus(MATStatus status){
  static MATTranslation errorStringTranslations[] = {
    MATDummyTranslation,      // MAT_STATUS_NORMAL results in ""
    MATDummyTranslation,      // MAT_STATUS_RESULT results in ""
    MATErrorMatrixDeterminantZero,
    MATErrorMatrixDeterminantAlmostZero,
    MATErrorVectorComponentZero,
    MATErrorVectorComponentAlmostZero,
    MATErrorMatrixComponentZero,
    MATErrorMatrixComponentAlmostZero,
    MATErrorScalarZero,
    MATErrorScalarAlmostZero,
    MATErrorVectorLengthZero,
    MATErrorVectorLengthAlmostZero,
    MATErrorVectorsCollinear,
    MATErrorVectorsAlmostCollinear,
    MATErrorVectorLengthUnequalOne
  };
  
  return matTranslate(errorStringTranslations[status]);
}



MATColor matGetColorWithStatus(MATStatus status){
  static MATColor statusColors[] = {
    [MAT_STATUS_NORMAL]                         = MAT_COLOR_NORMAL,
    [MAT_STATUS_RESULT]                         = MAT_COLOR_RESULT,
    [MAT_STATUS_MATRIX_DETERMINANT_ZERO]        = MAT_COLOR_ERROR,
    [MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO] = MAT_COLOR_WARNING,
    [MAT_STATUS_VECTOR_COMPONENT_ZERO]          = MAT_COLOR_ERROR,
    [MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO]   = MAT_COLOR_WARNING,
    [MAT_STATUS_MATRIX_COMPONENT_ZERO]          = MAT_COLOR_ERROR,
    [MAT_STATUS_MATRIX_COMPONENT_ALMOST_ZERO]   = MAT_COLOR_WARNING,
    [MAT_STATUS_SCALAR_ZERO]                    = MAT_COLOR_ERROR,
    [MAT_STATUS_SCALAR_ALMOST_ZERO]             = MAT_COLOR_WARNING,
    [MAT_STATUS_VECTOR_LENGTH_ZERO]             = MAT_COLOR_ERROR,
    [MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO]      = MAT_COLOR_WARNING,
    [MAT_STATUS_VECTORS_COLINEAR]               = MAT_COLOR_ERROR,
    [MAT_STATUS_VECTORS_ALMOST_COLINEAR]        = MAT_COLOR_WARNING,
    [MAT_STATUS_VECTOR_LENGTH_UNEQUAL_ONE]      = MAT_COLOR_WARNING,
  };
  
  return statusColors[status];
}



void matFillBabyColor(NABabyColor* babyColor, MATColor color){
  static const NABabyColor matColors[] = {
    [MAT_COLOR_NORMAL]  = {0., 0., 0., 0.,},
    [MAT_COLOR_RESULT]  = {0., .4, .025, 1.,},
    [MAT_COLOR_ERROR]   = {.7, .025, 0., 1.,},
    [MAT_COLOR_WARNING] = {.4, .25, 0., 1.,},
  };
  naCopyn(*babyColor, &matColors[color], sizeof(NABabyColor));
}



NABool matHasRowFirstOrder(){
  return [(MATApplication*)NSApp hasRowFirstTabOrder];
}



MATCodeStyle matGetCodeStyle(){
  return [(MATApplication*)NSApp codeStyle];
}



MATValueAccuracy matGetValueAccuracy(){
  return [(MATApplication*)NSApp valueAccuracy];
}



NABool matHasShowIdentifier(){
  return [(MATApplication*)NSApp hasShowIdentifier];
}



NABool matHasShowCopyPaste(){
  return [(MATApplication*)NSApp hasShowCopyPaste];
}



NABool matHasShowHelp(){
  return [(MATApplication*)NSApp hasShowHelp];
}




@implementation MATApplication

- (id)init{
  self = [super init];
  [self setDelegate:self];
  
  mathFont = naCreateFontWithPreset(NA_FONT_KIND_MATH, NA_FONT_SIZE_HUGE);
  helpLineFont = naCreateFontWithPreset(NA_FONT_KIND_SYSTEM, NA_FONT_SIZE_SMALL);
  
  NAString* copyImagePath = naNewApplicationResourcePath(NA_NULL, "copy", "png");
  NABabyImage* mainCopyImage = naCreateBabyImageFromFilePath(naGetStringUTF8Pointer(copyImagePath));
  copyImage = naCreateUIImage(mainCopyImage, NA_UIIMAGE_RESOLUTION_SCREEN_2x, NA_BLEND_ERODE_LIGHT);

  NAString* pasteImagePath = naNewApplicationResourcePath(NA_NULL, "paste", "png");
  NABabyImage* mainPasteImage = naCreateBabyImageFromFilePath(naGetStringUTF8Pointer(pasteImagePath));
  pasteImage = naCreateUIImage(mainPasteImage, NA_UIIMAGE_RESOLUTION_SCREEN_2x, NA_BLEND_ERODE_LIGHT);
  
  return self;
}


- (void)prepareFirstView{
  aboutController = matAllocAboutController();
  windowControllerASDF = matAllocWindowController();
}

- (void)applicationWillTerminate:(NSNotification*)notification{
  NA_UNUSED(notification);
  
  naRelease(mathFont);
  naRelease(helpLineFont);
  naRelease(copyImage);
  naRelease(pasteImage);

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

@end
