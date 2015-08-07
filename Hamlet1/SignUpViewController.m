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
    // Do any additional setup after loading the view.
    
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

- (IBAction)signup:(id)sender {
    //test inputs
    NSString *username = [self.usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *confirmPassword = [self.confirmPasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([username length] == 0 || [email length] == 0 || [password length] == 0 || [confirmPassword length] == 0 || ([password isEqualToString:confirmPassword] == NO) || ([password length] < 6) || ![self testEmail:email]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong input!"
                                                            message:@"Please make sure you entered a username, an e-mail address and a password"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }
    else {
        
        //create a new user
        User *newUser = [User userWithUsername:username email:email password:password friends:@[] favorites:@[]];
        
        //add to userlibrary
        UserLibrary *userLibrary = [[UserLibrary alloc] init];
        [userLibrary addUser:newUser];
        NSLog(@"newLibrary : %lu", (unsigned long)[userLibrary.library count]);
        
        //return library and view to Login
        LoginViewController *loginController = (LoginViewController *)self.navigationController.viewControllers[0];
        loginController.userLibrary = userLibrary.library;
        [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:NO];
    }
    
}

- (BOOL) testEmail: (NSString *)email{
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
        return [emailTest evaluateWithObject:email];

}




@end
