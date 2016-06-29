//
//  ScoopUpViewController.m
//  Scoop©
//
//  Created by Gavin Fox on 3/5/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//



//You have to add the following to the info.plist
//NSLocationWhenInUseUsageDescription
//NSLocationAlwaysUsageDescription

#import "ScoopUpViewController.h"
#import "ScoopAppDelegate.h"

@interface ScoopUpViewController ()

@end

@implementation ScoopUpViewController

@synthesize scoopUp,locationManager,lat,lon,fontForDevice;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lat = @"39.50000000";
    lon = @"75.10000000";
    
    //scoopUpText.adjustsFontSizeToFitWidth = YES;
    NSString *deviceType;
    struct utsname systemInfo;
    uname(&systemInfo);
    deviceType = [NSString stringWithCString:systemInfo.machine
                                    encoding:NSUTF8StringEncoding];
    
    fontForDevice = [[UIFont alloc] init];
    
    if([deviceType isEqualToString:@"iPhone4,1"]){
        fontForDevice = [UIFont fontWithName:@"DevanagariSangamMN" size:15];
    }
    
    else if([deviceType isEqualToString:@"iPhone5,1"] || [deviceType isEqualToString:@"iPhone5,2"] || [deviceType isEqualToString:@"iPhone5,3"] || [deviceType isEqualToString:@"iPhone5,4"]){
        fontForDevice = [UIFont fontWithName:@"DevanagariSangamMN" size:18];
    }
    
    else if ([deviceType isEqualToString:@"iPhone7,2"]){
        //NSLog(@"in the else statement for device...");
        fontForDevice = [UIFont fontWithName:@"DevanagariSangamMN" size:21];
    }

    else{
        fontForDevice = [UIFont fontWithName:@"DevanagariSangamMN" size:22];
    }
    
    NSLog(@"the font: %@", fontForDevice);
    
    /*
    [scoopUpText boundingRectWithSize:CGSizeMake(newView.frame.size.width, FLT_MAX)
    options:NSStringDrawingUsesLineFragmentOrigin
    attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Interstate" size:fontSize]}
    context:nil];
    */
    
    //create header for view controller that says "Get Scoopin'"
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    subview.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8]; //set the background color of the title label to royal blue
    
    UILabel *title_label = [[UILabel alloc] init];
    title_label.frame = CGRectMake(0, (subview.frame.size.height/2)-10, subview.frame.size.width, 40);
    title_label.textAlignment = NSTextAlignmentCenter;
    title_label.font = [UIFont fontWithName:@"Noteworthy-Bold" size:24];
    title_label.textColor = [UIColor whiteColor];
    title_label.text = @"Get Scoopin'";
    
    [subview addSubview:title_label];
    [self.view addSubview:subview];

    /*
    scoopUp.layer.shadowColor = [UIColor blackColor].CGColor;
    scoopUp.layer.shadowOffset = CGSizeMake(7.0, 7.0);
    scoopUp.layer.shadowOpacity = 0.9;
    scoopUp.layer.shadowRadius = 5.0;
    */
    
    [scoopUpText setFont:fontForDevice];
    [scoopUpText setTextAlignment:NSTextAlignmentCenter];
    [scoopUpText setText:@"Click the button below to be featured as an available driver!"];
    
    _titleLabel.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:1]; //set the background color of the title label to royal blue
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:1]; //set the background color of the tab bar to royal blue
    
    /*
    [scoopUp setBackgroundColor:[UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.7]];
    [scoopUp setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    */
    
    [[scoopUp layer] setBorderWidth:3.0f];
    [[scoopUp layer] setBorderColor:[UIColor colorWithRed:(245/255.0) green:(0/255.0) blue:(0/255.0) alpha:1].CGColor];
    [[scoopUp layer] setCornerRadius:5];
    [[scoopUp layer] setMasksToBounds:YES];
    scoopUp.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
    [scoopUp setTitleColor:[UIColor colorWithRed:(245/255.0) green:(0/255.0) blue:(0/255.0) alpha:1] forState:UIControlStateNormal];
    [scoopUp setTitle:@"Scoop Up: Off" forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
    
    //[scoopUp setCornerRadius:40];
    //[imageLayer setBorderWidth:1];
    //[imageLayer setMasksToBounds:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    NSString *now=@"";
    
    /// ADDED ///
    NSDateFormatter *theDateFormatter1 = [[NSDateFormatter alloc] init];
    // [theDateFormatter1 setFormatterBehavior:NSDateFormatterBehavior10_4];
    [theDateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // [theDateFormatter1 setTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]]; /////added, but this does nothing

    ///****////
    
    NSLog(@"view did appear");
    
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if(fileExists){
        NSMutableDictionary *myDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
        NSLog(@"myDict = %@",myDict);
      int hasLength = (int)[myDict count];
       // if the file has length, then check for key @"onlineCode"
        if(hasLength>0){//}else{
            //remove later (THis was in here to fake an id so that I didn't have to go through the registration process)
           // [myDict setObject:@"705749585" forKey:@"onlineCode"];
          //  [myDict writeToFile:user_info atomically:YES];
        
        
            if([[myDict objectForKey:@"scoopUp"] isEqualToString:@"On"]){
                
                
                /// ADDED ///
                
                //Designate and open the file that will track free trial and subscription payment cycles
                NSString *payStatus = [[self docsDir] stringByAppendingPathComponent:@"StartDate.plist"];
                if(![[NSFileManager defaultManager]fileExistsAtPath:payStatus]){
                    [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"StartDate" ofType:@"plist"] toPath:payStatus error:nil];
                }
                BOOL fileExists2 = [[NSFileManager defaultManager] fileExistsAtPath:payStatus];
                if(fileExists2){
                    NSMutableDictionary *myDict2 = [NSMutableDictionary dictionaryWithContentsOfFile:payStatus];
                        //the start date has been established
                        
                        NSLog(@"view did appear checking Scoop Up On");
                        
                        NSDate *startDate = [theDateFormatter1 dateFromString:[myDict2 objectForKey:@"StartingDate"]];
                        
                        
                        NSLog(@"view did appear, start date= %@", startDate);
                        
                        
                        // NSDate *now = [NSDate date];  ///
                        
                        // NSString *now_string = [theDateFormatter1 stringFromDate:now];
                        
                       // NSLog(@"current time= %@", now);            ///
                        
                        // NSLog(@"%@",[theDateFormatter stringFromDate:dictDate]);
                        // NSDate *dictDate2 = [theDateFormatter1 stringFromDate:dictDate];
                        ;
                        
                        //unnecessary because starterDate is exactly the same as dictDate
                        //NSDateComponents *components2 = [calendar components:flags fromDate:dictDate];
                        // NSDate *starterDate = [calendar dateFromComponents:components2];
                        
                        
                        //NSLog(@"starter_date=%@", starterDate); ////
                        
                        
                        //NSTimeInterval starterInterval = [starterDate timeIntervalSinceNow];
                        
                        NSTimeInterval starterInterval = [startDate timeIntervalSinceNow]; /////added
                        NSLog(@"%f", starterInterval);  /////
                        
                        // NSLog(@"%@",dictDate);
                        
                        //if the interval is greater than 30 days, it is time to pay.
                        //this covers the initial free trial as payment starts at the end of the cycle
                        
                        //the interval counts backward in time so the sign has to be reversed
                        //*****************<><><><><><><><><><><><><>********************************
                        //CHANGE THE INTERVAL WHEN READY TO FINALIZE
                        //*****************<><><><><><><><><><><><><>********************************
                        if(starterInterval<-2952000){ //1 month period
                            
                            //then the cycle has expired, so set "Scoop Up" to "Off"
                            
                            [myDict setObject:@"Off" forKey: @"scoopUp"];
                            [myDict writeToFile:user_info atomically:YES];
                            //[scoopUp setTitle:@"Scoop Up: Off" forState:UIControlStateNormal];
                            //[scoopUp setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                            
                            [[scoopUp layer] setBorderWidth:3.0f];
                            [[scoopUp layer] setBorderColor:[UIColor colorWithRed:(245/255.0) green:(0/255.0) blue:(0/255.0) alpha:1].CGColor];
                            [[scoopUp layer] setCornerRadius:5];
                            [[scoopUp layer] setMasksToBounds:YES];
                            scoopUp.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
                            [scoopUp setTitleColor:[UIColor colorWithRed:(245/255.0) green:(0/255.0) blue:(0/255.0) alpha:1] forState:UIControlStateNormal];
                            [scoopUp setTitle:@"Scoop Up: Off" forState:UIControlStateNormal];
                            
                            
                            [scoopUpText setFont:fontForDevice];
                            [scoopUpText setTextAlignment:NSTextAlignmentCenter];
                            [scoopUpText setText:@"Click the button below to be featured as an available driver!"];
                            
                            //scoopUpText.hidden=true;
                            now=@"0";
                            
                            
                            
                            /// ADDED ///
                            //load the position and status to the web.
                            NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/scoop_up.php?id=";
                            NSString *urlString2 = [urlString stringByAppendingString:[myDict objectForKey:@"onlineCode"]];
                            NSString *urlString3 = [urlString2 stringByAppendingString:@"&lat="];
                            NSString *urlString4 = [urlString3 stringByAppendingString:lat];
                            NSString *urlString5 = [urlString4 stringByAppendingString:@"&lon="];
                            NSString *urlString6 = [urlString5 stringByAppendingString:lon];
                            NSString *urlString7 = [urlString6 stringByAppendingString:@"&now="];
                            NSString *urlString8 = [urlString7 stringByAppendingString:now];
                            NSString *urlString9 = [urlString8 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            NSLog(@"outbound http = %@",urlString9);
                            
                            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                            [request setURL:[NSURL URLWithString:urlString9]];
                            [request setHTTPMethod:@"GET"];
                            NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString9] encoding:NSUTF8StringEncoding error:nil];
                            NSLog(@"return string = %@",returnString);
                            if([returnString isEqualToString:@"success"]){
                                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You must renew your monthly subscription to continue driving." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [error show];
                            }else{
                                UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We were unable to change your status at this time." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                [error show];
                            }
                            
                        }
                    
                }
                
                ///////***/////
                
                
            }else{
                NSLog(@"in the else statement...");
                [[scoopUp layer] setBorderWidth:3.0f];
                [[scoopUp layer] setBorderColor:[UIColor colorWithRed:(245/255.0) green:(0/255.0) blue:(0/255.0) alpha:1].CGColor];
                [[scoopUp layer] setCornerRadius:5];
                [[scoopUp layer] setMasksToBounds:YES];
                scoopUp.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
                [scoopUp setTitleColor:[UIColor colorWithRed:(245/255.0) green:(0/255.0) blue:(0/255.0) alpha:1] forState:UIControlStateNormal];
                [scoopUp setTitle:@"Scoop Up: Off" forState:UIControlStateNormal];
                [scoopUpText setText:@"Click the button below to set your driver status to 'available.'"];
            }
        
        }
        
    }
    
    //[scoopUpText setFont:[UIFont fontWithName:@"Noteworthy-Bold" size:18]];
    //[scoopUpText setTextAlignment:NSTextAlignmentCenter];
    //[scoopUpText setText:@"Click the button below to set your driver status to 'available.'"];
    
    /*
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    
    // Fix for the compatibility issue for non iOS 8.2 devices
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }

    */
}

/*

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@",error.description);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        lon = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        lat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        //    NSLog(@"lat = %@",latitude);
        //    NSLog(@"lon = %@",longitude);
    }
    
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
}

 - (NSString *)deviceLocation {
 return [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
 }
 
*/

-(NSString *)docsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

-(IBAction)offerScoop:(id)sender{
  //  NSArray *timeZoneNames = [NSTimeZone knownTimeZoneNames];
  //  NSLog(@"%@", timeZoneNames);

    NSLog(@"button is active");
    
    // Fix for the compatibility issue for non iOS 8.2 devices
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        NSLog(@"asking permission for location tracking");
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if(fileExists){
        NSMutableDictionary *myDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
        int hasLength = (int)[myDict count];
        //if the file has length, then check for key @"onlineCode"
        if(hasLength>0){
            //              NSLog(@"%@", [self deviceLocation]);
            //if the online code exists, then move to the next page
            NSString *now=@"";
            
            if([[myDict objectForKey:@"scoopUp"] isEqualToString:@"On"]){
                NSLog(@"in here on to off");
                [myDict setObject:@"Off" forKey: @"scoopUp"];
                [myDict writeToFile:user_info atomically:YES];
                
                /*
                [scoopUp setTitle:@"Scoop Up: Off" forState:UIControlStateNormal];
                [scoopUp setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                */
                [[scoopUp layer] setBorderWidth:3.0f];
                [[scoopUp layer] setBorderColor:[UIColor colorWithRed:(245/255.0) green:(0/255.0) blue:(0/255.0) alpha:1].CGColor];
                [[scoopUp layer] setCornerRadius:5];
                [[scoopUp layer] setMasksToBounds:YES];
                scoopUp.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
                [scoopUp setTitleColor:[UIColor colorWithRed:(245/255.0) green:(0/255.0) blue:(0/255.0) alpha:1] forState:UIControlStateNormal];
                [scoopUp setTitle:@"Scoop Up: Off" forState:UIControlStateNormal];
                
                [scoopUpText setFont:fontForDevice];
                [scoopUpText setTextAlignment:NSTextAlignmentCenter];
                [scoopUpText setText:@"Click the button below to be featured as an available driver!"];
            
                //scoopUpText.hidden=true;
                now=@"0";
                
                ///// ~~ from app delegate ~~ /////
                //ScoopAppDelegate *appDelegate = (ScoopAppDelegate *)[[UIApplication sharedApplication] delegate];
                //NSMutableArray *lat_lon = appDelegate.location_array;
                //lat = [lat_lon objectAtIndex:0];
                //lon = [lat_lon objectAtIndex:1];
                ///// ~~ end app delegate ~~ /////
                
                /// ADDED ///
                //load the position and status to the web.
                NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/scoop_up.php?id=";
                NSString *urlString2 = [urlString stringByAppendingString:[myDict objectForKey:@"onlineCode"]];
                NSString *urlString3 = [urlString2 stringByAppendingString:@"&lat="];
                NSString *urlString4 = [urlString3 stringByAppendingString:lat];
                NSString *urlString5 = [urlString4 stringByAppendingString:@"&lon="];
                NSString *urlString6 = [urlString5 stringByAppendingString:lon];
                NSString *urlString7 = [urlString6 stringByAppendingString:@"&now="];
                NSString *urlString8 = [urlString7 stringByAppendingString:now];
                NSString *urlString9 = [urlString8 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSLog(@"outbound http = %@",urlString9);
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                [request setURL:[NSURL URLWithString:urlString9]];
                [request setHTTPMethod:@"GET"];
                NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString9] encoding:NSUTF8StringEncoding error:nil];
                NSLog(@"return string = %@",returnString);
                if([returnString isEqualToString:@"success"]){
                    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your Status Was Successfully Changed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [error show];
                }else{
                    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We were unable to change your status at this time." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [error show];
                }

                
                
            }else{
                NSLog(@"in here off to on");
                //designate the way dates are formatted
                NSDateFormatter *theDateFormatter1 = [[NSDateFormatter alloc] init];
               // [theDateFormatter1 setFormatterBehavior:NSDateFormatterBehavior10_4];
                [theDateFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
               // [theDateFormatter1 setTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]]; /////added, but this does nothing
                
                unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
                NSCalendar *calendar = [NSCalendar currentCalendar];
                
                
                
                //Designate and open the file that will track free trial and subscription payment cycles
                NSString *payStatus = [[self docsDir] stringByAppendingPathComponent:@"StartDate.plist"];
                if(![[NSFileManager defaultManager]fileExistsAtPath:payStatus]){
                    [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"StartDate" ofType:@"plist"] toPath:payStatus error:nil];
                }
                BOOL fileExists2 = [[NSFileManager defaultManager] fileExistsAtPath:payStatus];
                if(fileExists2){
                    NSMutableDictionary *myDict2 = [NSMutableDictionary dictionaryWithContentsOfFile:payStatus];
                    int k = (int)[myDict2 count];
                    NSLog(@"paystatus=%@",payStatus);
                    if(k>0){
                        //the start date has been established
                        
                                                    NSLog(@"in here start date established");
                        
                                NSDate *startDate = [theDateFormatter1 dateFromString:[myDict2 objectForKey:@"StartingDate"]];

                        
                                NSLog(@"start date= %@", startDate);
                        
                        
                               // NSDate *now = [NSDate date];  ///
                        
                               // NSString *now_string = [theDateFormatter1 stringFromDate:now];
                        
                                NSLog(@"current time= %@", now);            ///
                        
                               // NSLog(@"%@",[theDateFormatter stringFromDate:dictDate]);
                               // NSDate *dictDate2 = [theDateFormatter1 stringFromDate:dictDate];
                                ;
                        
                        //unnecessary because starterDate is exactly the same as dictDate
                                //NSDateComponents *components2 = [calendar components:flags fromDate:dictDate];
                               // NSDate *starterDate = [calendar dateFromComponents:components2];
                        
                        
                                //NSLog(@"starter_date=%@", starterDate); ////
                        
                        
                                //NSTimeInterval starterInterval = [starterDate timeIntervalSinceNow];
                        
                                NSTimeInterval starterInterval = [startDate timeIntervalSinceNow]; /////added
                                NSLog(@"%f", starterInterval);  /////
                        
                       // NSLog(@"%@",dictDate);
                                
                                //if the interval is greater than 30 days, it is time to pay.
                                //this covers the initial free trial as payment starts at the end of the cycle
                                
                                //the interval counts backward in time so the sign has to be reversed
//*****************<><><><><><><><><><><><><>********************************
  //CHANGE THE INTERVAL WHEN READY TO FINALIZE
//*****************<><><><><><><><><><><><><>********************************
                                if(starterInterval<-2592000){
                                    //then the user is after the end of the free trial
                                    
                                    //alert the user that they are beyond the period and need to pay to continue being listed
                                    askToPurchase = [[UIAlertView alloc] initWithTitle:@"Purchase" message:@"Your listing has expired. Would you like to pay $20 to continue being listed as a driver?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                                    askToPurchase.delegate=self;
                                    [askToPurchase show];
                                    
                                }else{
                                    //then the user is before the end of the payment period

                                    //allow the first turn on of scoop up
                                    [myDict setObject:@"On" forKey: @"scoopUp"];
                                    [myDict writeToFile:user_info atomically:YES];
                                    /*
                                    [scoopUp setTitle:@"Scoop Up: On" forState:UIControlStateNormal];
                                    [scoopUp setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
                                    */
                                    [[scoopUp layer] setBorderWidth:3.0f];
                                    [[scoopUp layer] setBorderColor:[UIColor colorWithRed:(0/255.0) green:(180/255.0) blue:(0/255.0) alpha:1].CGColor];
                                    [[scoopUp layer] setCornerRadius:5];
                                    [[scoopUp layer] setMasksToBounds:YES];
                                    scoopUp.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
                                    [scoopUp setTitleColor:[UIColor colorWithRed:(0/255.0) green:(180/255.0) blue:(0/255.0) alpha:1] forState:UIControlStateNormal];
                                    [scoopUp setTitle:@"Scoop Up: On" forState:UIControlStateNormal];
                                    
                                    [scoopUpText setFont:fontForDevice];
                                    [scoopUpText setTextAlignment:NSTextAlignmentCenter];
                                    [scoopUpText setText:@"Thanks for indicating that you're ready to start driving! Users will now contact you when they want rides."];
                                    
                                    //scoopUpText.hidden=false;
                                    now=@"1";
                                    
                                    ///// ~~ from app delegate ~~ /////
                                    //ScoopAppDelegate *appDelegate = (ScoopAppDelegate *)[[UIApplication sharedApplication] delegate];
                                    //NSMutableArray *lat_lon = appDelegate.location_array;
                                    //lat = [lat_lon objectAtIndex:0];
                                    //lon = [lat_lon objectAtIndex:1];
                                    ///// ~~ end app delegate ~~ /////
                                    
                                    
                                    NSLog(@"dict = %@", myDict2);
                                    //load the position and status to the web.
                                    NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/scoop_up.php?id=";
                                    NSString *urlString2 = [urlString stringByAppendingString:[myDict objectForKey:@"onlineCode"]];
                                    NSString *urlString3 = [urlString2 stringByAppendingString:@"&lat="];
                                    NSString *urlString4 = [urlString3 stringByAppendingString:lat];
                                    NSString *urlString5 = [urlString4 stringByAppendingString:@"&lon="];
                                    NSString *urlString6 = [urlString5 stringByAppendingString:lon];
                                    NSString *urlString7 = [urlString6 stringByAppendingString:@"&now="];
                                    NSString *urlString8 = [urlString7 stringByAppendingString:now];
                                    NSString *urlString9 = [urlString8 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                                    NSLog(@"outbound http = %@",urlString9);
                                    
                                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                                    [request setURL:[NSURL URLWithString:urlString9]];
                                    [request setHTTPMethod:@"GET"];
                                    NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString9] encoding:NSUTF8StringEncoding error:nil];
                                    NSLog(@"return string = %@",returnString);
                                    if([returnString isEqualToString:@"success"]){
                                        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your Status Was Successfully Changed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                        [error show];
                                    }else{
                                        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We were unable to change your status at this time." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                                        [error show];
                                    }
                                }
                    }else{
                        //then the start date has not been established
                        NSLog(@"in here start date NOT established");
                        //establish the start date as now and save it to the starter file
                        NSDateComponents *components2 = [calendar components:flags fromDate:[NSDate date]];
                        NSDate *starterDate = [calendar dateFromComponents:components2];
                        NSString *dateString = [theDateFormatter1 stringFromDate:starterDate];
                        [myDict2 setObject:dateString forKey:@"StartingDate"];
                        [myDict2 writeToFile:payStatus atomically:YES];
                        
                        //allow the first turn on of scoop up
                        [myDict setObject:@"On" forKey: @"scoopUp"];
                        [myDict writeToFile:user_info atomically:YES];
                        /*
                        [scoopUp setTitle:@"Scoop Up: On" forState:UIControlStateNormal];
                        [scoopUp setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
                        */
                        [[scoopUp layer] setBorderWidth:3.0f];
                        [[scoopUp layer] setBorderColor:[UIColor colorWithRed:(0/255.0) green:(180/255.0) blue:(0/255.0) alpha:1].CGColor];
                        [[scoopUp layer] setCornerRadius:5];
                        [[scoopUp layer] setMasksToBounds:YES];
                        scoopUp.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
                        [scoopUp setTitleColor:[UIColor colorWithRed:(0/255.0) green:(180/255.0) blue:(0/255.0) alpha:1] forState:UIControlStateNormal];
                        [scoopUp setTitle:@"Scoop Up: On" forState:UIControlStateNormal];
                        
                        [scoopUpText setFont:fontForDevice];
                        [scoopUpText setTextAlignment:NSTextAlignmentCenter];
                        [scoopUpText setText:@"Thanks for indicating that you're ready to start driving! Users will now contact you when they want rides."];
                        
                        //scoopUpText.hidden=false;
                        now=@"1";
                        
                        ///// ~~ from app delegate ~~ /////
                        //ScoopAppDelegate *appDelegate = (ScoopAppDelegate *)[[UIApplication sharedApplication] delegate];
                        //NSMutableArray *lat_lon = appDelegate.location_array;
                        //lat = [lat_lon objectAtIndex:0];
                        //lon = [lat_lon objectAtIndex:1];
                        ///// ~~ end app delegate ~~ /////
                        
                        NSLog(@"lat = %@",lat);
                        NSLog(@"lon = %@",lon);
                        NSLog(@"online code = %@",[myDict objectForKey:@"onlineCode"]);
                        
                        NSLog(@"dict = %@", myDict2);
                        //load the position and status to the web.
                        NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/scoop_up.php?id=";
                        NSString *urlString2 = [urlString stringByAppendingString:[myDict objectForKey:@"onlineCode"]];
                        NSString *urlString3 = [urlString2 stringByAppendingString:@"&lat="];
                        NSString *urlString4 = [urlString3 stringByAppendingString:lat];
                        NSString *urlString5 = [urlString4 stringByAppendingString:@"&lon="];
                        NSString *urlString6 = [urlString5 stringByAppendingString:lon];
                        NSString *urlString7 = [urlString6 stringByAppendingString:@"&now="];
                        NSString *urlString8 = [urlString7 stringByAppendingString:now];
                        NSString *urlString9 = [urlString8 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                        NSLog(@"outbound http = %@",urlString9);
                        
                        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                        [request setURL:[NSURL URLWithString:urlString9]];
                        [request setHTTPMethod:@"GET"];
                        NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString9] encoding:NSUTF8StringEncoding error:nil];
                        NSLog(@"return string = %@",returnString);
                        if([returnString isEqualToString:@"success"]){
                            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your Status Was Successfully Changed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [error show];
                        }else{
                            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We were unable to change your status at this time." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [error show];
                        }
                    }
                    
                    
                    
                        
                    }
                }
            }
            

        
    }
}






-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(alertView==askToPurchase){
        if(buttonIndex==1){
            if([SKPaymentQueue canMakePayments]){
                //this part was  a real pain in the butt to get right
                
                SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:@"com.wlu.scoopu.ListingFee20"]];
                
                request.delegate=self;
                [request start];
            }
        }
    }
}

-(void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        NSLog(@"Invalid product id: %@" , invalidProductId);
    }
    
    SKProduct *validProduct = nil;
    int counter = (int)[response.products count];
    if(counter>0){
        validProduct = [response.products objectAtIndex:0];
        SKPayment *payment = [SKPayment paymentWithProduct:validProduct];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }else{
        UIAlertView *tmp = [[UIAlertView alloc] initWithTitle:@"Unavailable" message:@"The option you are trying to purchase is currently unavailable." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [tmp show];
    }
}

-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:[self UnlockPurchase];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:NSLog(@"Transaction Failed");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            default:
                break;
        }
    }
}

-(void)UnlockPurchase{
    
    NSLog(@"in unlock purchase");
    
    NSMutableDictionary *myDict2=[[NSMutableDictionary alloc] init];
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if(fileExists){
        myDict2 = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
        // ADDED ///
        [myDict2 setObject:@"On" forKey: @"scoopUp"];
        [myDict2 writeToFile:user_info atomically:YES];

    }
    
    
    
    //designate the way dates are formatted
    NSDateFormatter *theDateFormatter1 = [[NSDateFormatter alloc] init];
    [theDateFormatter1 setFormatterBehavior:NSDateFormatterBehavior10_4];
    [theDateFormatter1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //Designate and open the file that will track free trial and subscription payment cycles
    NSString *payStatus = [[self docsDir] stringByAppendingPathComponent:@"StartDate.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:payStatus]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"StartDate" ofType:@"plist"] toPath:payStatus error:nil];
    }
    BOOL fileExists2 = [[NSFileManager defaultManager] fileExistsAtPath:payStatus];
    if(fileExists2){
        NSMutableDictionary *myDict = [NSMutableDictionary dictionaryWithContentsOfFile:payStatus];
        
        NSDate *nowDate = [NSDate date];
        NSDateComponents *components2 = [calendar components:flags fromDate:nowDate];
        NSDate *starterDate = [calendar dateFromComponents:components2];
        
        
        NSString *nowDateString = [theDateFormatter1 stringFromDate:starterDate];
        // NSLog(nowDateString); ///
        [myDict setObject:nowDateString forKey:@"StartingDate"];
        [myDict writeToFile:payStatus atomically:YES];
        NSLog(@"paydict=%@",myDict);
        
        
        //the following engages the php file for the change after purchase
        //*****************************************
        NSLog(@"dict = %@", myDict);
        //load the position and status to the web.
        NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/scoop_up.php?id=";
        NSString *urlString2 = [urlString stringByAppendingString:[myDict2 objectForKey:@"onlineCode"]];
        NSString *urlString3 = [urlString2 stringByAppendingString:@"&lat="];
        NSString *urlString4 = [urlString3 stringByAppendingString:lat];
        NSString *urlString5 = [urlString4 stringByAppendingString:@"&lon="];
        NSString *urlString6 = [urlString5 stringByAppendingString:lon];
        NSString *urlString7 = [urlString6 stringByAppendingString:@"&now=1"];
        NSString *urlString9 = [urlString7 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"outbound http = %@",urlString9);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString9]];
        [request setHTTPMethod:@"GET"];
        NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString9] encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"return string = %@",returnString);
        if([returnString isEqualToString:@"success"]){
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your Status Was Successfully Changed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [error show];
            
            //turn the button on after the purchase and php are successful
            /*
            [scoopUp setTitle:@"Scoop Up: On" forState:UIControlStateNormal];
            [scoopUp setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
            */
            [[scoopUp layer] setBorderWidth:3.0f];
            [[scoopUp layer] setBorderColor:[UIColor colorWithRed:(0/255.0) green:(180/255.0) blue:(0/255.0) alpha:1].CGColor];
            [[scoopUp layer] setCornerRadius:5];
            [[scoopUp layer] setMasksToBounds:YES];
            scoopUp.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
            [scoopUp setTitleColor:[UIColor colorWithRed:(0/255.0) green:(180/255.0) blue:(0/255.0) alpha:1] forState:UIControlStateNormal];
            [scoopUp setTitle:@"Scoop Up: On" forState:UIControlStateNormal];
            
            [scoopUpText setText:@"Thanks for indicating that you're ready to start driving! Users will now contact you when they want rides."];
        }else{
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We were unable to change your status at this time." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [error show];
        }
    }
}


@end
