//
//  GroupLibrary.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 24..
//  Copyright (c) 2015년 nomit. All rights reserved.
//
//  This is the GroupLibrary Class for the initial local tests: it is a set of premade groups

@class Group;

#import <Foundation/Foundation.h>

@interface GroupLibrary : NSObject

@property (nonatomic, strong) NSArray *library;

- (void) addGroup:(Group *) group;


//  Retrieve a group using Group Owner username
+ (NSArray *) retrieveGroupsFromUser: (NSString *)username;

@end
