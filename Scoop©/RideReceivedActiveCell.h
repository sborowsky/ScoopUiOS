//
//  RideReceivedActiveCell.h
//  Scoop©
//
//  Created by Samuel Borowsky on 7/17/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RideReceivedActiveCell : UITableViewCell

@property (copy, nonatomic) NSString *nameLabelValue; //controls the name label value
//@property (copy, nonatomic) NSString *carLabelValue; //controls the car label value
@property (copy, nonatomic) NSString *statusValue; //controls the value of the status label
@property (copy, nonatomic) NSString *phoneValueLeft;
@property (copy, nonatomic) NSString *phoneValueCenter;
@property (copy, nonatomic) NSString *distLabelValue;
@property (copy, nonatomic) NSString *driverImageName;
@property (copy, nonatomic) NSString *ratingImageName;
@property (copy, nonatomic) NSString *venmoImageName;

@end
