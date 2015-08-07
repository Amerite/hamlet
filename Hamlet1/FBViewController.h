//
//  FBViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 3..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBLoginDialogViewController.h"

typedef enum {
    LoginStateStartup,
    LoginStateLoggingIn,
    LoginStateLoggedIn,
    LoginStateLoggedOut
} LoginState;


@interface FBViewController : UIViewController <FBLoginDialogDelegate> {
    UILabel *_loginStatusLabel;
    UIButton *_loginButton;
    LoginState _loginState;
    FBLoginDialogViewController *_loginDialog;
    UIView *_loginDialogView;
}


@property (retain) IBOutlet UILabel *loginStatusLabel;
@property (retain) IBOutlet UIButton *loginButton;
@property (retain) FBLoginDialogViewController *loginDialog;
@property (retain) IBOutlet UIView *loginDialogView;

-(IBAction)loginButtonTapped:(id)sender;


@end
