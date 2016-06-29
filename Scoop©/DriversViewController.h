//
//  Scoop©
//  Sam Borowsky
//  DriversTableViewController.h
//  The header file for the avialable drivers table controller
//  01.29.2015
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface DriversViewController : UIViewController<UITableViewDataSource,
UITableViewDelegate,CLLocationManagerDelegate,UINavigationControllerDelegate>

{
    CLLocationManager *locationManager;
}
@property (readwrite) int isFull;
@property (weak, nonatomic) IBOutlet UITableView *driversTableView; //connection to the table view
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;
@property (nonatomic, retain) UIView *title_view; //controls the title label
//@property (weak, nonatomic) IBOutlet UILabel *AvailableLabel; //controls the title label
@property (nonatomic, strong) NSArray *Images; //An array for images of the drivers
@property (nonatomic, strong) NSArray *Phones;
@property (nonatomic, strong) NSArray *Names; //An array for the names of the drivers
@property (nonatomic, strong) NSArray *Cars; //An array for the type of each car (make and model)
@property (nonatomic, strong) NSArray *Ratings; //An array for the drivers' ratings
@property (nonatomic, strong) NSArray *Availability;//An array for the availability status of each
//driver (yes=available, no=not available)
@property (nonatomic, strong) NSArray *Proximity; //An array for the drivers' distances from the user

@property(nonatomic,strong) NSMutableArray *driverArray;

@end
