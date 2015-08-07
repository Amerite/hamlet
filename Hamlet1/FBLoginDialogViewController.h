//
//  FBLoginDialogViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 3..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FBLoginDialogDelegate

- (void) accessTokenFound : (NSString *)accessToken;
- (void) displayRequired;
- (void) closeTapped;

@end


@interface FBLoginDialogViewController : UIViewController <UIWebViewDelegate> {
    UIWebView *_webView;
    NSString *_apiKey;
    NSString *_requestedPermissions;
    // id <FBLoginDialogDelegate> delegate;
}

@property (retain) IBOutlet UIWebView *webView;
@property (copy) NSString *apiKey;
@property (copy) NSString *requestedPermissions;
@property (assign) id <FBLoginDialogDelegate> delegate;

- (id) initwithAppId:(NSString *) apiKey
requestedPermissions:(NSString *) requestedPermissions
            delegate:(id <FBLoginDialogDelegate>)delegate;

- (IBAction)closeTapped:(id)sender;
- (void) login;
- (void) logout;

- (void) checkForAccessToken: (NSString *)urlString;
- (void) checkLoginRequired: (NSString *)urlString;

@end
