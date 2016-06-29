//
//  Scoop©
//  Sam Borowsky
//  LoginUserViewController.h
//  The header file for the log in/register page controller.
//  01.29.2015
//

#import <UIKit/UIKit.h>

@interface LoginUserViewController : UIViewController //LoginUserViewController is a
//subclass of UIViewController
{
    IBOutlet UIImageView *coverPlate;
}

//@property (weak, nonatomic) UIView *subview ; //the header for the view
@property (weak, nonatomic) IBOutlet UIButton *registerBtn; //controls the "Sign Up" button
@property (weak, nonatomic) IBOutlet UIButton *loginBtn; //controls the "Login" button
@property (weak, nonatomic) IBOutlet UITextField *firstNameField; //controls the "username" field
@property (weak, nonatomic) IBOutlet UITextField *lastNameField; //controls the "username" field
@property (weak, nonatomic) IBOutlet UITextField *cellField; //controls the "cell phone" field
@property (weak, nonatomic) IBOutlet UITextField *emailField; //controls the "password" field
@property (weak, nonatomic) IBOutlet UITextField *reEnterEmailField; //controls the "re-enter password field"
@property (weak, nonatomic) IBOutlet UITextField *carModelField; //controls the "re-enter password field"
@property (weak, nonatomic) IBOutlet UIImageView *scoopLogo; //controls the scoop logo
@property (weak, nonatomic) IBOutlet UIImageView *generalsLogo; //controls the W&L logo
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel; //controls the W&L logo

@property(readwrite) int *internalCode;


- (IBAction)registerUser:(id)sender; //registers a new user when he or she clicks "Sign Up"


@end

