//
//  PictureMessage.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 29..
//  Copyright (c) 2015년 nomit. All rights reserved.
//
//  This is the PictureMessage Class for the initial local tests

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"

@interface PictureMessage : NSObject

@property (nonatomic, strong) User *sender;
@property (nonatomic, strong) NSMutableArray *recipients;

@property (nonatomic, strong) UIImage *picture;
@property (nonatomic, strong) NSString *question;

@property (nonatomic, strong) NSArray *feedbacks;


//  Initialize a PictureMessage instance
+ (PictureMessage *)messageWithPicture: (UIImage *)picture sender:(User *)sender question:(NSString *)question recipients:(NSMutableArray *)recipients yesFeedback:(NSArray *)yes noFeedback:(NSArray *)no;


//  NSLog the message's characteristics
- (void) messageDetails;

@end
