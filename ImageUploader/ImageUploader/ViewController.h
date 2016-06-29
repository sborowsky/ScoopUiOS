//
//  ViewController.h
//  ImageUploader
//
//  Created by Gavin Fox on 3/11/15.
//  Copyright (c) 2015 Merject LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    UIImageView *imageView;
    BOOL newMedia;
    UIImage *image;
    IBOutlet UITextField *firstname;
    IBOutlet UITextField *lastname;
    IBOutlet UITextField *phone;
}
@property (nonatomic,retain) IBOutlet UIImageView *imageView;

-(IBAction)useCameraRoll:(id)sender;
-(IBAction)submitImage:(id)sender;
@end

