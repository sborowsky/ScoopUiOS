//
//  Ride.h
//  Scoop©
//
//  Created by Samuel Borowsky on 7/20/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Ride : NSManagedObject

@property (nonatomic, retain) NSNumber * ride_id;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) User *toRider;
@property (nonatomic, retain) User *toDriver;

@end
