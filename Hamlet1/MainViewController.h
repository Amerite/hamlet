//
//  MainViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 27..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "PictureMessage.h"
#import "AlbumViewController.h"
#import "FriendsTableViewController.h"
#import "PictureLibrary.h"



@interface MainViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, AlbumViewControllerDelegate, ReturnToMainDelegate>

@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) NSArray *userLibrary;
@property (nonatomic, strong) NSArray *recipients;

@property (nonatomic) IBOutlet UIView *overlayView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *capturedImages;

@property (nonatomic, strong) PictureLibrary *messages;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *contactButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *feedbackButton;

- (IBAction)pushFeedback:(id)sender;
- (IBAction)pushContacts:(id)sender;

- (IBAction)pushAlbum:(id)sender;
- (IBAction)pushSettings:(id)sender;
- (IBAction)camTurn:(id)sender;
- (IBAction)takePic:(id)sender;

@property (nonatomic) BOOL sent;




@end
