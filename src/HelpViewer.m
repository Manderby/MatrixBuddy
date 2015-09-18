

#import "HelpViewer.h"


@implementation HelpViewer

-(void)awakeFromNib{
  NSURL* url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html" subdirectory:@"help"];
  [[webview mainFrame] loadRequest:[NSURLRequest requestWithURL:url]];
}


- (void) show{
  [[self window] makeKeyAndOrderFront:self];
}

@end
