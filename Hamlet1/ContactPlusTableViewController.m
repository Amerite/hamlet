//
//  ContactPlusTableViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 23..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "ContactPlusTableViewController.h"
#import "GroupNameCellTableViewCell.h"
#import "MemberNameTableViewCell.h"


@interface ContactPlusTableViewController () <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SearchResultsTableViewController *resultsTableController;

@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@end

@implementation ContactPlusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //implement SearchController in View
    _resultsTableController = [[SearchResultsTableViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    //set delegate for didSelectRowAtIndexPath
    self.resultsTableController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.definesPresentationContext = YES;
    

    //Library tests
    
    for(User *user in self.allUsers){
        [user userDetails];
    }
    
    BOOL currentUser = NO;
    for (User *user in self.allUsers){
        if (user.currentUser == 1) {
            currentUser =YES;
            self.currentUser = user;
            _resultsTableController.currentUser = user;
        }
    }
    NSLog(@"Current user : %d", currentUser);
    
    //initialize GroupTableView as tableview
    self.groupTableView = [[GroupTableView alloc] init];
    if ([self.userGroups count] == 0) {
        self.userGroups = [GroupLibrary retrieveGroupsFromUser:self.currentUser.username];
    }
    
    //sort group array alphabetically
    NSSortDescriptor *groupNamesDescriptor = [[NSSortDescriptor alloc] initWithKey:@"groupName"
                                                                         ascending:YES
                                                                          selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:groupNamesDescriptor, nil];
    self.userGroups = (NSMutableArray *)[self.userGroups sortedArrayUsingDescriptors:descriptors];
    
    for (Group* group in self.userGroups) {
        group.groupMembers = [group.groupMembers sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    }
    if ([self.groupTableView.listGroups count]==0) {
        self.groupTableView.listGroups = self.userGroups;
    }
    if (self.newGroup == YES) {
        self.groupTableView.new = YES;
        self.newGroup = NO;
    }
    else self.groupTableView.new = NO;

    self.groupTableView.currentUser = self.currentUser;
    self.tableView.delegate = self.groupTableView;
    self.tableView.dataSource = self.groupTableView;
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //restore searchController's active state
    if (self.searchControllerWasActive) {
        self.searchController.active = self.searchControllerWasActive;
        _searchControllerWasActive = NO;
        
        if (self.searchControllerSearchFieldWasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            _searchControllerSearchFieldWasFirstResponder = NO;
        }
    }
    

}




#pragma mark - UISearchController
//UISearchBarDelegate
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}



#pragma mark - UISearchResultsUpdating

- (void) updateSearchResultsForSearchController:(UISearchController *)searchController{

}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    SearchResultsTableViewController *tableController = (SearchResultsTableViewController *) self.searchController.searchResultsController;
    NSArray *new = [[ NSArray alloc] init];
    tableController.resultUsers = new;
    [tableController.tableView reloadData];
}



- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    SearchResultsTableViewController *tableController = (SearchResultsTableViewController *) self.searchController.searchResultsController;
    
    
    //search through array of available users for searchtring in searchbar
    NSString *searchText = self.searchController.searchBar.text;
    NSMutableArray *searchResults = [self.allUsers mutableCopy];
    
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSArray *searchUsers = nil;     //initialize wtih the searchterms in strippedString
        if ([strippedString length] >0) {
            searchUsers = [strippedString componentsSeparatedByString:@" "];
        }
    
    // "AND" expressions for values of searchString
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    for (NSString *searchString in searchUsers){
    
        // "OR" predicates for username, email
        NSMutableArray *searchUsersPredicate = [NSMutableArray array];
        
        //username field matching
        NSExpression *left = [NSExpression expressionForKeyPath:@"username"];
        NSExpression *right = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate predicateWithLeftExpression:left
                                                                         rightExpression:right
                                                                                modifier:NSDirectPredicateModifier
                                                                                    type:NSContainsPredicateOperatorType
                                                                                 options:NSCaseInsensitivePredicateOption];
        
        [searchUsersPredicate addObject:finalPredicate];
        
        //email field matching
        left = [NSExpression expressionForKeyPath:@"email"];
        finalPredicate = [NSComparisonPredicate predicateWithLeftExpression:left
                                                            rightExpression:right
                                                                   modifier:NSDirectPredicateModifier
                                                                       type:NSContainsPredicateOperatorType
                                                                    options:NSCaseInsensitivePredicateOption];
        [searchUsersPredicate addObject:finalPredicate];
        
        
        //add "OR" predicate to "AND" predicate
        NSCompoundPredicate *orMatchPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:searchUsersPredicate];
        [andMatchPredicates addObject:orMatchPredicate];
    }
    
    //match the field of the User object
    NSCompoundPredicate *finalCompoundPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    searchResults = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
    
    
    //Remove currentUser from resultsUsers
    NSMutableArray *newResults = [NSMutableArray arrayWithArray: searchResults];
    [newResults removeObject:self.currentUser];
    searchResults = newResults;
    
    
    //Remove friends from resultsUsers
    for (User *result in searchResults) {
        if ([self.currentUser.userFriends containsObject:result.username]) {
            NSMutableArray *newResults = [NSMutableArray arrayWithArray: searchResults];
            [newResults removeObject: result];
            searchResults = newResults;
        }
    }
    
    
    
    //sort array alphabetically
    NSSortDescriptor *usernameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"username"
                                                                       ascending:YES
                                                                        selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:usernameDescriptor, nil];
    searchResults = (NSMutableArray *)[searchResults sortedArrayUsingDescriptors:descriptors];
    
    
    //give the results to SearchResultsTableViewController
    tableController.resultUsers = searchResults;
    [tableController.tableView reloadData];
        
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addGroup:(id)sender {
    self.newGroup = YES;
    [self viewDidLoad];
}


@end
