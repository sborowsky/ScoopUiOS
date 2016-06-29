//
//  Scoop©
//  Sam Borowsky
//  LoggedInTableViwController.h
//  The header file for the news feed table view controller.
//  02.12.2015
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>


@interface NewsViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    CLLocationManager *locationManager;
    BOOL newMedia;
    UIImage *image;
}

@property (nonatomic, retain) NSString *display_str; //tells whether to display table view or report form
@property (nonatomic, retain) NSMutableDictionary *userDict; //dictionary of user information
@property (nonatomic, retain) NSString *user_info;

@property (weak, nonatomic) IBOutlet UITextField *name_field; //controls the "username" field
@property (weak, nonatomic) IBOutlet UILabel *view_label; //controls the "username" field
@property (weak, nonatomic) IBOutlet UITextField *location_field; //controls the "username" field
@property (weak, nonatomic) IBOutlet UIButton *submit_report; //controls the "Sign Up" button
@property (weak, nonatomic) IBOutlet UIButton *back_home; //controls the "Sign Up" button
@property (weak, nonatomic) IBOutlet UILabel *title_label; //controls the title label
@property (weak, nonatomic) UIImageView *report_image; //controls the title label
@property (weak, nonatomic) IBOutlet UIButton *select_image_btn;

@property (nonatomic, retain) UIView *title_view; //controls the title label
@property (weak, nonatomic) NSString *title_str; //controls the title label
@property (nonatomic, retain) UIButton *report_button;
@property (nonatomic, retain) UIButton *back_button;

@property (readwrite) int isFull;
@property (weak, nonatomic) IBOutlet UITableView *myTableView; //connection to the table view
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;

@property(nonatomic,strong) NSMutableArray *riderArray;

//@property (weak, nonatomic) IBOutlet UITextView *title_text_view; //Controls the title of the news feed view
//@property (weak, nonatomic) IBOutlet UITableView *LoggedInTableView; //connection to the logged in
//news feed

@property (nonatomic, strong) NSArray *riderImages; //An array for images of the riders

@end
//@property (nonatomic, strong) NSArray *Destinations; //An array for the destinations of the riders
//@property (nonatomic, strong) NSArray *RiderNames; //An array for the names of the riders
//@property (nonatomic, strong) NSArray *Times; //An array for the arrival times of the riders

//@property (nonatomic, strong) UILabel *titleLabel; //The title, which says "Scoop Feed"
//@property (weak, nonatomic) IBOutlet UIButton *registerBtn; //controls the new report button

//@property (weak, nonatomic) UIView *title_view; //controls the "Sign Up" button