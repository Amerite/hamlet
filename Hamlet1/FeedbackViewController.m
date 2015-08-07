//
//  FeedbackViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 6..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    
    if ([self.messages count] == 0) {
        self.noMessages.hidden = NO;
        self.navigationItem.rightBarButtonItem = nil;
        self.picture.image = nil;
        self.questionLabel.hidden = YES;
        self.noBar.hidden =YES;
        self.yesBar.hidden =YES;

    } else
    {
        self.noMessages.hidden = YES;
        self.yesBar.hidden = NO;
        self.noBar.hidden =NO;
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.noMessages.hidden) {
        self.message = [self.messages objectAtIndex:self.inboxIndex];
        [self openMessage:self.message];
    }
    
}

-(void)openMessage:(PictureMessage *)message{
    NSLog(@"index %ld", (long)self.inboxIndex);
    self.questionLabel.text = message.question;
    self.picture.image = message.picture;
    [self showFeedback:message];
}

-(void)showFeedback:(PictureMessage *)message{
    float yesPercent = 0.0;
    float noPercent = 0.0;
    
    NSArray *feedback = [NSArray arrayWithArray: message.feedbacks];
    NSArray *yesFeeds = [NSArray arrayWithArray: [feedback objectAtIndex:0]];
    NSArray *noFeeds = [NSArray arrayWithArray: [feedback objectAtIndex:1]];
    NSInteger count = [message.recipients count];
    
    NSLog(@" feedback YES : %@ %ld NO: %@ %ld", yesFeeds, [yesFeeds count], noFeeds, [noFeeds count]);
    noPercent = (float)[noFeeds count]  / count;
    yesPercent = (float)[yesFeeds count] / count + noPercent;
    
    NSLog(@"Percents count : %ld YES : %f NO : %f", count, yesPercent, noPercent);
    
    self.yesBar.progress = yesPercent;
    [self.yesBar reloadInputViews];
    self.noBar.progress = noPercent;
    [self.noBar reloadInputViews];
    
    
}


- (IBAction)changeMessage:(UISwipeGestureRecognizer *)sender {
    NSLog(@"swiped");
    UISwipeGestureRecognizerDirection direction = [(UISwipeGestureRecognizer *) sender direction];
    
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            self.inboxIndex ++;
            break;
            
        case UISwipeGestureRecognizerDirectionRight:
            self.inboxIndex--;
            break;
            
        default:
            break;
    }
    
    if (self.inboxIndex < 0) {
        self.inboxIndex = [self.messages count] -1;
    }
    self.inboxIndex = self.inboxIndex % [self.messages count];
    
    self.message = [self.messages objectAtIndex:self.inboxIndex];
    [self openMessage:self.message];
    
    
}


- (IBAction)trash:(id)sender {
    NSMutableArray *newMessages = [NSMutableArray arrayWithArray:self.messages];
    [newMessages removeObjectAtIndex:self.inboxIndex];
    self.messages = newMessages;
    
    if ([self.messages count] == 0) {
        [self viewDidLoad];
    }
    
    else {
    self.inboxIndex ++;
    if (self.inboxIndex < 0) {
        self.inboxIndex = [self.messages count] -1;
    }
    self.inboxIndex = self.inboxIndex % [self.messages count];
    self.message = [self.messages objectAtIndex:self.inboxIndex];
    [self openMessage:self.message];
    }
    
}
@end
