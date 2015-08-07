//
//  FriendTableViewCell.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 28..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "FriendTableViewCell.h"

@implementation FriendTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)changeFavorite:(id)sender {
}


-(void) addRecipient{
    self.addedSign.hidden = (!self.addedSign.hidden);
}


@end
