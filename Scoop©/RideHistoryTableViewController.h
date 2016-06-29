//
//  RideHistoryTableViewController.h
//  Scoop©
//
//  Created by Samuel Borowsky on 6/22/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RideHistoryTableViewController : UITableViewController<UITableViewDataSource,
UITableViewDelegate>


@property(weak,nonatomic) IBOutlet UITableView *historyTableView; //controls the ride history table view

@property (nonatomic, weak) NSArray *rideArray; //record of all rides
@property (nonatomic, retain) NSArray *driverNames;
@property (nonatomic, retain) NSArray *cars;
@property (nonatomic, retain) NSArray *distances;
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, retain) NSArray *statuses;

@end
