

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>


@interface HelpViewer : NSWindowController <NSWindowDelegate>{
  IBOutlet WebView* webview;
}

- (void) show;

@end
