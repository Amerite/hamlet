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
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    [self.view addSubview:loginButton];
    if ([FBSDKAccessToken currentAccessToken]) {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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

- (IBAction)login:(id)sender {
    BOOL isCorrectLogin =NO;
    
    
    //test inputs
    NSString *email = [self.emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [self.passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([email length] == 0 || [password length] == 0
 //       || ([password length] < 6) || ![self testEmail:email]
        ) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong input!"
                                                            message:@"Please try again"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        
        [alertView show];
    }
    else {
        //Good input. test database
        
        NSLog(@"%@ %@", email, password);
        for (NSUInteger index = 0; index< self.userLibrary.count; index++) {
            User *userInfo = [self.userLibrary objectAtIndex:index];
            NSLog(@"index: %lu", (unsigned long)index);
            [userInfo userDetails];
            if ([email isEqualToString:userInfo.username] && [password isEqualToString:userInfo.userPassword]) {
                //found matching username AND password
                isCorrectLogin = YES;
                break;
            }
        }
        
        
//server test
//        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys: email, @"email", password, @"password", @2, @"signin_type", @0, @"authenticate_type", nil];
//        NSError *error = [[NSError alloc] init];
//        NSData *jsonSignin = [NSJSONSerialization dataWithJSONObject:userInfo options:kNilOptions error:&error];
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setURL:[NSURL URLWithString:@"http://hamlet.nomits.com:1111/authenticate/signup"]];
//        [request setHTTPMethod:@"POST"];
//        [request setHTTPBody:jsonSignin];
//        NSLog(@"JSON %@", userInfo);
//        
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//            NSLog(@"requestReply : %@", requestReply);
//        }]resume];

        
        [self isCorrectLogin:isCorrectLogin email:email];
//
    }
    
    
    
}


-(void)isCorrectLogin:(BOOL)correctLogin email:(NSString *)email{
    if (correctLogin) {
        
        NSUInteger userIndex =-1;
        for (User *user in self.userLibrary) {
            if ([email isEqualToString:user.username]) {
                userIndex = [self.userLibrary indexOfObject:user];
            }
        }
                    //change current user
                if (userIndex!= -1){
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
        }
                else {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Wrong logins!"
                                                                        message:@"Please try again"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
                    [alertView show];
        }
    
    NSLog(@"%@", self.currentUser);

}




- (BOOL) testEmail: (NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}




@end
