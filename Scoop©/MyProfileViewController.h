//
//  MyProfileViewController.h
//  Scoop©
//
//  Created by Samuel Borowsky on 2/19/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface MyProfileViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
//@property (weak, nonatomic) IBOutlet UIButton *edit_btn; //controls the "Edit" button
//@property (weak, nonatomic) IBOutlet UIButton *sign_out_btn; //controls the "Sign Out" button

IBOutlet UITextField *f_name_label; //controls the first name label
IBOutlet UITextField *l_name_label; //controls the last name label
IBOutlet UITextField *email_label; //controls the email label
IBOutlet UITextField *car_label;
IBOutlet UITextField *phone_label; //controls the phone number label
IBOutlet UITextField *address_label; //controls the address label
IBOutlet UIButton *profileImage;
    
IBOutlet UILabel *points_label; //controls the scoop points label

    
UIImageView *imageView;
BOOL newMedia;
UIImage *image;

}

@property (nonatomic,retain) IBOutlet UIImageView *imageView;
@property (nonatomic,retain) IBOutlet UIButton *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel; //controls the title label
@property(nonatomic,strong) IBOutlet UIButton *update_profile;


//- (IBAction)edit_profile:(id)sender; //allows user to edit profile info upon clicking "Edit"
//- (IBAction)sign_out_user:(id)sender; //signs user out of the app upon clicking "Sign Out"
//- (IBAction)done_editing:(id)sender; //allows user to stop editing profile and save changes



@end
