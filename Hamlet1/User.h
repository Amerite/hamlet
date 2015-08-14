//
//  User.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 22..
//  Copyright (c) 2015년 nomit. All rights reserved.
//
//  This is the User Class for the initial local tests

#import <Foundation/Foundation.h>
#import "UserLibrary.h"

@interface User : NSObject <NSCoding>

//  User characteristics
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, assign, getter=isCurrentUser) BOOL currentUser;

@property (nonatomic, strong) NSArray *userFriends;
@property (nonatomic, strong) NSArray *favoriteFriends;


//  Initialize a User instance
+ (User *)userWithUsername:(NSString *)username email:(NSString *)email password:(NSString *)password friends:(NSArray *)friends favorites:(NSArray *)favorites;


//  Decide Current User
-(void) changeCurrentUser;


//  NSLog the details of the User
-(void) userDetails;


@end
