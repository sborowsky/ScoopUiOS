//
//  NewsCell.m
//  Scoop©
//
//  Created by Samuel Borowsky on 3/17/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

{
    //this sets the
    UILabel *_messageLabel;
    UILabel *_timeLabel;
    //UILabel *_carLabel;
    //**********
    //UILabel *_phoneLabel;
    //UILabel *_distLabel;
    //UILabel *_ratingLabel;
    
    UIImageView *_imageShadow;
    UIWebView *_riderImage;
    
    //UIButton *_likeButton;
    UIImage *_likeImage;
    
    //UILabel *_totalLikesLabel;
    //**********
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        //NSLog(@"width: %f", self.frame.size.width);
        //NSLog(@"width 2: %f", [UIScreen mainScreen].applicationFrame.size.width);
        
        CGRect riderPicRectangle = CGRectMake(self.frame.size.width/30, 10, 60, 60);
        
        _imageShadow = [[UIImageView alloc] initWithFrame:riderPicRectangle];
        _imageShadow.layer.cornerRadius = 30;
        //_imageShadow.layer.shadowColor = [UIColor blackColor].CGColor;
        //_imageShadow.layer.shadowOffset = CGSizeMake(5.0, 5.0);
        //_imageShadow.layer.shadowOpacity = 0.8;
        //_imageShadow.layer.shadowRadius = 5.0;
        [self.contentView addSubview:_imageShadow];
     
        
        _riderImage = [[UIWebView alloc] initWithFrame:riderPicRectangle];
        _riderImage.layer.cornerRadius = 30;
        [_riderImage.layer setMasksToBounds:YES];
        //[[_riderImage layer] setBorderColor:[UIColor darkGrayColor].CGColor];
        //[[_riderImage layer] setBorderWidth:1.0f];
        [self.contentView addSubview:_riderImage];
        //**********
        
    
        CGRect messageRectangle = CGRectMake([UIScreen mainScreen].applicationFrame.size.width/4, 5, [UIScreen mainScreen].applicationFrame.size.width/1.8, 70);
        _messageLabel = [[UILabel alloc] initWithFrame:messageRectangle];
        //_messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _messageLabel.numberOfLines = 3;
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_messageLabel];
        
        
        CGRect likeButtonRectangle = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-60, 45, 25, 25);
        _likeButton = [[UIButton alloc] initWithFrame:likeButtonRectangle];
        //[_likeButton setBackgroundImage:[UIImage imageNamed:@"beforeLike.jpg"] forState:UIControlStateNormal];
        [self.contentView addSubview:_likeButton];
        
        CGRect likeTotalRectangle = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-35, 47, 25, 25);
        _totalLikesLabel = [[UILabel alloc] initWithFrame:likeTotalRectangle];
        _totalLikesLabel.textAlignment = NSTextAlignmentCenter;
        //[_totalLikesLabel setText:@"0"];
        [self.contentView addSubview:_totalLikesLabel];
        
        CGRect timeRectangle = CGRectMake([UIScreen mainScreen].applicationFrame.size.width-50, 17, 30, 20);
        _timeLabel = [[UILabel alloc] initWithFrame:timeRectangle];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_timeLabel];
        /*
        CGRect phoneLabelRectangle = CGRectMake(160, 35, 200, 20);
        _phoneLabel = [[UILabel alloc] initWithFrame:phoneLabelRectangle];
        [self.contentView addSubview:_phoneLabel];
        
        CGRect distLabelRectangle = CGRectMake(270, 35, 200, 20);
        _distLabel = [[UILabel alloc] initWithFrame:distLabelRectangle];
        [self.contentView addSubview:_distLabel];
        */
    }
    return self;
}

-(void)setMessageLabelValue:(NSString *)cN{
    if(![cN isEqualToString: _messageLabelValue]){
        _messageLabelValue=[cN copy];
        _messageLabel.font = [UIFont fontWithName:@"DevanagariSangamMN" size:15];
        //_messageLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:1];
        _messageLabel.text = _messageLabelValue;
    }
}

-(void)setLikeTotal:(NSString *)total{
    if(![total isEqualToString: _likeTotal]){
        _likeTotal=[total copy];
        _totalLikesLabel.font = [UIFont fontWithName:@"DevanagariSangamMN" size:15];
        _totalLikesLabel.text = total;
    }}


-(void)setTimeLabelValue:(NSString *)cT{
    if(![cT isEqualToString: _timeLabelValue]){
        _timeLabelValue=[cT copy];
        _timeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
        _timeLabel.text = _timeLabelValue;
        _timeLabel.textColor = [UIColor grayColor];

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

-(void)setRiderImageName:(NSString *)dN{
    if(![dN isEqualToString: _riderImageName]){
        _riderImageName=[dN copy];
        //we have to set the image into a webview
        NSString *url=@"http://dubyuhnellapps.com/team_folders/scoop/newsfeed_picture.php?image=";
        NSString *url2=[url stringByAppendingString:_riderImageName];
        NSURL *nsurl=[NSURL URLWithString:url2];
        NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
        [_riderImage loadRequest:nsrequest];
        [_riderImage setUserInteractionEnabled:NO];
    }
}

-(void)setLikeImageName:(NSString *)image{
    if(![image isEqualToString: _likeImageName]){
        _likeImageName=[image copy];
        _likeImage = [UIImage imageNamed:image];
        [_likeButton setBackgroundImage:_likeImage forState:UIControlStateNormal];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}


@end

