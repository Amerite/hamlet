//
//  Group.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 24..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "Group.h"

@implementation Group


//  Initialize Group instance
+ (Group *)groupWithOwner:(NSString *)owner name:(NSString *)groupname members:(NSArray *)members isFavorite:(BOOL)isFav{
    Group *newGroup = [[Group alloc] init];
    
    newGroup.groupOwner = owner;
    newGroup.groupName = groupname;
    newGroup.groupMembers = [NSArray arrayWithArray:members];
    newGroup.isFavorite = isFav;
    
    return newGroup;    
}


//  NSLog Group characteristics
- (void) groupDetails{
    NSLog(@"Group : owner %@ \n name %@ \n members %@ favorite %d", _groupOwner, _groupName, _groupMembers, _isFavorite);
}



# pragma mark - Encoding/Decoding

NSString *const GroupOwner = @"GroupdOwner";
NSString *const GroupName = @"GroupName";
NSString *const GroupMembers = @"GroupMembers";
NSString *const FavoriteGroup = @"FavoriteGroup";

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _groupOwner = [aDecoder decodeObjectForKey:GroupOwner];
        _groupName = [aDecoder decodeObjectForKey:GroupName];
        _groupMembers = [aDecoder decodeObjectForKey:GroupMembers];
        _isFavorite = [aDecoder decodeObjectForKey:FavoriteGroup];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.groupOwner forKey:GroupOwner];
    [aCoder encodeObject:self.groupName forKey:GroupName];
    [aCoder encodeObject:self.groupMembers forKey:GroupMembers];
    [aCoder encodeBool:self.isFavorite forKey:FavoriteGroup];
}



@end
