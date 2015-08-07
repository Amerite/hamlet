//
//  AlbumViewController.m
//  Hamlet1
//
//  Created by Nomit on 2015. 7. 28..
//  Copyright (c) 2015년 nomit. All rights reserved.
//

#import "AlbumViewController.h"
#import "MainViewController.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:NO];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = NO;
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
   
    self.imagePicker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}


#pragma mark - Image Picker Controller delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.image.image =[info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@"image type : %@", [[info objectForKey:UIImagePickerControllerOriginalImage] class]);
    if (self.image.image == nil) {
        NSLog(@"Picture didn't pass!");
    }
    else{
    NSLog(@"pass");
    [self.delegate didAddPicture:[info objectForKey:UIImagePickerControllerOriginalImage]];
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
}


@end
