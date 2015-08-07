//
//  GroupTableView.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 24..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "GroupTableView.h"
#import "User.h"
#import "Group.h"
#import "GroupNameCellTableViewCell.h"
#import "MemberNameTableViewCell.h"


@implementation GroupTableView

NSString *const GroupNameCellIdentifier = @"GroupCell";
NSString *const MemberNameCellIdentifier = @"MemberCell";

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if (_new) {
        [self newGroup];
        _new = NO;
    }
    NSLog(@"list count : %lu", (unsigned long) [self.listGroups count]);
    return [self.listGroups count];
    //return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSInteger number;
    if (section == self.extendedSection) {
        Group *group = [self.listGroups objectAtIndex:section];
        number =([group.groupMembers count]+1);
    }
    else number = 1;
    return number;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    //return cell;
    NSLog(@"HELLO");
    
    
    Group *selectedGroup = [self.listGroups objectAtIndex:indexPath.section];
    NSLog(@"section no : %ld selected group :", (long)indexPath.section);
    [selectedGroup groupDetails];
    if (indexPath.row==0) {
        
        //initialize custom Group cell
        [self registerNib:[UINib nibWithNibName:@"GroupNameCellTableViewCell" bundle:nil] forCellReuseIdentifier:GroupNameCellIdentifier];
        GroupNameCellTableViewCell *groupCell = [self dequeueReusableCellWithIdentifier:GroupNameCellIdentifier];
        
        if ([selectedGroup.groupName length] == 0) {
            groupCell.groupNameField.delegate = self;
            groupCell.groupNameField.hidden = NO;
            [groupCell.groupNameField becomeFirstResponder];
        }
        else{
            groupCell.textLabel.text = selectedGroup.groupName;
            groupCell.groupNameField.hidden = YES;
            
        }
        return groupCell;
        
    }
           if (indexPath.row !=0) {
            //initialize custom Member cell
            [self registerNib:[UINib nibWithNibName:@"MemberNameTableViewCell" bundle:nil] forCellReuseIdentifier:MemberNameCellIdentifier];
            MemberNameTableViewCell *memberCell = [self dequeueReusableCellWithIdentifier:MemberNameCellIdentifier];
            
            NSArray *memberList = [NSArray arrayWithArray:selectedGroup.groupMembers];
            memberCell.memberNameLabel.text = [memberList objectAtIndex:(indexPath.row)-1];
            return memberCell;
    }
    
    
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:@"Cell"];
    return cell;

}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        GroupNameCellTableViewCell *groupCell = (GroupNameCellTableViewCell *) [self cellForRowAtIndexPath:indexPath];
//        
//        if ([groupCell.textLabel.text length] == 0) {
//            groupCell.groupNameField.hidden = NO;
//            groupCell.groupNameField.delegate = self;
//            [groupCell.groupNameField becomeFirstResponder];
//        }
//    }

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger formerSection = -1;
    BOOL didChangeSection = NO;
    
    if (indexPath.row == 0) {
        if (self.extendedSection == indexPath.section) {
            formerSection = self.extendedSection;
            self.extendedSection = -1;
            didChangeSection = YES;
        }
        else {
            formerSection = self.extendedSection;
        self.extendedSection = indexPath.section;
            didChangeSection = YES;
        }
    }
    NSLog(@"extended : %ld", (long)self.extendedSection);
    
    [self tableView:tableView numberOfRowsInSection:indexPath.section];
    [self tableView:tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"number of rows in section %ld %ld", [self tableView:tableView numberOfRowsInSection:indexPath.section], (long)indexPath.section);
    
    if (didChangeSection) {
    [tableView beginUpdates];
    //for (NSInteger i =0; i < [self numberOfSectionsInTableView:tableView]; i++) {
        
        if (self.extendedSection != -1) {
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:self.extendedSection] withRowAnimation:UITableViewRowAnimationNone];
        }
        
        if (formerSection != -1) {
            if (self.extendedSection != -1) {
                [tableView reloadSections:[NSIndexSet indexSetWithIndex:formerSection] withRowAnimation:UITableViewRowAnimationFade];
            }
            else [tableView reloadSections:[NSIndexSet indexSetWithIndex:formerSection] withRowAnimation:UITableViewRowAnimationNone];
        }
        
    [tableView endUpdates];
    }
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
        [textField resignFirstResponder];
        
        NSString *text = textField.text;
    Group *newGroup = [Group groupWithOwner:self.currentUser.username
                                       name:text
                                    members:@[]
                                 isFavorite:NO];
    [newGroup groupDetails];
    
    
    
        NSMutableArray *newList = [NSMutableArray arrayWithArray: self.listGroups];
        NSInteger index = -1;
    for (Group *group in newList) {
        if ([group.groupName length] == 0) {
            index = [newList indexOfObject:group];
            
        }
    }
    if (index != -1) {
        [newList replaceObjectAtIndex:index withObject:newGroup];
    }

        self.listGroups = newList;
    
    //sort group array alphabetically
    NSSortDescriptor *groupNamesDescriptor = [[NSSortDescriptor alloc] initWithKey:@"groupName"
                                                                         ascending:YES
                                                                          selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:groupNamesDescriptor, nil];
    self.listGroups = (NSMutableArray *)[self.listGroups sortedArrayUsingDescriptors:descriptors];
    
    
    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];

        return NO;

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.hidden = YES;
    
    
//    //    }
    
}

-(void)newGroup{
    NSMutableArray *newList = [NSMutableArray arrayWithArray:self.listGroups];
    [newList addObject:[Group groupWithOwner:self.currentUser.username name:@"" members:@[] isFavorite:NO]];
    self.listGroups = newList;
    
    //sort group array alphabetically
    NSSortDescriptor *groupNamesDescriptor = [[NSSortDescriptor alloc] initWithKey:@"groupName"
                                                                         ascending:YES
                                                                          selector:@selector(localizedCaseInsensitiveCompare:)];
    NSArray *descriptors = [NSArray arrayWithObjects:groupNamesDescriptor, nil];
    self.listGroups = (NSMutableArray *)[self.listGroups sortedArrayUsingDescriptors:descriptors];

    
        for (NSInteger sec; sec < [self numberOfSections]; sec ++) {
            [self numberOfRowsInSection: sec];
            for (NSInteger row; row < [self numberOfRowsInSection:sec]; row++) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:sec];
                [self tableView:self cellForRowAtIndexPath:indexPath];
            }
            [self beginUpdates];
            [self reloadSections:[NSIndexSet indexSetWithIndex:sec] withRowAnimation:UITableViewRowAnimationNone];
            [self endUpdates];

    [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
        }
}

@end
