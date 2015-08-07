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
    // Do any additional setup after loading the view.
    if (self.userLibrary.count == 0) {
        UserLibrary *userLibrary = [[UserLibrary alloc ] init];
        self.userLibrary = userLibrary.library;
    }
    else { NSLog(@"Existing modified userLibrary!");
    }
    
    [self.navigationController setNavigationBarHidden:NO animated:NO ];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationItem setHidesBackButton:YES animated:NO];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"showFriends"]) {
        FriendsTableViewController *tableController = (FriendsTableViewController *)segue.destinationViewController;
        tableController.currentUser = self.currentUser;
        tableController.userLibrary = self.userLibrary;
    }
    
}


#pragma mark - Login

- (IBAction)login:(id)sender {
    BOOL isCorrectLogin =NO;
    NSUInteger userIndex =0;
    
    
    //test inputs
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([username length] == 0 || [password length] == 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong input!"
                                                            message:@"Please try again"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        
        [alertView show];
    }
    else {
        //Good input. test database
        NSLog(@"%@ %@", username, password);
        for (NSUInteger index = 0; index< self.userLibrary.count; index++) {
            User *userInfo = [self.userLibrary objectAtIndex:index];
            NSLog(@"index: %lu", (unsigned long)index);
            [userInfo userDetails];
            if ([username isEqualToString:userInfo.username] && [password isEqualToString:userInfo.password]) {
                //found matching username AND password
                isCorrectLogin = YES;
                userIndex = index;
                break;
            }
        }
        
        if (isCorrectLogin) {
        
            //change current user
            User *enteredUser = [self.userLibrary objectAtIndex:userIndex];
            NSLog(@"%d", enteredUser.currentUser);
            
            [enteredUser changeCurrentUser];
            
            NSMutableArray *updatedLibrary = [NSMutableArray arrayWithArray:self.userLibrary];
            [updatedLibrary replaceObjectAtIndex:userIndex withObject:enteredUser];
            self.userLibrary = updatedLibrary;
            self.currentUser = [self.userLibrary objectAtIndex:userIndex];
            
            // go to Main page + current user
            MainViewController *main = self.navigationController.viewControllers[0];
            main.currentUser = self.currentUser;
            main.userLibrary = self.userLibrary;
            main.sent = NO;
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }
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
