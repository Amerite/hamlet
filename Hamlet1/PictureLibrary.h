//
//  PictureLibrary.h
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 4..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PictureMessage.h"

@interface PictureLibrary : NSObject

@property (nonatomic, strong) NSMutableArray *library;

-(NSArray *) retrieveMessagesWithUsername:(NSString *)username sender:(BOOL)sender;

@end
