//
//  SearchResultsTableViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 23..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "User.h"
#import "AddUserCellTableViewCell.h"

@interface SearchResultsTableViewController ()

@end

@implementation SearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // Current user test
    if (self.currentUser) {
        NSLog(@"Current user is :");
        [self.currentUser userDetails];
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [self.resultUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *AddCellIdentifier = @"AddCell";
    
    

    
    //initialize custom cell
    [self.tableView registerNib:[UINib nibWithNibName:@"AddUserCellTableViewCell" bundle:nil] forCellReuseIdentifier:AddCellIdentifier];
    AddUserCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddCellIdentifier];
    
    
   // Configure the cell depending on friendship
    User *resultUser = [self.resultUsers objectAtIndex:indexPath.row];
    NSLog(@"%@", self.currentUser.userFriends);
    cell.addButton.hidden = NO;
    
    //Special rule for friends
  /*  if ([self.currentUser.userFriends containsObject:resultUser.username]) {
        cell.hidden = YES;
    }
   */
    
    
     cell.textLabel.text = resultUser.username;
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
