//
//  NewsCell.h
//  Scoop©
//
//  Created by Samuel Borowsky on 3/17/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCell : UITableViewCell

{}

@property (copy, nonatomic) NSString *messageLabelValue; //controls the driver name label
@property (copy, nonatomic) NSString *timeLabelValue;
//@property (copy, nonatomic) NSString *carValue; //controls the car description label
//@property (copy, nonatomic) NSString *phoneValue;
//@property (copy, nonatomic) NSString *distValue;
@property (copy, nonatomic) NSString *riderImageName;
@property (copy, nonatomic) NSString *likeImageName;
@property (copy, nonatomic) NSString *likeTotal;
@property (strong, nonatomic) UIButton *likeButton;
@property (strong, nonatomic) UILabel *totalLikesLabel;

@end

