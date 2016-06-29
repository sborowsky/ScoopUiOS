//
//  RideHistoryViewController.h
//  Scoop©
//
//  Created by Samuel Borowsky on 7/19/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RideHistoryViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property(weak,nonatomic) IBOutlet UITableView *historyTableView1; //controls the ride history table view

@property(nonatomic, retain) NSString *tabString; //tracks whether the "given" or "received" tab is selected
@property(nonatomic, retain) NSMutableString *emailString; //string of all email addresses for rides given or rides received
@property(nonatomic, retain) NSMutableString *statusString; //string of all statuses for rides given or rides received
@property(nonatomic, strong) NSMutableArray *infoArray; //array of all rider or driver dictionaries

@property(weak,nonatomic) IBOutlet UILabel *toggleLabel; //controls the received/given toggle label
@property(weak,nonatomic) IBOutlet UIButton *givenTab; //controls the "given" tab (button)
@property(weak,nonatomic) IBOutlet UIButton *receivedTab; //controls the "received" tab (button)

@property (nonatomic, weak) NSArray *rideArray; //record of all rides
@property (nonatomic, retain) NSArray *driverNames;
@property (nonatomic, retain) NSArray *cars;
@property (nonatomic, retain) NSArray *distances;
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, retain) NSArray *statuses;

@property (nonatomic, retain) NSArray *riderNames;
@property (nonatomic, retain) NSArray *riderImages;
@property (nonatomic, retain) NSArray *riderDistances;
@property (nonatomic, retain) NSArray *riderStatuses;

@end
