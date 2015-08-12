//
//  UserLibrary.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 22..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "UserLibrary.h"
#import "User.h"


@implementation UserLibrary

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _library = @[
                     [User userWithUsername:@"Serena" email:@"serena@l.j" password:@"12345" friends:@[@"John", @"Loki"] favorites:@[@"Loki"]],
                     [User userWithUsername:@"John" email:@"john@something.k" password:@"12345" friends:@[@"Serena"] favorites:@[]],
                     [User userWithUsername:@"Bubbles" email:@"bubbles@ppg.x" password:@"12345" friends:@[@"Happy", @"Neko", @"Lucky", @"Bubbles"] favorites:@[@"Neko", @"Lucky"]],
                     [User userWithUsername:@"Loki" email:@"lokiloki@smile.yolo" password:@"12345" friends:@[@"Serena"] favorites:@[]],
                     [User userWithUsername:@"Happy" email:@"happiness@happy.h" password:@"12345" friends:@[@"Bubbles", @"Neko"] favorites:@[]],
                     [User userWithUsername:@"Pearly" email:@"phoenix@pearls.yes" password:@"12345" friends:@[@"Moar"] favorites:@[]],
                     [User userWithUsername:@"Domon" email:@"daemon@so.goo" password:@"12345" friends:@[] favorites:@[]],
                     [User userWithUsername:@"Ash" email:@"meh@swhynot.jj" password:@"12345" friends:@[@"Freeda"] favorites:@[]],
                     [User userWithUsername:@"Moar" email:@"mewmew@moar.l" password:@"12345" friends:@[@"Pearly"] favorites:@[@"Pearly"]],
                     [User userWithUsername:@"Quiver" email:@"wutwut@sheep.bah" password:@"12345" friends:@[@"Freeda"] favorites:@[]],
                     [User userWithUsername:@"Beat" email:@"car@insect.cool" password:@"12345" friends:@[] favorites:@[]],
                     [User userWithUsername:@"Lloyd" email:@"amber@blue.co" password:@"12345" friends:@[] favorites:@[]],
                     [User userWithUsername:@"Susanna" email:@"happy@help.df" password:@"12345" friends:@[] favorites:@[]],
                     [User userWithUsername:@"Neko" email:@"mewmew@sunshine.oh" password:@"12345" friends:@[@"Bubbles", @"Happy"] favorites:@[@"Bubbles"]],
                     [User userWithUsername:@"Lucky" email:@"happy@help.jk" password:@"12345" friends:@[@"Bubbles"] favorites:@[]],
                     [User userWithUsername:@"Freeda" email:@"yellow@fish.jf" password:@"12345" friends:@[@"Ash", @"Quiver"] favorites:@[@"Quiver"]]
                     ];
        
            }
    return self;
}



- (void) addUser:(User *) user {
    //Create and initialize temp Array :
    NSMutableArray *tempUserLibrary = [[NSMutableArray alloc] init];
    [tempUserLibrary addObjectsFromArray:_library];
    
    //Create User to add to Array :
    if ([user.username length] >0 &&[user.userEmail length] >0 &&[user.userPassword length] >0) {
        User *newUser = [User userWithUsername:user.username email:user.userEmail password:user.userPassword friends:user.userFriends favorites : @[]];
        [tempUserLibrary addObject:newUser];
        _library = tempUserLibrary;
        [[_library objectAtIndex:([_library count] -1)] userDetails];
    }
    
    
}

@end
