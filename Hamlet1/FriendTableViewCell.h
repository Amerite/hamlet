//
//  FriendTableViewCell.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 28..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "MGSwipeTableCell.h"

@interface FriendTableViewCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UILabel *friendName;
@property (weak, nonatomic) IBOutlet UILabel *addedSign;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UILabel *favStar;

- (IBAction)changeFavorite:(id)sender;
- (void) addRecipient;


@end
