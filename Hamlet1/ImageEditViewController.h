//
//  ImageEditViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 29..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureMessage.h"
#import "User.h"

@interface ImageEditViewController : UIViewController

@property (strong, nonatomic) User *currentUser;
@property (strong, nonatomic) PictureMessage *message;

@property (weak, nonatomic) IBOutlet UITextField *questionField;
@property (strong, nonatomic) UIImage *temp;
@property (strong, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) NSArray *recipients;


- (IBAction)send:(id)sender;

@end
