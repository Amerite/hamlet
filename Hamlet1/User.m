//
//  User.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 22..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "User.h"

@implementation User


+ (User *)userWithUsername:(NSString *)username email:(NSString *)email password:(NSString *)password friends:(NSArray *) friends favorites:(NSArray *)favorites{
    User *newUser = [[self alloc] init];
    newUser.username = username;
    newUser.userEmail = email;
    newUser.userPassword = password;
    
    newUser.currentUser = NO;
    newUser.userFriends = [NSArray arrayWithArray:friends];
    newUser.favoriteFriends = [NSArray arrayWithArray:favorites];
    
    return newUser;
}


- (void)changeCurrentUser{
    if (_currentUser) {
        _currentUser = NO;
    }
    else {
        _currentUser = YES;
    }
}



- (void)userDetails{
    NSLog(@"User : %@ %@ %@ %d %@ %@", _username, _userPassword, _userEmail, _currentUser, _userFriends, _favoriteFriends);
    
}


#pragma mark - Encoding/Decoding

NSString *const UsernameKey = @"UsernameKey";
NSString *const EmailKey = @"EmailKey";
NSString *const PasswordKey = @"PasswordKey";
NSString *const CurrentUserKey = @"CurrentUserKey";
NSString *const FriendsKey = @"FriendsKey";
NSString *const FavoritesKey = @"FavoritesKey";

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _username = [aDecoder decodeObjectForKey:UsernameKey];
        _userEmail = [aDecoder decodeObjectForKey:EmailKey];
        _userPassword = [aDecoder decodeObjectForKey:PasswordKey];
        _currentUser = [aDecoder decodeObjectForKey:CurrentUserKey];
        _userFriends = [aDecoder decodeObjectForKey:FriendsKey];
        _favoriteFriends = [aDecoder decodeObjectForKey:FavoritesKey];
    }
    
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.username forKey:UsernameKey];
    [aCoder encodeObject:self.userEmail forKey:EmailKey];
    [aCoder encodeObject:self.userPassword forKey:PasswordKey];
    [aCoder encodeBool:self.currentUser forKey:CurrentUserKey];
    [aCoder encodeObject:self.userFriends forKey:FriendsKey];
    [aCoder encodeObject:self.favoriteFriends forKey:FavoritesKey];
    
}



@end
