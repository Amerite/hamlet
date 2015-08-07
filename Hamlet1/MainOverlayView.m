//
//  MainOverlayView.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 27..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "MainOverlayView.h"

@implementation MainOverlayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.opaque = NO;
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(0, 430, 320, 40);
        [self addSubview:button];
    }
    
    return self;
}

@end
