//
//  HistoryViewController.h
//  Scoop©
//
//  Created by Samuel Borowsky on 6/22/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>;

@property IBOutlet UITableView *historyTableView; //controls the ride history table view
@property NSArray *rideArray; //record of all rides

@end
