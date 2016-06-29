//
//  AppDelegate.m
//  Scoop©
//
//  Created by Samuel Borowsky on 1/28/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "ScoopAppDelegate.h"


@interface ScoopAppDelegate ()

@end

@implementation ScoopAppDelegate

@synthesize lat,lon,location_array,locationManager,driving;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    if([CLLocationManager locationServicesEnabled]){
        NSLog(@"location services enabled...");
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = 100; // whenever we move
        locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 1m
        [locationManager startUpdatingLocation];
    }
        
    /*
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    */
    
    return YES;
}

/*
- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
}
*/

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

-(NSString *)docsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"in applicationWillTerminate...");
    
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if(fileExists){
        NSLog(@"it exists");
        NSMutableDictionary *myDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
        [myDict setObject:@"Off" forKey: @"scoopUp"];
        [myDict writeToFile:user_info atomically:YES];
        
        NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/scoop_up.php?id=";
        NSString *urlString2 = [urlString stringByAppendingString:[myDict objectForKey:@"onlineCode"]];
        NSString *urlString3 = [urlString2 stringByAppendingString:@"&lat="];
        NSString *urlString4 = [urlString3 stringByAppendingString:lat];
        NSString *urlString5 = [urlString4 stringByAppendingString:@"&lon="];
        NSString *urlString6 = [urlString5 stringByAppendingString:lon];
        NSString *urlString7 = [urlString6 stringByAppendingString:@"&now="];
        NSString *urlString8 = [urlString7 stringByAppendingString:@"0"];
        NSString *urlString9 = [urlString8 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"outbound http = %@",urlString9);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString9]];
        
        //[request setHTTPMethod:@"GET"];
        //NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString9] encoding:NSUTF8StringEncoding error:nil];
        
        //NSLog(@"return string: %@", returnString);


    }
    
}

+ (ScoopAppDelegate *)appDelegate
{
    return (ScoopAppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@",error.description);
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"in didUpdateLocations...");
    
    CLLocation *newLocation = [locations lastObject];
    
    if (newLocation != nil) {
        
        location_array = [[NSMutableArray alloc] init];
        
        lon = [NSString stringWithFormat:@"%.8f", newLocation.coordinate.longitude];
        lat = [NSString stringWithFormat:@"%.8f", newLocation.coordinate.latitude];
        
        [location_array addObject:lat];
        [location_array addObject:lon];
    
        
        
        NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
        if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
            [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
        }
        
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
        if(fileExists){
            NSMutableDictionary *myDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
            
            lon = [NSString stringWithFormat:@"%.8f", newLocation.coordinate.longitude];
            lat = [NSString stringWithFormat:@"%.8f", newLocation.coordinate.latitude];
            
            if ([[myDict objectForKey:@"scoopUp"] isEqualToString:@"Off"]) {
                driving = @"0";
            }
            else {
                driving = @"1";
            }
            
            NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/scoop_up.php?id=";
            NSString *urlString2 = [urlString stringByAppendingString:[myDict objectForKey:@"onlineCode"]];
            NSString *urlString3 = [urlString2 stringByAppendingString:@"&lat="];
            NSString *urlString4 = [urlString3 stringByAppendingString:lat];
            NSString *urlString5 = [urlString4 stringByAppendingString:@"&lon="];
            NSString *urlString6 = [urlString5 stringByAppendingString:lon];
            NSString *urlString7 = [urlString6 stringByAppendingString:@"&now="];
            NSString *urlString8 = [urlString7 stringByAppendingString:driving];
            
            NSString *urlString9 = [urlString8 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"outbound http = %@",urlString9);
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:urlString9]];
            
            //[locationManager stopUpdatingLocation];
            
            [request setHTTPMethod:@"GET"];
            NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString9] encoding:NSUTF8StringEncoding error:nil];
            
            NSLog(@"return string: %@", returnString);

        }
        
    }

}


#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.example.sample" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ScoopU" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"sample.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
