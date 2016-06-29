//
//  CustomCell.h
//  Scoop©
//
//  Created by Samuel Borowsky on 3/17/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

{}

@property (copy, nonatomic) NSString *nameLabelValue; //controls the driver name label
@property (copy, nonatomic) NSString *carValue; //controls the car description label
@property (copy, nonatomic) NSString *phoneValue;
@property (copy, nonatomic) NSString *distValue;
@property (copy, nonatomic) NSString *driverImageName;
@property (copy, nonatomic) NSString *driverNoImageName;


@end
