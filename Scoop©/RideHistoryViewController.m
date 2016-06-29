//
//  RideHistoryViewController.m
//  Scoop©
//
//  Created by Samuel Borowsky on 7/19/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "RideHistoryViewController.h"
#import "RideReceivedActiveCell.h"
#import "RideGivenCell.h"

@interface RideHistoryViewController ()

@end

@implementation RideHistoryViewController
@synthesize historyTableView1, rideArray, driverNames, cars, distances, images, statuses, riderNames, riderImages, riderDistances, riderStatuses, tabString, emailString, statusString, infoArray;

static NSString *givenIdentifier = @"given";
static NSString *receivedIdentifier = @"received";

-(NSString *)docsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabString = [[NSString alloc]init];
    
    self.emailString = [[NSMutableString alloc] init];
    self.statusString = [[NSMutableString alloc] init];
    self.infoArray = [[NSMutableArray alloc] init];
    
    historyTableView1 = (id)[historyTableView1 viewWithTag:202];
    [historyTableView1 registerClass:[RideReceivedActiveCell class] forCellReuseIdentifier:receivedIdentifier];
    [historyTableView1 registerClass:[RideGivenCell class] forCellReuseIdentifier:givenIdentifier];

    self.historyTableView1.delegate = self;
    self.historyTableView1.dataSource = self;
    
    _toggleLabel.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1];
    
    UIView *titleview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    titleview.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8]; //set the background color of the title label to royal blue
    
    UILabel *title_label = [[UILabel alloc] init];
    title_label.frame = CGRectMake(0, (titleview.frame.size.height/2)-10, titleview.frame.size.width, 40);
    title_label.textAlignment = NSTextAlignmentCenter;
    title_label.font = [UIFont fontWithName:@"Noteworthy-Bold" size:24];
    title_label.textColor = [UIColor whiteColor];
    title_label.text = @"Ride History";
    
    [titleview addSubview:title_label];
    [self.view addSubview:titleview];
    
    //// rides received information /////
    
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
    
    //// rides given information /////
    
    self.riderNames = @[@"Andrew",
                         @"Walker",
                         @"Russell",
                         @"Alex",
                         @"Sam"];
    
    self.riderImages = @[@"andrewH.jpg",
                    @"walkerH.jpg",
                    @"russellS.jpg",
                    @"alexF.jpg",
                    @"samB.jpg"];
    
    self.riderDistances = @[@"1.3 mi",
                       @"2.0 mi",
                       @"5.9 mi",
                       @"14.2 mi",
                       @"8.0 mi"];
    
    self.riderStatuses = @[@"ACTIVE",
                      @"ACTIVE",
                      @"ACTIVE",
                      @"COMPLETE",
                      @"COMPLETE"];
    
    [self receivedClicked:self];
    
    //[self.historyTableView1 reloadData];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}
- (IBAction)receivedClicked:(id)sender {
    NSLog(@"Received clicked");
    
    tabString = @"received";
    [_receivedTab setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [_givenTab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    emailString = [[NSMutableString alloc] init];
    statusString = [[NSMutableString alloc] init];
    infoArray = [[NSMutableArray alloc] init];
    
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    
    //check if the file exists just to be sure because you do not want to perform actions on a non-existent file
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if (fileExists){
        NSLog(@"here 1");
        //NSMutableString *rider_emails = [[NSMutableString alloc] init];
        NSMutableDictionary *userDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
        NSMutableArray *rides_received = [userDict objectForKey:@"ridesReceived"];
        NSLog(@"rides received: %@", rides_received);
        for (NSDictionary *ride in rides_received) {
            [emailString appendString:[ride valueForKey:@"driver"]];
            [emailString appendString:@"##"];
            NSLog(@"email string: %@", emailString);
            
            [statusString appendString:[ride valueForKey:@"status"]];
            [statusString appendString:@"##"];
        }
        [emailString deleteCharactersInRange:NSMakeRange([emailString length]-2, 2)];
        NSLog(@"emails string: %@", emailString);
        
        NSArray *statusArray = [statusString componentsSeparatedByString:@"##"];
    
        NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/download_ridesr.php?emails=";
        NSString *urlString2 = [urlString stringByAppendingString:emailString];
        NSString *urlString3 = [urlString2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"outbound http = %@",urlString3);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString3]];
        [request setHTTPMethod:@"GET"];
        NSMutableString *returnString = [[NSMutableString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString3] encoding:NSUTF8StringEncoding error:nil];
        [returnString deleteCharactersInRange:NSMakeRange([returnString length]-2, 2)];
        
        NSLog(@"return string = %@",returnString);

        NSArray *returnArray = [returnString componentsSeparatedByString:@"&&"];
        NSLog(@"returnArray= %@",returnArray);
        
        int numItems =(int)[returnArray count];
        if(numItems > 0){
            for(int i=0; i<numItems; i++){
                NSArray *returnArray2=[returnArray[i] componentsSeparatedByString:@"##"];
                NSLog(@"returnArray2: %@", returnArray2);
                NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] init];
                [infoDict setObject:[returnArray2 objectAtIndex:0] forKey:@"firstname"];
                [infoDict setObject:[returnArray2 objectAtIndex:1] forKey:@"lastname"];
                [infoDict setObject:[returnArray2 objectAtIndex:2] forKey:@"rating"];
                [infoDict setObject:[returnArray2 objectAtIndex:3] forKey:@"available_now"];
                [infoDict setObject:[returnArray2 objectAtIndex:4] forKey:@"image"];
                [infoDict setObject:[statusArray objectAtIndex:i] forKey:@"status"];
                NSLog(@"info dict: %@", infoDict);
                [infoArray addObject:infoDict];
                
                NSLog(@"array size: %lu", (unsigned long)[infoArray count]);
                NSLog(@"info array= %@", infoArray);
            }
        }
        NSLog(@"the info array of dictionaries: %@", infoArray);
        [historyTableView1 reloadData];
    }
}


- (IBAction)givenClicked:(id)sender {
    NSLog(@"Given clicked");
    
    tabString = @"given";
    [_receivedTab setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_givenTab setTitleColor:self.view.tintColor forState:UIControlStateNormal];

    emailString = [[NSMutableString alloc] init];
    statusString = [[NSMutableString alloc] init];
    infoArray = [[NSMutableArray alloc] init];
    
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    
    //check if the file exists just to be sure because you do not want to perform actions on a non-existent file
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if (fileExists){
        //NSMutableString *rider_emails = [[NSMutableString alloc] init];
        NSMutableDictionary *userDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
        NSMutableArray *rides_given = [userDict objectForKey:@"ridesGiven"];
        for (NSDictionary *ride in rides_given) {
            [emailString appendString:[ride valueForKey:@"rider"]];
            [emailString appendString:@"##"];
            
            [statusString appendString:[ride valueForKey:@"status"]];
            [statusString appendString:@"##"];

        }
        [emailString deleteCharactersInRange:NSMakeRange([emailString length]-2, 2)];
        NSLog(@"emails string: %@", emailString);
    
        NSArray *statusArray = [statusString componentsSeparatedByString:@"##"];
    
        NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/download_ridesg.php?emails=";
        NSString *urlString2 = [urlString stringByAppendingString:emailString];
        NSString *urlString3 = [urlString2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"outbound http = %@",urlString3);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString3]];
        [request setHTTPMethod:@"GET"];
        NSMutableString *returnString = [[NSMutableString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString3] encoding:NSUTF8StringEncoding error:nil];
        [returnString deleteCharactersInRange:NSMakeRange([returnString length]-2, 2)];
        NSLog(@"return string = %@",returnString);
        
        NSArray *returnArray = [returnString componentsSeparatedByString:@"&&"];
        NSLog(@"returnArray= %@",returnArray);
        
        int numItems =(int)[returnArray count];
        if(numItems > 0){
            int last = (int)[returnArray count]-1;
            for(int i=0; i<last+1; i++){
                NSArray *returnArray2=[returnArray[i] componentsSeparatedByString:@"##"];
                NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] init];
                [infoDict setObject:[returnArray2 objectAtIndex:0] forKey:@"firstname"];
                [infoDict setObject:[returnArray2 objectAtIndex:1] forKey:@"lastname"];
                [infoDict setObject:[returnArray2 objectAtIndex:2] forKey:@"image"];
                [infoDict setObject:[statusArray objectAtIndex:i] forKey:@"status"];
                [infoArray addObject:infoDict];
            }
        }
        NSLog(@"the info array of dictionaries: %@", infoArray);
        [historyTableView1 reloadData];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Number of rows is the number of time zones in the region for the specified section.
    return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"in cellForRow...and tabString = %@", tabString);
    
    if ([tabString isEqualToString:@"given"]){
        RideGivenCell *cell_g = [tableView dequeueReusableCellWithIdentifier:givenIdentifier];
        NSMutableDictionary *cell_dict = [infoArray objectAtIndex:indexPath.row];
        
        NSString *f_name = [cell_dict valueForKey:@"firstname"];
        NSString *status = [cell_dict valueForKey:@"status"];
        NSString *image = [cell_dict valueForKey:@"image"];
        
        
        //cell_g.riderImageName = [riderImages objectAtIndex:(long)indexPath.row];
        cell_g.riderImageName = image;
        //cell_g.nameLabelValue = [riderNames objectAtIndex:(long)indexPath.row];
        cell_g.nameLabelValue = f_name;
        //cell_g.statusValue = [riderStatuses objectAtIndex:(long)indexPath.row];
        cell_g.statusValue = status;
        //cell_g.carLabelValue = [cars objectAtIndex:(long)indexPath.row];
        if ([[riderStatuses objectAtIndex:(long)indexPath.row] isEqualToString:@"ACTIVE"]){
            cell_g.distLabelValue = [riderDistances objectAtIndex:(long)indexPath.row];
            cell_g.googleImageName = @"google.jpg";
        }
        
        return cell_g;
    }
    
    else{
        RideReceivedActiveCell *cell_r = [tableView dequeueReusableCellWithIdentifier:receivedIdentifier];
        NSMutableDictionary *cell_dict = [infoArray objectAtIndex:indexPath.row];
        
        NSString *f_name = [cell_dict valueForKey:@"firstname"];
        NSString *status = [cell_dict valueForKey:@"status"];
        NSString *image = [cell_dict valueForKey:@"image"];
        
        //cell_r.driverImageName = [images objectAtIndex:(long)indexPath.row];
        cell_r.driverImageName = image;
        //cell_r.nameLabelValue = [driverNames objectAtIndex:(long)indexPath.row];
        cell_r.nameLabelValue = f_name;
        //cell_r.statusValue = [statuses objectAtIndex:(long)indexPath.row];
        cell_r.statusValue = status;
        //cell_r.carLabelValue = [cars objectAtIndex:(long)indexPath.row];
        if ([[statuses objectAtIndex:(long)indexPath.row] isEqualToString:@"ACTIVE"]){
            cell_r.distLabelValue = [distances objectAtIndex:(long)indexPath.row];
            cell_r.phoneValueCenter = @"call_blue1.png";
            //cell_r.googleImageName = @"google.jpg";
        }
        
        else{
            cell_r.phoneValueLeft = @"call_blue1.png";
            cell_r.ratingImageName = @"star_filled.png";
            cell_r.venmoImageName = @"venmo.png";
        }
        
        return cell_r;

    }
    
    /*
    cell.riderImageName = [riderImages objectAtIndex:(long)indexPath.row];
    cell.nameLabelValue = [riderNames objectAtIndex:(long)indexPath.row];
    cell.statusValue = [riderStatuses objectAtIndex:(long)indexPath.row];
    //cell.carLabelValue = [cars objectAtIndex:(long)indexPath.row];
    if ([[riderStatuses objectAtIndex:(long)indexPath.row] isEqualToString:@"ACTIVE"]){
        cell.distLabelValue = [riderDistances objectAtIndex:(long)indexPath.row];
        cell.googleImageName = @"google.jpg";
    }
    
    else{
        cell.phoneValueLeft = @"call_blue1.png";
        cell.ratingImageName = @"star_filled.png";
        cell.venmoImageName = @"venmo.png";
    }
    
    return cell;
    */
}

@end
