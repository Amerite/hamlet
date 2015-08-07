//
//  InboxViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 5..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureMessage.h"

@interface InboxViewController : UIViewController

@property (nonatomic, strong) NSString *currentUsername;
@property (nonatomic, strong) NSMutableArray *inbox;
@property (nonatomic) NSInteger inboxIndex;
@property (nonatomic, strong) PictureMessage *message;
@property (nonatomic) NSInteger previousViewIndex;

@property (nonatomic, strong) NSMutableArray *votedMessages;

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@property (weak, nonatomic) IBOutlet UINavigationItem *titleName;


- (void) openMessage: (PictureMessage *)message;

- (IBAction)changeMessage:(UISwipeGestureRecognizer *)sender;
- (IBAction)vote:(UISwipeGestureRecognizer *)sender;

- (void) voted:(NSInteger)vote forIndex:(NSInteger)messageIndex;

@end
