//
//  GroupLibrary.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 24..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "GroupLibrary.h"
#import "Group.h"

@implementation GroupLibrary

- (instancetype) init {

    self = [super init];
    if (self) {
        
        _library = @[
                     [Group groupWithOwner:@"Serena" name:@"Work" members:@[@"John"] isFavorite:NO],
                     [Group groupWithOwner:@"Serena" name:@"BFF" members:@[@"John", @"Loki"] isFavorite:YES],
                     [Group groupWithOwner:@"Bubbles" name:@"Summer" members:@[@"Happy", @"Neko"] isFavorite:NO],
                     [Group groupWithOwner:@"Bubbles" name:@"Anime" members:@[@"Lucky", @"Happy"] isFavorite:YES],
                     [Group groupWithOwner:@"Happy" name:@"Animecon" members:@[@"Bubbles"] isFavorite:YES],
                     [Group groupWithOwner:@"Neko" name:@"Unwanted" members:@[@"Happy"] isFavorite:NO]
                     
                     
                     ];
    }
    
    return self;
}


//  Add a new group to the library
- (void) addGroup:(Group *) group {
    //Create and initialize temp Array :
    NSMutableArray *tempGroupLibrary = [[NSMutableArray alloc] init];
    [tempGroupLibrary addObjectsFromArray: _library];
    
    //Create Group to add to Array :
    if ([group.groupOwner length] >0 && [group.groupName length] > 0) {
        Group *newGroup = [Group groupWithOwner:group.groupOwner name:group.groupName members:group.groupMembers isFavorite:NO];
        [tempGroupLibrary addObject:newGroup];
        _library = tempGroupLibrary;
        [[_library lastObject] groupDetails];
    }
    
}


//  Search for groups in library with Group Owner username
+ (NSArray *) retrieveGroupsFromUser: (NSString *)username {
    //  Create GroupLibrary instance and array for results
    GroupLibrary *groupLibrary = [[GroupLibrary alloc] init];
    NSMutableArray *groupsForUser = [[NSMutableArray alloc] init];
    
    //  Compare Owner to username
    for (Group* groups in groupLibrary.library) {
        if ([groups.groupOwner isEqualToString:username]) {
            [groupsForUser addObject:groups];
        }
    }
    
    return (NSArray *)groupsForUser;
}


@end
