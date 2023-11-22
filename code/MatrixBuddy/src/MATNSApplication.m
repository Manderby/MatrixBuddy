
#import "MATNSApplication.h"
#include "MATApplication.h"
#include "NAApp/NAApp.h"
#include "MATCommonC.h"



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



@implementation MATNSApplication

- (IBAction)openAbout:(NSMenuItem*)sender{
  NA_UNUSED(sender);
  matShowApplicationAbout();
}

- (IBAction)openHelp:(NSMenuItem*)sender{
  NA_UNUSED(sender);
  matShowApplicationHelp();
}

@end
