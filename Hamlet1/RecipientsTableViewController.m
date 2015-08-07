//
//  RecipientsTableViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 29..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "RecipientsTableViewController.h"
#import "MainViewController.h"
#import "Group.h"
#import "GroupLibrary.h"
#import "HeaderTableViewCell.h"
#import "FriendTableViewCell.h"

@interface RecipientsTableViewController ()

@end

@implementation RecipientsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.userFriends = self.message.sender.userFriends;
    self.userGroups = [GroupLibrary retrieveGroupsFromUser:self.message.sender.username];
    self.recipients = [[NSArray alloc] init];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections (favourites, groups, friends)
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    
    if(section == 1) {
        return [self.userGroups count];
    }
    else if (section == 2){
        return [self.userFriends count];
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    static NSString *HeaderCellIdentifier = @"HeaderCell";
    
    HeaderTableViewCell *headerCell = (HeaderTableViewCell *) [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderCellIdentifier];
    if (!headerCell) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"HeadersView" owner:@"HeaderTableViewCell" options:nil];
        for (id obj in nibArray) {
            if ([obj isMemberOfClass:[HeaderTableViewCell class]]) {
                headerCell = (HeaderTableViewCell *) obj;
                break;
            }
        }
    }
    
    if (section == 0) {
        headerCell.sectionTitle.text = @"Favourites";
        
    }
    else if (section == 1) {
        headerCell.sectionTitle.text = @"Groups";
    }
    else {headerCell.sectionTitle.text = @"Friends";}
    
    [headerCell.sectionTitle sizeToFit];
    return headerCell;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FriendCell";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    FriendTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *display;
    if (indexPath.section == 1) {
        Group *selectedGroup = [self.userGroups objectAtIndex:indexPath.row];
        display = selectedGroup.groupName;
    }
    else if (indexPath.section == 2){
        display = [self.userFriends objectAtIndex:indexPath.row];
    }
    
    cell.friendName.text= display;
    cell.favStar.hidden = YES;
    cell.addedSign.hidden=YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    FriendTableViewCell *cell = (FriendTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if ([self.recipients containsObject:cell.friendName.text]) {
        NSMutableArray *newArray = [NSMutableArray arrayWithArray: self.recipients];
        [newArray removeObject:cell.friendName.text];
        self.recipients = newArray;
    }
    else {
        NSMutableArray *newArray = [NSMutableArray arrayWithArray:self.recipients];
        [newArray addObject:cell.friendName.text];
        self.recipients = newArray;
    }
    [cell addRecipient];
    [cell setNeedsLayout];
    
    
}




- (IBAction)send:(id)sender {
    self.message.recipients = (NSMutableArray *) self.recipients;
    
    //[self.delegate returnToMain: self.message];
    [self.navigationController popToRootViewControllerAnimated:NO];
}


@end
