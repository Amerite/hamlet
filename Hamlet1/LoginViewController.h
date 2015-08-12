//
//  LoginViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 22..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "User.h"
#import "UserLibrary.h"

@interface LoginViewController : UIViewController

@property (strong, nonatomic) NSArray *userLibrary;

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) User *currentUser;

- (IBAction)login:(id)sender;
- (void) isCorrectLogin: (BOOL)correctLogin email:(NSString *)email;

- (BOOL) testEmail: (NSString *)email;

@end
