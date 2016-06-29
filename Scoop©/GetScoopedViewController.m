//
//  GetScoopedViewController.m
//  Scoop©
//
//  Created by Gavin Fox on 3/5/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "GetScoopedViewController.h"

@interface GetScoopedViewController ()

@end

@implementation GetScoopedViewController

@synthesize scoopUp,locationManager,lat,lon;

- (void)viewDidLoad {
    [super viewDidLoad];
    [scoopUp setTitle:@"Scoop Up Off" forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    scoopUpLabel.hidden=true;
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
}

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
/*
 - (NSString *)deviceLocation {
 return [NSString stringWithFormat:@"latitude: %f longitude: %f", locationManager.location.coordinate.latitude, locationManager.location.coordinate.longitude];
 }
 */

-(NSString *)docsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

-(IBAction)offerScoop:(id)sender{
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
                [myDict setObject:@"Off" forKey: @"scoopUp"];
                [myDict writeToFile:user_info atomically:YES];
                [scoopUp setTitle:@"Scoop Up Off" forState:UIControlStateNormal];
                scoopUpLabel.hidden=true;
                now=@"0";
            }else{
                [myDict setObject:@"On" forKey: @"scoopUp"];
                [myDict writeToFile:user_info atomically:YES];
                [scoopUp setTitle:@"Scoop Up On" forState:UIControlStateNormal];
                scoopUpLabel.hidden=false;
                now=@"1";
            }
            
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

@end
