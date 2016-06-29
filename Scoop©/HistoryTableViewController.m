//
//  HistoryTableViewController.m
//  Scoop©
//
//  Created by Samuel Borowsky on 6/22/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "HistoryTableViewController.h"
#import "NewsCell.h"

@interface HistoryTableViewController ()

@end

@implementation HistoryTableViewController

@synthesize historyTableView;

static NSString *cellIdentifier = @"CellTableIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setFrame:CGRectMake(0, 270, self.view.frame.size.width, self.view.frame.size.height - 70)];
    
    historyTableView = (id)[historyTableView viewWithTag:201];
    [historyTableView registerClass:[NewsCell class] forCellReuseIdentifier:cellIdentifier];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
        UIView * title1_view = [[UIView alloc] initWithFrame:CGRectMake(0, 70, tableView.frame.size.width, 50)];
        title1_view.backgroundColor = [UIColor lightGrayColor]; //set the background color of the title label to royal blue
    
        UILabel *title1_label = [[UILabel alloc] init];
        title1_label.frame = CGRectMake(0, (title1_view.frame.size.height/2)-10, tableView.frame.size.width, 25);
        title1_label.textAlignment = NSTextAlignmentCenter;
        title1_label.font = [UIFont fontWithName:@"Noteworthy-Bold" size:14];
        //title_label1.textColor = [UIColor whiteColor];
        title1_label.text = @"Active";
    
        [title1_view addSubview:title1_label];
        return title1_view;
    }
    
    else{
        UIView * title2_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
        title2_view.backgroundColor = [UIColor lightGrayColor]; //set the background color of the title label to royal blue
        
        UILabel *title2_label = [[UILabel alloc] init];
        title2_label.frame = CGRectMake(0, (title2_view.frame.size.height/2)-10, tableView.frame.size.width, 25);
        title2_label.textAlignment = NSTextAlignmentCenter;
        title2_label.font = [UIFont fontWithName:@"Noteworthy-Bold" size:14];
        //title_label1.textColor = [UIColor whiteColor];
        title2_label.text = @"Completed";
        
        [title2_view addSubview:title2_label];
        return title2_view;

    }
}

- (void)btnSelected {
    NSLog(@"button clicked");
    [self performSegueWithIdentifier:@"report_segue" sender:self];
}
/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2; //There will be two section for the news feed, active rides and completed rides
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 7; //This will display a news feed row for each sample rider.
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell;
}

@end
