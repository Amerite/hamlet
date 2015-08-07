//
//  RecipientsTableViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 29..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureMessage.h"




@interface RecipientsTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *userFriends;
@property (strong, nonatomic) NSArray *userGroups;

@property (strong, nonatomic) NSArray *recipients;

@property (strong, nonatomic) PictureMessage *message;

- (IBAction)send:(id)sender;

@end
