//
//  AddUserCellTableViewCell.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 23..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddUserCellTableViewCell : UITableViewCell

- (IBAction)addContact:(id)sender;

@property (nonatomic, weak) IBOutlet UIButton *addButton;

@end
