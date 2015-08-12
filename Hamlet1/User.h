//
//  User.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 22..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserLibrary.h"

@interface User : NSObject <NSCoding>

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *userEmail;
@property (nonatomic, strong) NSString *userPassword;

@property (nonatomic, assign, getter=isCurrentUser) BOOL currentUser;

@property (nonatomic, strong) NSArray *userFriends;
@property (nonatomic, strong) NSArray *favoriteFriends;

+ (User *)userWithUsername:(NSString *)username email:(NSString *)email password:(NSString *)password friends:(NSArray *)friends favorites:(NSArray *)favorites;

-(void) changeCurrentUser;

-(void) userDetails;


@end
