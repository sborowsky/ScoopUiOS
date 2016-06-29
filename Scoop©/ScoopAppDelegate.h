//
//  AppDelegate.h
//  Scoop©
//
//  Created by Samuel Borowsky on 1/28/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreLocation/CoreLocation.h>

@interface ScoopAppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>{
    // core location//
    CLLocationManager *locationManager;
    
}
// core location //
@property (strong, nonatomic) CLLocationManager* locationManager;

@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;
@property (nonatomic, retain) NSMutableArray *location_array; //contains the latitude and longtitude points of new location
// end core location //

+ (ScoopAppDelegate *)appDelegate;
@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) coreDataViewController *viewController;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) NSString *driving;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

@end


