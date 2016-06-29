//
//  HistoryViewController.m
//  Scoop©
//
//  Created by Samuel Borowsky on 6/22/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "HistoryViewController.h"
#import "NewsCell.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController
@synthesize historyTableView, rideArray;

static NSString *cellIdentifier = @"CellTableIdentifier";

-(void)viewDidLoad{
    [super viewDidLoad];
    
    historyTableView = (id)[historyTableView viewWithTag:201];
    [historyTableView registerClass:[NewsCell class] forCellReuseIdentifier:cellIdentifier];
    
}


-(void)viewDidAppear:(BOOL)animated{
    rideArray = [[NSMutableArray alloc] init];
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
    title_label.text = @"Scoop Feed";
    
    UIButton *report_button = [[UIButton alloc] initWithFrame:CGRectMake(255, 10, 70, 70)];
    
    /* Need shadow for the new report button?
     _report_button.layer.shadowColor = [UIColor blackColor].CGColor;
     _report_button.layer.shadowOffset = CGSizeMake(7.0, 7.0);
     _report_button.layer.shadowOpacity = 0.9;
     _report_button.layer.shadowRadius = 5.0;
     */
    
    UIImageView *image_view = [[UIImageView alloc] initWithFrame:CGRectMake(255, 10, 70, 70)];
    image_view.alpha = .4;
    
    UIImage *report_image = [UIImage imageNamed:@"feed_btn_pic1.png"];
    
    [report_button setImage:report_image forState:UIControlStateNormal];
    //[report_button addTarget:self action:@selector(btnSelected) forControlEvents:UIControlEventTouchUpInside];
    
    image_view.image = report_image;
    
    [report_button addSubview:image_view];
    
    [title_view addSubview:title_label];
    [title_view addSubview:report_button];
    
    return title_view;
}


 
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 20;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    return cell;

}

@end