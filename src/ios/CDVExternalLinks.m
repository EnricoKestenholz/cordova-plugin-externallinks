/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVExternalLinks.h"
#import <Cordova/CDV.h>

@interface CDVExternalLinks ()


@end

@implementation CDVExternalLinks

#pragma mark NSXMLParserDelegate


+ (BOOL)shouldOpenURLRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType

{

    return (UIWebViewNavigationTypeLinkClicked == navigationType ||

        (UIWebViewNavigationTypeOther == navigationType &&
         [[request.mainDocumentURL absoluteString] isEqualToString:[request.URL absoluteString]]
        )

    );

}

+ (BOOL)shouldOverrideLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{

    NSURL* url = [request URL];
    NSURL* mainUrl = [request mainDocumentURL];

    CDVWhitelist* mainWhiteList = [[CDVWhitelist alloc] initWithArray:@[ @"file://" ]];
    BOOL allowMain = [mainWhiteList URLIsAllowed:mainUrl logFailure:NO];

    if(!allowMain){
        // only allow-intent if it's a UIWebViewNavigationTypeLinkClicked (anchor tag) OR
        // it's a UIWebViewNavigationTypeOther, and it's an internal link
        if ([[self class] shouldOpenURLRequest:request navigationType:navigationType]){

            #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000

            // CB-11895; openURL with a single parameter is deprecated in iOS 10
            // see https://useyourloaf.com/blog/openurl-deprecated-in-ios10

            if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
                 [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:url];
            }
            #else
            // fall back if on older SDK

           [[UIApplication sharedApplication] openURL:url];

        #endif
        }
        // consume the request (i.e. no error) if it wasn't handled above
        return NO;
    }

    return YES;
}

- (BOOL)shouldOverrideLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    return [[self class] shouldOverrideLoadWithRequest:request navigationType:navigationType];
}

@end