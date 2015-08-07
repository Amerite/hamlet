//
//  ProgressBarView.m
//  Hamlet1
//
//  Created by Nomit on 2015. 8. 6..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "ProgressBarView.h"

@implementation ProgressBarView

- (CGSize) sizeThatFits:(CGSize)size {
    CGSize newSize = CGSizeMake(self.frame.size.width, 20);
    return newSize;
}

@end
