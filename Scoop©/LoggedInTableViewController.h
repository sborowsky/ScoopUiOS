//
//  Scoop©
//  Sam Borowsky
//  LoggedInTableViwController.h
//  The header file for the news feed table view controller.
//  02.12.2015
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

////// core data stuff //////

@interface LoggedInTableViewController : UITableViewController<UITableViewDataSource,
UITableViewDelegate,CLLocationManagerDelegate>

{
    CLLocationManager *locationManager;
}
 
@property (readwrite) int isFull;
@property (weak, nonatomic) IBOutlet UITableView *myTableView; //connection to the table view
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;

@property (weak, nonatomic) IBOutlet UIButton *report_button; //controls the "Sign Up" button

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

