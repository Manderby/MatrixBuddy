
#import "MATApplication.h"



NSString* formatValue(float value){
  MATValueAccuracy valueAccuracy = [(MATApplication*)NSApp valueAccuracy];
  if(valueAccuracy == MAT_VALUE_ACCURACY_NATURAL){
    for(int digit = 0; digit < 6; digit++){
      float testvalue = value * naPow(10, digit);
      if(naRoundf(testvalue) == testvalue){
        NSString* formatstring = [NSString stringWithFormat:@"%%.%df", digit];
        return [NSString stringWithFormat:formatstring, value];
      }
    }
  }
  return [NSString stringWithFormat:@"%f", value];
}




@implementation MATApplication

- (id)init{
  self = [super init];
  [self setDelegate:self];
  naStartRuntime();
  return self;
}


- (void)applicationDidFinishLaunching:(NSNotification *)notification{
  NA_UNUSED(notification);

  [super applicationDidFinishLaunching:notification];

  NSURL* url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html" subdirectory:@"help"];
  [self setHelpDocument:url];

  [windowController prepareFirstView];

  NSString* versionstring = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
  NAString* lastrunversion = mandNewUserDefaultString("lastrunningversion");
  if(![versionstring isEqualToString:[NSString stringWithUTF8String:naGetStringUTF8Pointer(lastrunversion)]]){
    NAString* curversionstring = naNewStringWithFormat("%s", [versionstring UTF8String]);
    mandSetUserDefaultString(curversionstring, "lastrunningversion");
    naDelete(curversionstring);
    
    NSAlert* alert = [[NSAlert alloc] init];
    alert.alertStyle = NSInformationalAlertStyle;
    alert.messageText = [NSString stringWithFormat:@"Welcome to Version %@", versionstring];
    alert.informativeText = @"Enjoy the new dark mode on the latest macOS!";
    [alert runModal];
    [alert release];
  }
  naDelete(lastrunversion);
}


- (void)applicationWillTerminate:(NSNotification*)notification{
  NA_UNUSED(notification);
  
  naStopRuntime();
}


- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication{
  NA_UNUSED(theApplication);
  return YES;
}


- (IBAction)openOnlineHelp:(NSMenuItem*)sender{
  NA_UNUSED(sender);
  NSString* language = [[NSLocale currentLocale] languageCode];
  if([language isEqualToString:@"de"]){
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://manderc.com/apps/matrixbuddy/help/index.php"]];
  }else{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://manderc.com/apps/matrixbuddy/help/index_en.php"]];
  }
}



- (NABool)hasShowHelp{
  return [windowController hasShowHelp];
}
- (NABool)hasShowIdentifier{
  return [windowController hasShowIdentifiers];
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
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorMatrixDeterminantZero" value:nil table:nil];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_MATRIX_DETERMINANT_ALMOST_ZERO:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorMatrixDeterminantAlmostZero" value:nil table:nil];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_VECTOR_COMPONENT_ZERO:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorVectorComponentZero" value:nil table:nil];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_VECTOR_COMPONENT_ALMOST_ZERO:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorVectorComponentAlmostZero" value:nil table:nil];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_MATRIX_COMPONENT_ZERO:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorMatrixComponentZero" value:nil table:nil];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_MATRIX_COMPONENT_ALMOST_ZERO:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorMatrixComponentAlmostZero" value:nil table:nil];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_SCALAR_ZERO:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorScalarZero" value:nil table:nil];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_SCALAR_ALMOST_ZERO:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorScalarAlmostZero" value:nil table:nil];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_VECTOR_LENGTH_ZERO:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorVectorLengthZero" value:nil table:nil];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_VECTOR_LENGTH_ALMOST_ZERO:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorVectorLengthAlmostZero" value:nil table:nil];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_VECTORS_COLINEAR:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorVectorsColinear" value:nil table:nil];
    color = MAT_COLOR_ERROR;
    break;
  case MAT_STATUS_VECTORS_ALMOST_COLINEAR:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorVectorsAlmostColinear" value:nil table:nil];
    color = MAT_COLOR_WARNING;
    break;
  case MAT_STATUS_VECTOR_LENGTH_UNEQUAL_ONE:
    errorstring = [[NSBundle mainBundle] localizedStringForKey:@"MATErrorVectorLengthUnequalOne" value:nil table:nil];
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


@end
