//
//  Scoop©
//  Sam Borowsky
//  TableCell.h
//  The header file for the table cell controller.
//  01.29.2015
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *NameLabel; //controls the driver name label
@property (strong, nonatomic) IBOutlet UILabel *CarLabel; //controls the car description label
@property (strong, nonatomic) IBOutlet UILabel *RatingLabel; //controls the driver rating label
@property (strong, nonatomic) IBOutlet UIImageView *DriverImage; //controls the drive image field
@property (strong, nonatomic) IBOutlet UILabel *ProximityLabel; //controls the driver proximity label


@end
