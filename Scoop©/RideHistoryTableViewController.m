//
//  RideHistoryTableViewController.m
//  Scoop©
//
//  Created by Samuel Borowsky on 6/22/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "RideHistoryTableViewController.h"
#import "RideReceivedActiveCell.h"

@interface RideHistoryTableViewController ()

@end

@implementation RideHistoryTableViewController
@synthesize historyTableView, rideArray, driverNames, cars, distances, images, statuses;

static NSString *cellIdentifier = @"CellTableIdentifier";

-(void)viewDidLoad{
    [super viewDidLoad];
    
    historyTableView = (id)[historyTableView viewWithTag:201];
    [historyTableView registerClass:[RideReceivedActiveCell class] forCellReuseIdentifier:cellIdentifier];
    
    self.driverNames = @[@"Javier",
                         @"Patrick",
                         @"Tim",
                         @"Robert",
                         @"Cary"];
    
    //Add values to the destinations array -- these are our sample destinations
    self.cars = @[@"Space ship",
              @"Ford Explorer",
              @"Toyota Corolla",
              @"Audi A4",
              @"Blue Whale"];
    
    //Add values to the time array -- these are sample times of when the sameple riders were dropped off
    self.distances = @[@"2.5 mi",
                   @"3.1 mi",
                   @"1.2 mi",
                   @"14.2 mi",
                   @"8.0 mi"];
    
    
    //Add values to the riderImages array -- these are the images of sample riders
    self.images = @[@"javierE.jpg",
                @"patrickM.jpg",
                @"timB.jpg",
                @"robertE.jpg",
                @"caryC.jpg"];
    
    //Add values to the status array
    self.statuses = @[@"ACTIVE",
                  @"COMPLETE",
                  @"COMPLETE",
                  @"COMPLETE",
                  @"COMPLETE"];

}


-(void)viewDidAppear:(BOOL)animated{
    //rideArray = [[NSMutableArray alloc] init];
    
    /*
    self.driverNames = @[@"Javier",
                    @"Patrick",
                    @"Tim",
                    @"Thomas",
                    @"Chris"];
     */
    
    }


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSLog(@"in viewForHeader...");
    UIView * title_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 70)];
    title_view.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8]; //set the background color of the title label to royal blue
    
    UILabel *title_label = [[UILabel alloc] init];
    title_label.frame = CGRectMake(0, (title_view.frame.size.height/2)-10, tableView.frame.size.width, 40);
    title_label.textAlignment = NSTextAlignmentCenter;
    title_label.font = [UIFont fontWithName:@"Noteworthy-Bold" size:24];
    title_label.textColor = [UIColor whiteColor];
    title_label.text = @"Ride History";
    
    [title_view addSubview:title_label];
    
    return title_view;
}



- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RideReceivedActiveCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    /*
    if (indexPath.row % 2 == 1){
        cell.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1];
        //[cell.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        //[cell.contentView.layer setBorderWidth:0.4f];
    }
    */
    
    cell.driverImageName = [images objectAtIndex:(long)indexPath.row];
    cell.nameLabelValue = [driverNames objectAtIndex:(long)indexPath.row];
    cell.statusValue = [statuses objectAtIndex:(long)indexPath.row];
    //cell.carLabelValue = [cars objectAtIndex:(long)indexPath.row];
    if ([[statuses objectAtIndex:(long)indexPath.row] isEqualToString:@"ACTIVE"]){
        cell.distLabelValue = [distances objectAtIndex:(long)indexPath.row];
    }
    else{
        cell.ratingImageName = @"star_filled.png";
    }
    
    return cell;
    
}

@end