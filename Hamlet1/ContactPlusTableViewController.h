//
//  ContactPlusTableViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 23..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultsTableViewController.h"
#import "User.h"
#import "Group.h"
#import "GroupLibrary.h"
#import "GroupTableView.h"

@interface ContactPlusTableViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, strong) NSArray *allUsers;
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) NSArray *userGroups;

@property (nonatomic, strong) GroupTableView *groupTableView;
@property (nonatomic) BOOL newGroup;

- (IBAction)addGroup:(id)sender;


@end
