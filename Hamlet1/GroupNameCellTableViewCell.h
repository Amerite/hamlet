//
//  GroupNameCellTableViewCell.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 24..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupNameCellTableViewCell : UITableViewCell 


@property (strong, nonatomic) IBOutlet UITextField *groupNameField;
@property (strong, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (strong, nonatomic) NSString *name;


@end
