//
//  SignUpViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 22..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  Show navigation back button (to Login)
    [self.navigationItem setHidesBackButton:NO animated:NO];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



//  At "Signup" button press
- (IBAction)signup:(id)sender {
    
    //  Test user inputs format (Strings, email, password length and confirmation)
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *confirmPassword = [self.confirmPasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    
    if ([username length] == 0 || [email length] == 0 || [password length] == 0 || [confirmPassword length] == 0 || ([password isEqualToString:confirmPassword] == NO) || ([password length] < 6) || ![self testEmail:email]) {
        
        //  Error message if format mistake
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong input!"
                                                            message:@"Please make sure you entered a username, an e-mail address and a password"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    
    //  Good user inputs. Test database for Sign Up
    else {
        
        //  Local test: Create a new User instance
        User *newUser = [User userWithUsername:username email:email password:password friends:@[] favorites:@[]];
        
        //  Local test: Add to userlibrary
        UserLibrary *userLibrary = [[UserLibrary alloc] init];
        [userLibrary addUser:newUser];
        NSLog(@"newLibrary : %lu", (unsigned long)[userLibrary.library count]);
        
        //  (Local test:) Return library and view to Login
        LoginViewController *loginController = (LoginViewController *)self.navigationController.viewControllers[0];
        loginController.userLibrary = userLibrary.library;
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
    }
    
}

//  Test email format
- (BOOL) testEmail: (NSString *)email{
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
        return [emailTest evaluateWithObject:email];

}




@end
