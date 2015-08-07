//
//  FriendsTableViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 27..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "UserLibrary.h"
#import "Group.h"
#import "GroupLibrary.h"
#import "PictureMessage.h"
#import "PictureLibrary.h"


@protocol ReturnToMainDelegate <NSObject>

-(void) returnToMain: (PictureMessage *)message;

@end



@interface FriendsTableViewController : UITableViewController 

@property (strong, nonatomic) User *currentUser;
@property (strong, nonatomic) NSArray *userLibrary;
@property (strong, nonatomic) NSArray *userFriends;
@property (strong, nonatomic) NSArray *userGroups;

@property (strong, nonatomic) NSArray *recipients;
@property (strong, nonatomic) PictureLibrary *messages;
@property (strong, nonatomic) NSArray *inbox;
@property (nonatomic) NSInteger voted;
@property (strong, nonatomic) NSArray *votedInbox;

@property (strong, nonatomic) PictureMessage *message;
@property (assign, nonatomic) id <ReturnToMainDelegate> delegate;


- (IBAction)send:(id)sender;

- (void) clearInbox;

@end
