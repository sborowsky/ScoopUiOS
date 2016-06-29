//
//  RideGivenCell.m
//  Scoop©
//
//  Created by Samuel Borowsky on 7/20/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "RideGivenCell.h"

@implementation RideGivenCell

{
    //this sets the
    UILabel *_nameLabel;
    UILabel *_distLabel;
    UILabel *_statusLabel;
    UIImageView *_venmoImageView;
    UIImage *_venmoImage;
    UIImageView *_riderImageView;
    UIWebView *_riderImage;
    UIImageView *_phoneImageView;
    UIImage *_phoneImage;
    UIImageView *_googleImageView;
    UIImage *_googleImage;
    //**********
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        
        CGRect riderPicRectangle = CGRectMake(10, 10, 70, 70);
        
        _riderImageView = [[UIImageView alloc] initWithFrame:riderPicRectangle];
        _riderImageView.layer.cornerRadius = 35;
        _riderImageView.layer.borderColor = [UIColor blackColor].CGColor;
        _riderImageView.layer.masksToBounds = YES;
        _riderImageView.layer.borderWidth = 1.0;
        
        [self.contentView addSubview:_riderImageView];
        
        
         _riderImage = [[UIWebView alloc] initWithFrame:riderPicRectangle];
         _riderImage.layer.cornerRadius = 35;
         [_riderImage.layer setMasksToBounds:YES];
         [[_riderImage layer] setBorderColor:[UIColor darkGrayColor].CGColor];
         [[_riderImage layer] setBorderWidth:1.0f];
         [self.contentView addSubview:_riderImage];
        
        
        CGRect nameRectangle = CGRectMake(85, 10, 100, 20);
        _nameLabel = [[UILabel alloc] initWithFrame:nameRectangle];
        
        //_nameLabel.layer.borderColor = [UIColor blackColor].CGColor;
        //_nameLabel.layer.borderWidth = 2.0;
        
        //_messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _nameLabel.numberOfLines = 1;
        [self.contentView addSubview:_nameLabel];
        
        CGRect phonePicRectangle = CGRectMake(100, 43, 25, 25);
        _phoneImageView = [[UIImageView alloc] initWithFrame:phonePicRectangle];
        //_driverImageView.layer.cornerRadius = 30;
        //_driverImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        //_driverImageView.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        //_driverImageView.layer.shadowOpacity = 0.8;
        //_driverImageView.layer.shadowRadius = 5.0;
        _phoneImage = [UIImage imageNamed: @"call_blue1.png"];
        _phoneImageView.image = _phoneImage;
        [self.contentView addSubview:_phoneImageView];

        
        CGRect venmoPicRectangle = CGRectMake(135, 41, 30, 30);
        _venmoImageView = [[UIImageView alloc] initWithFrame:venmoPicRectangle];
        _venmoImageView.layer.cornerRadius = 10;
        _venmoImageView.layer.masksToBounds = YES;
        _venmoImage = [UIImage imageNamed: @"venmo.png"];
        _venmoImageView.image = _venmoImage;
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
        
        CGRect distLabelRectangle = CGRectMake(200, 10, 45, 20);
        _distLabel = [[UILabel alloc] initWithFrame:distLabelRectangle];
        //_distLabel.layer.borderColor = [UIColor redColor].CGColor;
        //_distLabel.layer.borderWidth = 3.0;
        [self.contentView addSubview:_distLabel];
        
        CGRect googlePicRectangle = CGRectMake(205, 37, 35, 35);
        _googleImageView = [[UIImageView alloc] initWithFrame:googlePicRectangle];
        _googleImageView.layer.cornerRadius = 10;
        _googleImageView.layer.masksToBounds = YES;
        //_googleImage = [UIImage imageNamed: @"google.png"];
        //_venmoImageView.image = _venmoImage;
        [self.contentView addSubview:_googleImageView];
        
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

-(void)setRiderImageName:(NSString *)rider{
    if(![rider isEqualToString: _riderImageName]){
        _riderImageName=[rider copy];
        //we have to set the image into a webview
        NSString *url=@"http://dubyuhnellapps.com/team_folders/scoop/picture.php?image=";
        NSString *url2=[url stringByAppendingString:_riderImageName];
        NSURL *nsurl=[NSURL URLWithString:url2];
        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        [_riderImage loadRequest:nsrequest];
        [_riderImage setUserInteractionEnabled:NO];
    }
}

/*
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
*/

-(void)setGoogleImageName:(NSString *)google{
    if(![google isEqualToString: _googleImageName]){
        _googleImageName=[google copy];
        //we have to set the image into a webview
        //NSString *url=@"http://dubyuhnellapps.com/team_folders/scoop/newsfeed_picture.php?image=";
        //NSString *url2=[url stringByAppendingString:_riderImageName];
        //NSURL *nsurl=[NSURL URLWithString:url2];
        //NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        //[_riderImage loadRequest:nsrequest];
        //[_riderImage setUserInteractionEnabled:NO];
        _googleImage = [UIImage imageNamed:google];
        _googleImageView.image = _googleImage;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end



