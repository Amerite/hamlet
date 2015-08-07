//
//  AlbumViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 28..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AlbumViewController;
@protocol AlbumViewControllerDelegate <NSObject> ;
- (void) didAddPicture:(UIImage *)picture;
@end



@interface AlbumViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic) UIImagePickerController *imagePicker;
@property (nonatomic, strong) IBOutlet UIImageView *image;

@property (nonatomic, assign) id <AlbumViewControllerDelegate> delegate;


@end
