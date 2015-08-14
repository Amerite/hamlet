//
//  UserLibrary.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 22..
//  Copyright (c) 2015년 nomit. All rights reserved.
//
//  This is the UserLibrary Class for the initial local tests: it is a set of premade Users

#import <Foundation/Foundation.h>

@class User;

@interface UserLibrary : NSObject

@property (strong, nonatomic) NSArray *library;

- (void) addUser:(User *) user;

@end
