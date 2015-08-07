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

-(NSArray *)retrieveMessagesWithUsername:(NSString *)username sender:(BOOL)sender{
    NSMutableArray *messagesList = [[NSMutableArray alloc] init];
    
    for (PictureMessage *message in self.library) {
        if (sender) {
            if ([message.sender.username isEqualToString:username]) {
                [messagesList addObject:message];
            }
        }
        else if([message.recipients containsObject:username]){
            [messagesList addObject:message];
        }
    }
    
    return (NSArray *)messagesList;
}






@end
