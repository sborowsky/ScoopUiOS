//
//  CustomCell.m
//  Scoop©
//
//  Created by Samuel Borowsky on 3/17/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
{
    //this sets the
    UILabel *_nameLabel;
    UILabel *_carLabel;
    //**********
    UILabel *_phoneLabel;
    UILabel *_distLabel;
    UILabel *_ratingLabel;
    
    UIImageView *_imageShadow;
    UIWebView *_driverImage;
    
    UIImageView *_driverNoImage;
    //**********
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        //**********
        CGRect driverPicRectangle = CGRectMake(10, 10, 60, 60);
        
        _imageShadow = [[UIImageView alloc] initWithFrame:driverPicRectangle];
        _imageShadow.layer.cornerRadius = 30;
        _imageShadow.layer.shadowColor = [UIColor blackColor].CGColor;
        _imageShadow.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        _imageShadow.layer.shadowOpacity = 0.8;
        _imageShadow.layer.shadowRadius = 5.0;
        [self.contentView addSubview:_imageShadow];
        
        
        _driverImage = [[UIWebView alloc] initWithFrame:driverPicRectangle];
        _driverImage.layer.cornerRadius = 30;
        //[[_driverImage layer] setBorderColor:[UIColor darkGrayColor].CGColor];
        //[[_driverImage layer] setBorderWidth:1.0f];
        [_driverImage.layer setMasksToBounds:YES];
        [self.contentView addSubview:_driverImage];
        //**********
        
        _driverNoImage = [[UIImageView alloc] initWithFrame:driverPicRectangle];
        _driverNoImage.layer.cornerRadius = 30;
        _driverNoImage.layer.masksToBounds = YES;
        [self.contentView addSubview:_driverNoImage];
    
        
        CGRect nameLabelRectangle = CGRectMake([UIScreen mainScreen].applicationFrame.size.width/4, 15, 100, 20);
        _nameLabel = [[UILabel alloc] initWithFrame:nameLabelRectangle];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        //_nameLabel.layer.borderColor = [UIColor blackColor].CGColor;
        //_nameLabel.layer.borderWidth = 1.0;
        [self.contentView addSubview:_nameLabel];
        
        CGRect carLabelRectangle = CGRectMake([UIScreen mainScreen].applicationFrame.size.width/4, 30, 55, 50);
        _carLabel = [[UILabel alloc] initWithFrame:carLabelRectangle];
        _carLabel.numberOfLines = 2;
        _carLabel.textColor = [UIColor darkGrayColor];
        _carLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_carLabel];
        
        CGRect phoneLabelRectangle = CGRectMake([UIScreen mainScreen].applicationFrame.size.width/2.1, 28, 200, 20);
        _phoneLabel = [[UILabel alloc] initWithFrame:phoneLabelRectangle];
        [_phoneLabel setTextColor:self.tintColor];
        [self.contentView addSubview:_phoneLabel];
        
        CGRect distLabelRectangle = CGRectMake([UIScreen mainScreen].applicationFrame.size.width/1.2, 30, 200, 20);
        _distLabel = [[UILabel alloc] initWithFrame:distLabelRectangle];
        _distLabel.textColor = [UIColor darkGrayColor];
        [self.contentView addSubview:_distLabel];
        
    }
    return self;
}

-(void)setNameLabelValue:(NSString *)cN{
    if(![cN isEqualToString: _nameLabelValue]){
        _nameLabelValue=[cN copy];
        _nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        _nameLabel.text = _nameLabelValue;
    }
}

-(void)setCarValue:(NSString *)cT{
    if(![cT isEqualToString: _carValue]){
        _carValue=[cT copy];
        _carLabel.font = [UIFont fontWithName:@"DevanagariSangamMN" size:14];
        _carLabel.text = _carValue;
    }
}

-(void)setPhoneValue:(NSString *)cP{
    if(![cP isEqualToString: _phoneValue]){
        _phoneValue=[cP copy];
        _phoneLabel.font = [UIFont fontWithName:@"ChalkboardSE-Light" size:14];
        _phoneLabel.text = _phoneValue;
    }
}

-(void)setDistValue:(NSString *)cD{
    if(![cD isEqualToString: _distValue]){
        _distValue=[cD copy];
        _distLabel.font = [UIFont fontWithName:@"DevanagariSangamMN" size:14];
        _distLabel.text = _distValue;
    }
}

-(void)setDriverImageName:(NSString *)dN{
    if(![dN isEqualToString: _driverImageName]){
        _driverImageName=[dN copy];
        //we have to set the image into a webview
        NSString *url=@"http://dubyuhnellapps.com/team_folders/scoop/picture.php?image=";
        NSString *url2=[url stringByAppendingString:_driverImageName];
        NSURL *nsurl=[NSURL URLWithString:url2];
        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        [_driverImage loadRequest:nsrequest];
        [_driverImage setUserInteractionEnabled:NO];
    }
}

-(void)setDriverNoImageName:(NSString *)dNIN{
    if(![dNIN isEqualToString: _driverNoImageName]){
        UIImage *image = [UIImage imageNamed:dNIN];
        [_driverNoImage setImage:image];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end
