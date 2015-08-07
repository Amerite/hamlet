//
//  FBViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 3..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "FBViewController.h"

@interface FBViewController ()

@end

@implementation FBViewController
@synthesize loginStatusLabel = _loginStatusLabel;
@synthesize loginButton = _loginButton;
@synthesize loginDialog = _loginDialog;
@synthesize loginDialogView = _loginDialogView;


- (void) dealloc {
    self.loginStatusLabel = nil;
    self.loginButton = nil;
    self.loginDialog = nil;
    self.loginDialogView = nil;
}

- (void) refresh {
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
        _loginStatusLabel.text = @"Not connected to Facebook";
        [_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        _loginButton.hidden = NO;
    }
    else if (_loginState == LoginStateLoggingIn){
        _loginStatusLabel.text = @"Connecting to Facebook...";
        _loginButton.hidden = YES;
    }
    else if (_loginState == LoginStateLoggedIn){
        _loginStatusLabel.text = @"Connected to Facebook";
        [_loginButton setTitle:@"Logout" forState:UIControlStateNormal];
        _loginButton.hidden = NO;
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [self refresh];
}


- (IBAction)loginButtonTapped:(id)sender{
    NSString *appId = @" ";
    NSString *permissions = @"publish_stream";
    
    if (_loginDialog == nil) {
        self.loginDialog = [[FBLoginDialogViewController alloc] initwithAppId:appId requestedPermissions:permissions delegate:self];
        self.loginDialogView = _loginDialog.view;
    }
    
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
        _loginState = LoginStateLoggingIn;
        [_loginDialog login];
    }
    else if (_loginState == LoginStateLoggedIn) {
        _loginState = LoginStateLoggedOut;
        [_loginDialog logout];
    }
    
    [self refresh];
    
}


- (void) accessTokenFound:(NSString *)accessToken {
    NSLog(@"Access token found: %@", accessToken);
    _loginState = LoginStateLoggedIn;
    [self dismissModalViewControllerAnimated:YES];
    [self refresh];
}

- (void) displayRequired {
    [self presentModalViewController:_loginDialog animated:YES];
}

- (void) closeTapped {
    [self dismissModalViewControllerAnimated:YES];
    _loginState = LoginStateLoggedOut;
    [_loginDialog logout];
    [self refresh];
}


@end
