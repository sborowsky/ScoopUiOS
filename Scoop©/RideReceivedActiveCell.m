//
//  RideReceivedActiveCell.m
//  Scoop©
//
//  Created by Samuel Borowsky on 7/17/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "RideReceivedActiveCell.h"

@implementation RideReceivedActiveCell


{
    //this sets the
    UILabel *_nameLabel;
    UILabel *_carLabel;
    UILabel *_distLabel;
    UILabel *_statusLabel;
    //UILabel *_statusLabel;
    //UILabel *_phoneLabel;
    UIImageView *_venmoImageView;
    UIImage *_venmoImage;
    UIImageView *_driverImageView;
    UIWebView *_driverImage;
    UIImageView *_ratingImageView;
    UIImage *_ratingImage;
    UIImageView *_phoneImageViewLeft;
    UIImage *_phoneImage;
    UIImageView *_phoneImageViewCenter;
    //UIImage *_phoneImageCenter;
    //UIWebView *_riderImage;
    //**********
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        
        CGRect driverPicRectangle = CGRectMake(10, 10, 70, 70);
        
        _driverImageView = [[UIImageView alloc] initWithFrame:driverPicRectangle];
        _driverImageView.layer.cornerRadius = 35;
        //_driverImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        //_driverImageView.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        //_driverImageView.layer.shadowOpacity = 0.8;
        //_driverImageView.layer.shadowRadius = 5.0;
        
        _driverImageView.layer.borderColor = [UIColor blackColor].CGColor;
        _driverImageView.layer.masksToBounds = YES;
        _driverImageView.layer.borderWidth = 1.0;
        
        [self.contentView addSubview:_driverImageView];
        
        
        _driverImage = [[UIWebView alloc] initWithFrame:driverPicRectangle];
        _driverImage.layer.cornerRadius = 35;
        [_driverImage.layer setMasksToBounds:YES];
        [[_driverImage layer] setBorderColor:[UIColor darkGrayColor].CGColor];
        [[_driverImage layer] setBorderWidth:1.0f];
        [self.contentView addSubview:_driverImage];
        
        
        CGRect nameRectangle = CGRectMake(85, 10, 120, 20);
        _nameLabel = [[UILabel alloc] initWithFrame:nameRectangle];

        //_nameLabel.layer.borderColor = [UIColor blackColor].CGColor;
        //_nameLabel.layer.borderWidth = 2.0;
        
        //_messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _nameLabel.numberOfLines = 1;
        [self.contentView addSubview:_nameLabel];
        
        CGRect phoneLeftPicRectangle = CGRectMake(90, 43, 25, 25);
        _phoneImageViewLeft = [[UIImageView alloc] initWithFrame:phoneLeftPicRectangle];
        //_driverImageView.layer.cornerRadius = 30;
        //_driverImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        //_driverImageView.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        //_driverImageView.layer.shadowOpacity = 0.8;
        //_driverImageView.layer.shadowRadius = 5.0;
        //_phoneImage = [UIImage imageNamed: @"call_blue1.png"];
        _phoneImageViewLeft.image = _phoneImage;
        [self.contentView addSubview:_phoneImageViewLeft];
        
        CGRect phoneCenterPicRectangle = CGRectMake(130, 40, 25, 25);
        _phoneImageViewCenter = [[UIImageView alloc] initWithFrame:phoneCenterPicRectangle];
        _phoneImageViewCenter.image = _phoneImage;
        [self.contentView addSubview:_phoneImageViewCenter];
        
        
        CGRect ratingPicRectangle = CGRectMake(130, 40, 30, 30);
        _ratingImageView = [[UIImageView alloc] initWithFrame:ratingPicRectangle];
        [self.contentView addSubview:_ratingImageView];

        CGRect venmoPicRectangle = CGRectMake(170, 41, 30, 30);
        _venmoImageView = [[UIImageView alloc] initWithFrame:venmoPicRectangle];
        _venmoImageView.layer.cornerRadius = 10;
        _venmoImageView.layer.masksToBounds = YES;
        _venmoImage = [UIImage imageNamed: @"venmo.png"];
        //_venmoImageView.image = _venmoImage;
        [self.contentView addSubview:_venmoImageView];

        
        
        //_carLabel = [[UILabel alloc] initWithFrame:carRectangle];
        //_carLabel.layer.borderColor = [UIColor blueColor].CGColor;
        //_carLabel.layer.borderWidth = 2.0;
        //_carLabel.numberOfLines = 2;
        //[self.contentView addSubview:_carLabel];
        
        /*
         CGRect phoneLabelRectangle = CGRectMake(160, 35, 200, 20);
         _phoneLabel = [[UILabel alloc] initWithFrame:phoneLabelRectangle];
         [self.contentView addSubview:_phoneLabel];
        */
         
         CGRect distLabelRectangle = CGRectMake(170, 20, 80, 50);
         _distLabel = [[UILabel alloc] initWithFrame:distLabelRectangle];
        
         //_distLabel.layer.borderColor = [UIColor redColor].CGColor;
         //_distLabel.layer.borderWidth = 3.0;
        
         [self.contentView addSubview:_distLabel];

        
        CGRect statusRectangle = CGRectMake(225, 20, 85, 50);
        _statusLabel = [[UILabel alloc] initWithFrame:statusRectangle];
        _statusLabel.numberOfLines = 1;
        
        //_statusLabel.layer.borderColor = [UIColor orangeColor].CGColor;
        //_statusLabel.layer.borderWidth = 2.0;
        
        [self.contentView addSubview:_statusLabel];
    }
    return self;
}

-(void)setNameLabelValue:(NSString *)name{
    if(![name isEqualToString: _nameLabelValue]){
        _nameLabelValue=[name copy];
        _nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = _nameLabelValue;
    }
}

/*
-(void)setCarLabelValue:(NSString *)car{
    if(![car isEqualToString: _carLabelValue]){
        _carLabelValue=[car copy];
        _carLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        _carLabel.textAlignment = NSTextAlignmentCenter;
        _carLabel.text = _carLabelValue;
        _carLabel.textColor = [UIColor grayColor];
        
    }
}
*/

-(void)setDistLabelValue:(NSString *)distance{
    if(![distance isEqualToString: _distLabelValue]){
        _distLabelValue=[distance copy];
        _distLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        _distLabel.textAlignment = NSTextAlignmentCenter;
        _distLabel.text = _distLabelValue;
        //_distLabel.textColor = [UIColor grayColor];
        
    }
}

-(void)setStatusValue:(NSString *)status{
    if(![status isEqualToString: _statusValue]){
        _statusValue=[status copy];
        _statusLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.text = _statusValue;
        if ([_statusValue isEqualToString:@"ACTIVE"]) {
            _statusLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(153/255.0) blue:(51/255.0) alpha:.8];;
        }
        else{
            _statusLabel.textColor = [UIColor grayColor];
        }
    }
}

/*
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
 _distLabel.font = [UIFont fontWithName:@"ChalkboardSE-Light" size:14];
 _distLabel.text = _distValue;
 }
 }
 */

-(void)setDriverImageName:(NSString *)driver{
    if(![driver isEqualToString: _driverImageName]){
        _driverImageName=[driver copy];
        //we have to set the image into a webview
        NSString *url=@"http://dubyuhnellapps.com/team_folders/scoop/picture.php?image=";
        NSString *url2=[url stringByAppendingString:_driverImageName];
        NSURL *nsurl=[NSURL URLWithString:url2];
        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        [_driverImage loadRequest:nsrequest];
        [_driverImage setUserInteractionEnabled:NO];
    }
}

-(void)setRatingImageName:(NSString *)rating{
    if(![rating isEqualToString: _ratingImageName]){
        _ratingImageName=[rating copy];
        //we have to set the image into a webview
        //NSString *url=@"http://dubyuhnellapps.com/team_folders/scoop/newsfeed_picture.php?image=";
        //NSString *url2=[url stringByAppendingString:_riderImageName];
        //NSURL *nsurl=[NSURL URLWithString:url2];
        //NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        //[_riderImage loadRequest:nsrequest];
        //[_riderImage setUserInteractionEnabled:NO];
        _ratingImage = [UIImage imageNamed:rating];
        _ratingImageView.image = _ratingImage;
    }
}

-(void)setPhoneValueLeft:(NSString *)phone{
    if(![phone isEqualToString: _phoneValueLeft]){
        _phoneValueLeft=[phone copy];
        //we have to set the image into a webview
        //NSString *url=@"http://dubyuhnellapps.com/team_folders/scoop/newsfeed_picture.php?image=";
        //NSString *url2=[url stringByAppendingString:_riderImageName];
        //NSURL *nsurl=[NSURL URLWithString:url2];
        //NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        //[_riderImage loadRequest:nsrequest];
        //[_riderImage setUserInteractionEnabled:NO];
        _phoneImage = [UIImage imageNamed:phone];
        _phoneImageViewLeft.image = _phoneImage;
    }
}

-(void)setPhoneValueCenter:(NSString *)phone{
    if(![phone isEqualToString: _phoneValueCenter]){
        _phoneValueCenter=[phone copy];
        //we have to set the image into a webview
        //NSString *url=@"http://dubyuhnellapps.com/team_folders/scoop/newsfeed_picture.php?image=";
        //NSString *url2=[url stringByAppendingString:_riderImageName];
        //NSURL *nsurl=[NSURL URLWithString:url2];
        //NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        //[_riderImage loadRequest:nsrequest];
        //[_riderImage setUserInteractionEnabled:NO];
        _phoneImage = [UIImage imageNamed:phone];
        _phoneImageViewCenter.image = _phoneImage;
    }
}

-(void)setVenmoImageName:(NSString *)venmo{
    if(![venmo isEqualToString: _venmoImageName]){
        _venmoImageName=[venmo copy];
        //we have to set the image into a webview
        //NSString *url=@"http://dubyuhnellapps.com/team_folders/scoop/newsfeed_picture.php?image=";
        //NSString *url2=[url stringByAppendingString:_riderImageName];
        //NSURL *nsurl=[NSURL URLWithString:url2];
        //NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        //[_riderImage loadRequest:nsrequest];
        //[_riderImage setUserInteractionEnabled:NO];
        _venmoImage = [UIImage imageNamed:venmo];
        _venmoImageView.image = _venmoImage;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end


