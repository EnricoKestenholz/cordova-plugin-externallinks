#import <Cordova/CDV.h>

@interface ModusEcho : CDVPlugin

- (BOOL)webView:(UIWebView *)theWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType) navigationType
{ NSURL *url = [request URL];

    //mustNotReroot : for the google iFrame, the adress contains "embed" ==> must not be open in safari but in the app
    BOOL mustNotReroot = [url.path rangeOfString:@"embed"].location != NSNotFound;

    // Intercept any external http requests and forward to Safari
    // Otherwise forward to the PhoneGap WebView

    if (([[url scheme] isEqualToString:@"http"] || [[url scheme] isEqualToString:@"https"]) && !mustNotReroot)
    {
         NSLog(@"Rerouting to Safari %@",url);
        [[UIApplication sharedApplication] openURL:url];
        return NO;
    }
    else
    {
        return [ super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType ];
    }
}

@end