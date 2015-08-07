//
//  FBLoginDialogViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 3..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "FBLoginDialogViewController.h"

@implementation FBLoginDialogViewController
@synthesize webView = _webView;
@synthesize apiKey = _apiKey;
@synthesize requestedPermissions = _requestedPermissions;
//@synthesize delegate = delegate;

- (id) initwithAppId:(NSString *)apiKey requestedPermissions:(NSString *)requestedPermissions delegate:(id<FBLoginDialogDelegate>)delegate{
    if ((self == [super initWithNibName:@"FBLoginDialogViewController" bundle:[NSBundle mainBundle]])) {
        self.apiKey = apiKey;
        self.requestedPermissions = requestedPermissions;
        self.delegate = delegate;
    }
    return self;
}

- (void) dealloc {
    self.webView = nil;
    self.apiKey = nil;
    self.requestedPermissions = nil ;
}

- (void) login {
    
    [_webView loadRequest: [NSURLRequest requestWithURL: [NSURL URLWithString:@"about:blank"]]];
    
    NSString *redirectUrlString = @"http://www.facebook.com/connect/login_success.html";
    NSString *authFormatString = @"https://graph.facebook.com/oauth/authorize?client_id=%@&redirect_uri=%@&scope=%@&type=user_agent&dispaly=touch";
    
    NSString *urlString = [NSString stringWithFormat: authFormatString, _apiKey, redirectUrlString, _requestedPermissions];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    [_webView loadRequest:request];
}

- (void) logout {
    NSHTTPCookieStorage *cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie * cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [cookies deleteCookie:cookie];
    }
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSString *urlString = request.URL.absoluteString;
    
    [self checkForAccessToken:urlString];
    [self checkLoginRequired:urlString];
    
    return TRUE;
}

- (void) checkForAccessToken:(NSString *)urlString{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"access_token=(.*)&" options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        if (firstMatch) {
            NSRange accessTokenRange = [firstMatch rangeAtIndex:1];
            NSString *accessToken = [urlString substringWithRange:accessTokenRange];
            accessToken = [accessToken stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [_delegate accessTokenFound:accessToken];
        }
    }
}

- (void)checkLoginRequired:(NSString *)urlString{
    if ([urlString rangeOfString:@"login.php"].location != NSNotFound) {
        [_delegate displayRequired];
    }
}

- (IBAction)closeTapped:(id)sender{
    [_delegate closeTapped];
}


@end
