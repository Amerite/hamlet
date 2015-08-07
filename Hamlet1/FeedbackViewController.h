//
//  FeedbackViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 6..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureMessage.h"
#import "PictureLibrary.h"


@interface FeedbackViewController : UIViewController

@property (strong, nonatomic) NSArray *messages;
@property (strong, nonatomic) PictureMessage *message;
@property (nonatomic) NSInteger inboxIndex;

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *noMessages;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *trashButton;
@property (weak, nonatomic) IBOutlet UIProgressView *yesBar;
@property (weak, nonatomic) IBOutlet UIProgressView *noBar;

- (void) openMessage: (PictureMessage *)message;
- (void) showFeedback: (PictureMessage *)message;

- (IBAction)changeMessage:(UISwipeGestureRecognizer *)sender;

- (IBAction)trash:(id)sender;

@end

