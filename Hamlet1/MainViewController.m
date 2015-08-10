//
//  MainViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 27..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"
#import "ImageEditViewController.h"
#import "FeedbackViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.capturedImages count] == 0) {
        self.capturedImages = [[NSMutableArray alloc] init];
        self.imageView.image = [UIImage alloc];
        self.imageView.hidden = YES;
    }
    
    //Set UIImagePickerControllerSourceType
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {

        }
    
    
    // Check for currentUser
    if (self.currentUser.username == 0){
        [self.navigationItem setHidesBackButton:YES animated:NO];
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
    else { [self.currentUser userDetails];
    }
    
    if ([self.messages.library count] == 0) {
        self.messages = [[PictureLibrary alloc] init];
    }

    
}

    
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
 
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    NSArray *inbox = [NSArray arrayWithArray:[self.messages retrieveMessagesWithUsername:self.currentUser.username sender:NO]];
    if ([inbox count] != 0) {
        self.contactButton.title = @"Inbox";
    } else self.contactButton.title = @"Contacts";
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"recipients : %@", self.recipients);
}


- (void) showImagePickerForSourceType: (UIImagePickerControllerSourceType) sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    
    if(sourceType == UIImagePickerControllerSourceTypeCamera) {
        imagePickerController.showsCameraControls = NO;
        [[NSBundle mainBundle] loadNibNamed:@"OverlayView" owner:self options:nil];
        self.overlayView.frame = imagePickerController.cameraOverlayView.frame;
        imagePickerController.cameraOverlayView = self.overlayView;
        self.overlayView = nil;
    }
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
    
}




#pragma mark - Navigation

- (IBAction)pushContacts:(id)sender {
    [self performSegueWithIdentifier:@"showContacts" sender:self];
    
}

- (IBAction)pushAlbum:(id)sender {
    [self performSegueWithIdentifier:@"showAlbum" sender:self];
}

- (IBAction)pushSettings:(id)sender {
    [self performSegueWithIdentifier:@"showSettings" sender:self];
}

- (IBAction)camTurn:(id)sender {
    
}

- (IBAction)takePic:(id)sender {
    [self.imagePickerController takePicture];
}


- (IBAction)pushFeedback:(id)sender {
    [self performSegueWithIdentifier:@"showFeedback" sender:self];
    
}

# pragma mark - Additional methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.capturedImages addObject:image];
    [self finishAndUpdate];
}

- (void) finishAndUpdate{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if ([self.capturedImages count] > 0) {
        if ([self.capturedImages count] == 1) {
            [self.imageView setImage:[self.capturedImages objectAtIndex:0]];
            [self performSegueWithIdentifier:@"showImageEdit" sender:self];
        }
    }
    self.imagePickerController = nil;
}






// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"showLogin"]) {
        LoginViewController *viewController = (LoginViewController *) segue.destinationViewController;
        viewController.navigationItem.hidesBackButton = YES;
    }
    
    if ([segue.identifier isEqualToString:@"showFeedback"]) {
        FeedbackViewController *viewController = (FeedbackViewController *) segue.destinationViewController;
        viewController.messages = [self.messages retrieveMessagesWithUsername:self.currentUser.username sender:YES];
        [viewController.navigationController setNavigationBarHidden:NO animated:NO];
    }
    
    
    if ([segue.identifier isEqualToString:@"showContacts"]) {
        FriendsTableViewController *tableController = (FriendsTableViewController *) segue.destinationViewController;
        tableController.currentUser = self.currentUser;
        tableController.userLibrary = self.userLibrary;
        if (self.sent == YES) {
            tableController.recipients = @[];
            self.sent = NO;
            NSLog(@"SENT");
        }
        else {
            tableController.recipients = self.recipients;
        }
        if ([self.contactButton.title isEqualToString: @"Inbox"]) {
            tableController.messages = self.messages;
        }
        [tableController.navigationController setNavigationBarHidden:NO animated:NO];
    }
    
    if ([segue.identifier isEqualToString:@"showAlbum"]) {
        AlbumViewController *viewController = (AlbumViewController *) segue.destinationViewController;
        [viewController.navigationController setNavigationBarHidden:NO animated:NO];
        viewController.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:@"showImageEdit"]) {
        ImageEditViewController *viewController = (ImageEditViewController *) segue.destinationViewController;
        viewController.picture.image = [[UIImage alloc] init];
        viewController.temp = self.imageView.image;
        NSLog(@"HOLA");
        viewController.currentUser = self.currentUser;
        viewController.recipients = self.recipients;

        
    }
    
}


#pragma mark - delegate methods


-(void)didAddPicture:(UIImage *)picture{
    [self.capturedImages removeAllObjects];
    [self.capturedImages addObject:picture];
    [self.view reloadInputViews];
    [self.imageView setImage: [self.capturedImages objectAtIndex:0]];
    [self performSegueWithIdentifier:@"showImageEdit" sender:self];
}


-(void) returnToMain: (PictureMessage *)message{
    [message messageDetails];
    
    [self.capturedImages removeAllObjects];
    NSArray *newRecipients = [[NSArray alloc] init];
    self.recipients = newRecipients;
    self.imageView.image = nil;
    self.sent = YES;
    [self.messages.library addObject:message];
    
}



@end
