//
//  GroupTableView.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 24..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupLibrary.h"
#import "Group.h"

@class User;

@interface GroupTableView : UITableView <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) User *currentUser;
@property (strong, nonatomic) NSArray *listGroups;
@property (nonatomic) BOOL new;

@property (nonatomic) NSInteger extendedSection;

- (void) newGroup;

@end
