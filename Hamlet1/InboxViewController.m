//
//  InboxViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 5..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "InboxViewController.h"
#import "FriendsTableViewController.h"

@interface InboxViewController ()

@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSInteger i=0; i < [self.navigationController.viewControllers count]; i++) {
        UIViewController *viewController = self.navigationController.viewControllers[i];
        if ([viewController.navigationItem.title isEqualToString:@"Friends"]) {
            self.previousViewIndex = i;
        }
        }
    
    self.votedMessages = [[NSMutableArray alloc] init];
    self.inboxIndex = [self.inbox indexOfObject:self.message];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.inbox count] == 0) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[self.previousViewIndex] animated:YES];
    }
    else {
        self.message = [self.inbox objectAtIndex:self.inboxIndex];
        [self openMessage:self.message];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    FriendsTableViewController *viewController = self.navigationController.viewControllers[self.previousViewIndex];
    viewController.votedInbox = self.votedMessages;
    
}

-(void)openMessage:(PictureMessage *)message{
    NSLog(@"index %ld", (long)self.inboxIndex);
    self.navigationItem.title = message.sender.username;
    self.questionLabel.text = message.question;
    self.picture.image = message.picture;
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
        self.inboxIndex = [self.inbox count] -1;
    }
    self.inboxIndex = self.inboxIndex % [self.inbox count];
    
    self.message = [self.inbox objectAtIndex:self.inboxIndex];
    [self openMessage:self.message];
    
    
}

- (IBAction)vote:(UISwipeGestureRecognizer *)sender {
    UISwipeGestureRecognizerDirection direction = [(UISwipeGestureRecognizer *) sender direction];
    NSInteger vote = -1;
    
    switch (direction) {
        case UISwipeGestureRecognizerDirectionUp:
            vote = 0;
            break;
            
        case UISwipeGestureRecognizerDirectionDown:
            vote = 1;
            break;
            
        default:
            break;
    }
    NSLog(@"voted %ld", (long)vote);
    [self voted:vote forIndex:self.inboxIndex];
}


-(void)voted:(NSInteger)vote forIndex:(NSInteger)messageIndex{
    self.message = [self.inbox objectAtIndex:messageIndex];
    
    if ([self.message.recipients containsObject:self.currentUsername] && (vote == 0 || vote == 1) && ![[self.message.feedbacks objectAtIndex:vote] containsObject:self.currentUsername]) {
        NSMutableArray *newFeedback = [NSMutableArray arrayWithArray:self.message.feedbacks];
        NSMutableArray *newVote = [NSMutableArray arrayWithArray:[newFeedback objectAtIndex:vote]];
        [newVote addObject:self.currentUsername];
        [newFeedback replaceObjectAtIndex:vote withObject:newVote];
        
        self.message.feedbacks = newFeedback;
        NSLog(@"vote %@", [self.message.feedbacks objectAtIndex:vote]);
    }
    
    [self.votedMessages addObject:[NSNumber numberWithInteger:self.inboxIndex]];
    
    NSLog(@"vote %ld", vote);
}



@end
