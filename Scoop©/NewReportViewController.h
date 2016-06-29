//
//  NewReportViewController.h
//  Scoop©
//
//  Created by Samuel Borowsky on 4/28/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface NewReportViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

{
BOOL newMedia;
UIImage *image;
}

@property (weak, nonatomic) IBOutlet UITextField *name_field; //controls the "username" field
@property (weak, nonatomic) IBOutlet UITextField *location_field; //controls the "username" field
@property (weak, nonatomic) IBOutlet UIButton *submit_report; //controls the "Sign Up" button
@property (weak, nonatomic) IBOutlet UIButton *back_home; //controls the "Sign Up" button
@property (weak, nonatomic) IBOutlet UILabel *title_label; //controls the title label
@property (weak, nonatomic) IBOutlet UIImageView *report_image; //controls the title label
@property (weak, nonatomic) IBOutlet UIButton *select_image_btn;
//@property (nonatomic, strong) UILabel *title_label; //The title, which says "New Report"
//@property (weak, nonatomic) UIView *title_view;

@end
