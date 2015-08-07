//
//  GroupLibrary.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 24..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

@class Group;

#import <Foundation/Foundation.h>

@interface GroupLibrary : NSObject

@property (nonatomic, strong) NSArray *library;

- (void) addGroup:(Group *) group;

+ (NSArray *) retrieveGroupsFromUser: (NSString *)username;

@end
