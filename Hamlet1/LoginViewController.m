//
//  LoginViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 22..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "LoginViewController.h"
#import "FriendsTableViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  Local test: Initialize userLibrary to transmit after for contacts
    if (self.userLibrary.count == 0) {
        UserLibrary *userLibrary = [[UserLibrary alloc ] init];
        self.userLibrary = userLibrary.library;
    }
    else { NSLog(@"Existing modified userLibrary!");
    }
    
    
    //  Facebook Signin button
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    [self.view addSubview:loginButton];
    
        //  If already logged in
        if ([FBSDKAccessToken currentAccessToken]) {
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
    
    
    //  Show Navigation Bar with "Login" title
    [self.navigationController setNavigationBarHidden:NO animated:NO ];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //  Hide the back button in navigation bar (to Main ViewController)
    [self.navigationItem setHidesBackButton:YES animated:NO];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqual:@"showFriends"]) {
//        FriendsTableViewController *tableController = (FriendsTableViewController *)segue.destinationViewController;
//        tableController.currentUser = self.currentUser;
//        tableController.userLibrary = self.userLibrary;
//    }
    
}


#pragma mark - Login

//  At "Let's Start" button press
- (IBAction)login:(id)sender {
    BOOL isCorrectLogin =NO;
    NSUInteger userIndex =0;
    
    
    //  Test user inputs format (Strings)
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([username length] == 0 || [password length] == 0) {
        //  Error message if format mistake
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong input!"
                                                            message:@"Please try again"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        
        [alertView show];
    }
    
    //  Good user inputs. Test database for login
    else {
        
        NSLog(@"%@ %@", username, password);
        
        //  Local test: Check in userLibrary if username exists and matches password
        for (NSUInteger index = 0; index< self.userLibrary.count; index++) {
            
            User *userInfo = [self.userLibrary objectAtIndex:index];
            NSLog(@"index: %lu", (unsigned long)index);
            [userInfo userDetails];
            
            if ([username isEqualToString:userInfo.username] && [password isEqualToString:userInfo.password]) {
                
                //  found matching username AND password
                isCorrectLogin = YES;
                userIndex = index;
                break;
            }
        }
        
        //  User found in database: Login
        if (isCorrectLogin) {
        
            //  Local test: Change current user
            User *enteredUser = [self.userLibrary objectAtIndex:userIndex];
            NSLog(@"%d", enteredUser.currentUser);
            
            [enteredUser changeCurrentUser];
            
            //  Local test: Update user library
            NSMutableArray *updatedLibrary = [NSMutableArray arrayWithArray:self.userLibrary];
            [updatedLibrary replaceObjectAtIndex:userIndex withObject:enteredUser];
            self.userLibrary = updatedLibrary;
            self.currentUser = [self.userLibrary objectAtIndex:userIndex];
            
            // (Local test:) go to Main page + pass current user and userLibrary
            MainViewController *main = self.navigationController.viewControllers[0];
            main.currentUser = self.currentUser;
            main.userLibrary = self.userLibrary;
            main.sent = NO;
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }
        
        //  Error message for false login inputs
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong logins!"
                                                                message:@"Please try again"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
    }
    
    NSLog(@"%@", self.currentUser);
    
}
@end
