//
//  SearchResultsTableViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 23..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface SearchResultsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *resultUsers;

@property (nonatomic, strong) User *currentUser;

@end
