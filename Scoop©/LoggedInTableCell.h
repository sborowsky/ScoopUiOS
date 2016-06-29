//
//  Scoop©
//  Sam Borowsky
//  TableCell.h
//  The header file for the news feed table cell controller.
//  02.12.2015
//

#import <UIKit/UIKit.h>

@interface LoggedInTableCell : UITableViewCell //LoggedInTableCell is a subclass of UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *riderImage; //controls the rider image field
@property (strong, nonatomic) IBOutlet UILabel *DescriptionLabel; //controls the description label
@property (strong, nonatomic) IBOutlet UIButton *LikeBtn; //controls the "Like" button
@property (strong, nonatomic) IBOutlet UIButton *CommentBtn; //controls the "Comment" button
@property (strong, nonatomic) IBOutlet UILabel *TimeLabel; //controls the time label

@end