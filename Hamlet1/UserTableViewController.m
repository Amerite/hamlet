//
//  UserTableViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 23..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "UserTableViewController.h"

@interface UserTableViewController ()

@end

@implementation UserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //link to nib file
    static NSString *CellIdentifier = @"Cell";
    static NSString *CellNibName = @"UserTableViewController";
    [self.tableView registerNib:[UINib nibWithNibName: CellNibName bundle:nil] forCellReuseIdentifier:CellIdentifier];
}


@end