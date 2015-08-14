//
//  PictureLibrary.m
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 4..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "PictureLibrary.h"

@implementation PictureLibrary

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _library = [[NSMutableArray alloc] init];

    }
    
    return self;
}


//  Retrieve messages with username and user role
-(NSArray *)retrieveMessagesWithUsername:(NSString *)username sender:(BOOL)sender{
    NSMutableArray *messagesList = [[NSMutableArray alloc] init];
    
    //  Check the username in the library
    for (PictureMessage *message in self.library) {
        if (sender) {
            //  if user is sender
            if ([message.sender.username isEqualToString:username]) {
                [messagesList addObject:message];
            }
        }
        else if([message.recipients containsObject:username]){
            //  if user is recipient
            [messagesList addObject:message];
        }
    }
    
    return (NSArray *)messagesList;
}






@end
