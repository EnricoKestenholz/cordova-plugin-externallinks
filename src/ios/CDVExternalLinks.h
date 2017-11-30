#import <Cordova/CDVPlugin.h>

@interface CDVExternalLinks : CDVPlugin <NSXMLParserDelegate>


+ (BOOL)shouldOverrideLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType;

@end
