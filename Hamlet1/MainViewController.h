//
//  MainViewController.h
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 27..
//  Copyright (c) 2015년 nomit. All rights reserved.
//
//  This is Main ViewController: Buttons, Camera input

#import <UIKit/UIKit.h>
#import "User.h"
#import "PictureMessage.h"
#import "AlbumViewController.h"
#import "FriendsTableViewController.h"
#import "PictureLibrary.h"



@interface MainViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, AlbumViewControllerDelegate, ReturnToMainDelegate>

//  Login information
@property (nonatomic, strong) User *currentUser;
@property (nonatomic, strong) NSArray *userLibrary;
@property (nonatomic, strong) NSArray *recipients;


//  Camera and layout
@property (nonatomic) IBOutlet UIView *overlayView;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSMutableArray *capturedImages;

//  All messages
@property (nonatomic, strong) PictureLibrary *messages;

//  Tab bar
@property (weak, nonatomic) IBOutlet UIBarButtonItem *contactButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *feedbackButton;


//  Button actions
- (IBAction)pushFeedback:(id)sender;
- (IBAction)pushContacts:(id)sender;

- (IBAction)pushAlbum:(id)sender;
- (IBAction)pushSettings:(id)sender;

- (IBAction)camTurn:(id)sender;
- (IBAction)takePic:(id)sender;

@property (nonatomic) BOOL sent;




@end
