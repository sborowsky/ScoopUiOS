//
//  ScoopUpViewController.h
//  Scoop©
//
//  Created by Gavin Fox on 3/5/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <StoreKit/StoreKit.h>
#import <sys/utsname.h>


@interface ScoopUpViewController : UIViewController<CLLocationManagerDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver>{
    IBOutlet UIButton *scoopUp;
    IBOutlet UITextView *scoopUpText;
    CLLocationManager *locationManager;
    
        UIAlertView *askToPurchase;
}
@property (nonatomic, retain) UIFont* fontForDevice;
@property (strong, nonatomic) CLLocationManager* locationManager;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;
@property(nonatomic,strong) IBOutlet UIButton *scoopUp;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel; //controls the title label

@end