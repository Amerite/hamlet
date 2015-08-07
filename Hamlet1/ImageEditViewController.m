//
//  ImageEditViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 29..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "ImageEditViewController.h"
#import "MainViewController.h"
#import "FriendsTableViewController.h"

@interface ImageEditViewController ()

@end

@implementation ImageEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO ];
    self.picture.image = self.temp;
    NSLog(@" Picture contains : %@", [self.picture.image class]);
    
    
}


- (IBAction)send:(id)sender {
    self.message = [PictureMessage messageWithPicture:self.picture.image sender:self.currentUser question:self.questionField.text recipients: (NSMutableArray *)self.recipients yesFeedback:@[] noFeedback:@[]];
    
//    self.message.sender = self.currentUser;
//    self.message.picture = self.picture.image;
//    self.message.recipients = (NSMutableArray *) self.recipients;
//    self.message.question = self.questionField.text;
//    
    [self performSegueWithIdentifier:@"showRecipients" sender:self];
}



#pragma mark - navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showRecipients"]) {
        FriendsTableViewController *tableViewController = (FriendsTableViewController *) segue.destinationViewController;
        tableViewController.message = self.message;
        tableViewController.currentUser = self.currentUser;
        tableViewController.recipients = self.recipients;
        tableViewController.delegate = self.navigationController.viewControllers[0];
    }
    
    
}




@end
