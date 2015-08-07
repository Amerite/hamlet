//
//  Group.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 24..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject <NSCoding>

@property (nonatomic, strong) NSString *groupOwner;
@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSArray *groupMembers;
@property (nonatomic) BOOL isFavorite;

+ (Group *) groupWithOwner: (NSString *)owner name: (NSString *)groupname members: (NSArray *)members isFavorite: (BOOL)isFav;

- (void) groupDetails;

@end
