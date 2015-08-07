//
//  PictureMessage.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 29..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "PictureMessage.h"

@implementation PictureMessage

-(void)messageDetails{
    NSLog(@" Message sender : %@  question : %@  recipients : %@", _sender.username, _question, _recipients);
}

+ (PictureMessage *)messageWithPicture:(UIImage *)picture sender:(User *)sender question:(NSString *)question recipients:(NSMutableArray *)recipients yesFeedback:(NSArray *)yes noFeedback:(NSArray *)no{
    
    PictureMessage *newMessage = [[PictureMessage alloc] init];
    newMessage.picture = picture;
    newMessage.sender = sender;
    newMessage.question = question;
    newMessage.recipients = [NSMutableArray arrayWithArray:recipients];
    
    newMessage.feedbacks = @[ @[], @[]];
    
    BOOL contains = YES;
    for (NSObject *name in yes) {
        if (![newMessage.recipients containsObject:name]) {
            contains = NO;
        }
    }
    if (contains) {
        [[newMessage.feedbacks objectAtIndex:0] arrayByAddingObjectsFromArray:yes];
    }
    
    contains = YES;
    for (NSObject *name in no) {
        if (![newMessage.recipients containsObject:name]) {
            contains = NO;
        }
    }
    if (contains) {
        [[newMessage.feedbacks objectAtIndex:1] arrayByAddingObjectsFromArray:no];
    }
    
    
    return newMessage;
}

@end
