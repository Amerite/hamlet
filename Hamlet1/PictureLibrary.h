//
//  PictureLibrary.h
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 4..
//  Copyright (c) 2015년 nomit. All rights reserved.
//
//  This is the PictureLibrary Class for the initial local tests: it sets a library of sent messages

#import <Foundation/Foundation.h>
#import "PictureMessage.h"

@interface PictureLibrary : NSObject

@property (nonatomic, strong) NSMutableArray *library;


//  Retrieve messages from the library with username and user role
-(NSArray *) retrieveMessagesWithUsername:(NSString *)username sender:(BOOL)sender;

@end
