//
//  Group.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 24..
//  Copyright (c) 2015년 nomit. All rights reserved.
//
//  This is the Group Class for the initial local tests: it sets contact groups

#import <Foundation/Foundation.h>

@interface Group : NSObject <NSCoding>

//  Group characteristics
@property (nonatomic, strong) NSString *groupOwner;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSArray *groupMembers;
@property (nonatomic) BOOL isFavorite;


//  Initialize a Group instance
+ (Group *) groupWithOwner: (NSString *)owner name: (NSString *)groupname members: (NSArray *)members isFavorite: (BOOL)isFav;

- (void) groupDetails;

@end
