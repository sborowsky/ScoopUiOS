//
//  GetScoopedViewController.h
//  Scoop©
//
//  Created by Gavin Fox on 3/5/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface GetScoopedViewController : UIViewController<CLLocationManagerDelegate>{
    IBOutlet UIButton *scoopUp;
    IBOutlet UITextView *scoopUpLabel;
    CLLocationManager *locationManager;
}
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;
@property(nonatomic,strong) IBOutlet UIButton *scoopUp;

@end