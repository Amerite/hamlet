//
//  FriendsTableViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 27..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "FriendsTableViewController.h"
#import "MainViewController.h"
#import "ContactPlusTableViewController.h"
#import "HeaderTableViewCell.h"
#import "FriendTableViewCell.h"
#import "GroupTableView.h"
#import "InboxViewController.h"



@interface FriendsTableViewController ()

@end

@implementation FriendsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:NO];
        self.userFriends = self.currentUser.userFriends;
//    //sort group array alphabetically
//    NSSortDescriptor *friendsNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"username"
//                                                                         ascending:YES
//                                                                          selector:@selector(localizedCaseInsensitiveCompare:)];
//    NSArray *descriptors = [NSArray arrayWithObjects:friendsNameDescriptor, nil];
//    self.userFriends = (NSMutableArray *)[self.userFriends sortedArrayUsingDescriptors:descriptors];
//    
    
        self.userGroups = [GroupLibrary retrieveGroupsFromUser:self.currentUser.username];
    if ([self.recipients count] == 0) {
        self.recipients = [[NSArray alloc] init];
    }
    if ([self.inbox count] == 0 && self.voted != -1) {
        self.inbox = [NSArray arrayWithArray:[self.messages retrieveMessagesWithUsername:self.currentUser.username sender:NO]];
    }
    
    
    NSLog(@"Friend recipients : %@", self.recipients);
}

- (void) viewWillAppear:(BOOL)animated{
    if ([self.votedInbox count] != 0) {
        [self clearInbox];
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    // go to Main page + recipients
    if ([self.navigationItem.title isEqualToString:@"Friends"] ) {
        MainViewController *main = self.navigationController.viewControllers[0];
        main.recipients = self.recipients;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections (favourites, groups, friends)
    if ([self.inbox count] != 0 && [self.navigationItem.title isEqualToString:@"Friends"]) {
        return 4;
    } else return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSString *headerTitle = [self tableView:self.tableView titleForHeaderInSection:section];
    NSLog(@"headerTitle : %@", headerTitle);
    
    if([headerTitle isEqualToString:@"Inbox"]   ) {
        return [self.inbox count];
    }
    else if ([headerTitle isEqualToString:@"Favorites"]){
        
    }
    else if ([headerTitle isEqualToString:@"Groups"]){
        NSLog(@"GROUPS : %ld", [self.userGroups count]);
        return [self.userGroups count];
    }
    else if ([headerTitle isEqualToString:@"Friends"]){
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
    
    NSArray *headerTitles = @[@"Inbox", @"Favorites", @"Groups", @"Friends"];
    
    if ([self numberOfSectionsInTableView:self.tableView] == 3) {
        headerCell.sectionTitle.text = [headerTitles objectAtIndex:(section +1)];
        
    }
    else {
        headerCell.sectionTitle.text = [headerTitles objectAtIndex:section];
    }
    
        [headerCell.sectionTitle sizeToFit];
        return headerCell;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FriendCell";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    FriendTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *headerTitle = [self tableView:self.tableView titleForHeaderInSection:indexPath.section];
    
    
    // Configure the cell...
    NSString *display;
    if ([headerTitle isEqualToString:@"Groups"]) {
        NSLog(@"NYA");
        Group *selectedGroup = [self.userGroups objectAtIndex:indexPath.row];
        display = selectedGroup.groupName;
    }
    else if ([headerTitle isEqualToString:@"Friends"]){
        display = [self.userFriends objectAtIndex:indexPath.row];
    }
    else if ([headerTitle isEqualToString:@"Inbox"]){
        PictureMessage *message =  (PictureMessage *)[self.inbox objectAtIndex:indexPath.row];
        display = message.sender.username;
        cell.favButton.hidden = YES;
    }
    
    cell.friendName.text= display;
    cell.favStar.hidden = YES;

    if ([self.recipients containsObject:display]) {
        cell.addedSign.hidden = NO;
    }
    else cell.addedSign.hidden = YES;
    
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *headerTitles = @[@"Inbox", @"Favorites", @"Groups", @"Friends"];
    
    if ([self numberOfSectionsInTableView:self.tableView] == 3) {
        return[headerTitles objectAtIndex:(section +1)];
        
    }
    else
        return [headerTitles objectAtIndex:section];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (![[self tableView:self.tableView titleForHeaderInSection:indexPath.section] isEqualToString:@"Inbox"]) {
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
    else {
        self.message = [self.inbox objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"showMessage" sender:self];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqual:@"showContactsPlus"]){
        ContactPlusTableViewController *tableController = (ContactPlusTableViewController *)segue.destinationViewController;
        tableController.currentUser = self.currentUser;
        tableController.allUsers = self.userLibrary;
        
        GroupTableView *tableView = (GroupTableView *) tableController.tableView.delegate;
        tableView.extendedSection = -1;
    }
    
    if ([segue.identifier isEqualToString:@"showMessage"]) {
        InboxViewController *viewController = (InboxViewController *)segue.destinationViewController;
        viewController.inbox = (NSMutableArray *) self.inbox;
        viewController.message = self.message;
        viewController.currentUsername = self.currentUser.username;
    }
    
}


-(void)send:(id)sender{
    self.message.recipients = (NSMutableArray *) self.recipients;
    if ([self.message.recipients count] !=0) {
        [self.delegate returnToMain:self.message];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}


-(void)clearInbox{
    NSMutableArray *newInbox = [NSMutableArray arrayWithArray:self.inbox];
    for (NSNumber *Index in self.votedInbox) {
        NSInteger index = [Index intValue];
        [newInbox replaceObjectAtIndex:index withObject:@"Remove"];
    }
    
    NSPredicate *removePredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] 'Remove' "];
    [newInbox filterUsingPredicate:removePredicate];
    
    self.inbox = (NSArray *)newInbox;
    NSLog(@"inbox %@", self.inbox);
    self.votedInbox = @[];
    self.voted = -1;
    
}


@end
