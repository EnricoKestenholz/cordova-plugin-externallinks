#import "CDVPlugin.h"
#import "CDVWhitelist.h"

@interface CDVExternalLinks : CDVPlugin <NSXMLParserDelegate>


+ (BOOL)shouldOverrideLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType;

@end
