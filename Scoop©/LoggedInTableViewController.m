//
//  Scoop©
//  Sam Borowsky
//  LoggedInTableViewController.m
//  The implementation file for the app's news feed that appears after
//  a user successfully logs in.
//  02.12.2015
//

#import "LoggedInTableViewController.h"  //the interface for the view controller
#import "NewsCell.h"
#import "LoggedInTableCell.h" //the interface for a cell in the table view
#import <QuartzCore/QuartzCore.h>
#import "ScoopAppDelegate.h"
#import "User.h"
#import "Ride.h"
//////////////////

@interface LoggedInTableViewController ()

@end

@implementation LoggedInTableViewController
@synthesize locationManager,lat,lon,riderArray,myTableView,isFull;


static NSString *cellIdentifier = @"CellTableIdentifier";


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

-(NSString *)docsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    myTableView = (id)[myTableView viewWithTag:200];
    [myTableView registerClass:[NewsCell class] forCellReuseIdentifier:cellIdentifier];
    //[self setNeedsStatusBarAppearanceUpdate];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Add values to the Names array -- these are our sample riders
    
    /*
    _RiderNames = @[@"Javier",
                    @"Patrick",
                    @"Tim",
                    @"Thomas",
                    @"Chris"];
    
    //Add values to the destinations array -- these are our sample destinations
    _Destinations = @[@"The Duchossois Tennis Center",
                      @"Bedrock",
                      @"Chocolate City",
                      @"The Phi Delt House",
                      @"Hogback 1",
                      @"Buffalo Trace",
                      @"The Baseball Field",
                      @"Hogback 2",
                      @"Purple Rain",
                      @"Blue Lab Brewery",];
    
    //Add values to the time array -- these are sample times of when the sameple riders were dropped off
    _Times = @[@"3 mins ago",
               @"5 mins ago",
               @"11 mins ago",
               @"12 mins ago",
               @"14 mins ago",
               @"19 mins ago",
               @"31 mins ago",
               @"31 mins ago",
               @"37 mins ago",
               @"40 mins ago",];
     */
    
    //Add values to the riderImages array -- these are the images of sample riders
    _riderImages = @[@"samB.jpg",
                     @"caryC.jpg",
                     @"walkerH.jpg",
                     @"alexF.jpg",
                     @"russellS.jpg",
                     @"javierE.jpg",
                     @"andrewH.jpg",
                     @"robertE.jpg",
                     @"patrickM.jpg",
                     @"timB.jpg",];

    
    //_title_text_view.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:1]; //set the background color of the title label to royal blue
    //_title_text_view.scrollEnabled = NO;
    self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:1]; //set the background color of the tab bar to royal blue
    //self.LoggedInTableView.layer.cornerRadius = self.LoggedInTableView.frame.size.width / 2;
    //self.LoggedInTableView.clipsToBounds = YES;
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]]; //set selected tab bar item to white color
    
    
    //////// ~ ~ ~ ~ ~ messing around with Core Data stuff ~ ~ ~ ~ ~ //////
    
    /*
    ScoopAppDelegate *ad = (ScoopAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.managedObjectContext;
    //NSEntityDescription *userEntity = [NSEntityDescription
                                           //entityForName:@"User"
                                           //inManagedObjectContext:moc];

    
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
    NSArray *results = [[moc executeFetchRequest:request error:&error] mutableCopy];
    //NSLog(@"FETCH RESULTS:");
    //NSLog(results);
    for (User *result in results){
        NSLog(@"OBJECT");
        NSLog(result.f_name);
        NSLog(result.l_name);
        NSLog(result.phone);
        NSLog(result.email);
        NSLog(result.photo);
    }
    */
    
    /// adding the ride history to "my_profile.plist" ///
    
    
    NSMutableArray *rides_given = [[NSMutableArray alloc] init];
    NSDictionary *given_1 = @{@"rider" : @"mcdonaldp16@mail.wlu.edu", @"status": @"ACTIVE"};
    NSDictionary *given_2 = @{@"rider" : @"estradaj16@mail.wlu.edu", @"status": @"ACTIVE"};
    NSDictionary *given_3 = @{@"rider" : @"boylet16@mail.wlu.edu", @"status": @"ACTIVE"};
    NSDictionary *given_4 = @{@"rider" : @"ecksteinr16@mail.wlu.edu", @"status": @"COMPLETE"};
    NSDictionary *given_5 = @{@"rider" : @"adamsc16@mail.wlu.edu", @"status": @"COMPLETE"};
    [rides_given addObject:given_1];
    [rides_given addObject:given_2];
    [rides_given addObject:given_3];
    [rides_given addObject:given_4];
    [rides_given addObject:given_5];
    
    NSMutableArray *rides_received = [[NSMutableArray alloc] init];
    NSDictionary *received_1 = @{@"driver" : @"carabasic16@mail.wlu.edu", @"status": @"ACTIVE"};
    NSDictionary *received_2 = @{@"driver" : @"foxa16@mail.wlu.edu", @"status": @"COMPLETE"};
    NSDictionary *received_3 = @{@"driver" : @"helveyw16@mail.wlu.edu", @"status": @"COMPLETE"};
    NSDictionary *received_4 = @{@"driver" : @"heada16@mail.wlu.edu", @"status": @"COMPLETE"};
    NSDictionary *received_5 = @{@"driver" : @"yacoubiana16@mail.wlu.edu", @"status": @"COMPLETE"};
    [rides_received addObject:received_1];
    [rides_received addObject:received_2];
    [rides_received addObject:received_3];
    [rides_received addObject:received_4];
    [rides_received addObject:received_5];
    
    
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    
    //write the username and password and set BOOL value in NSUserDefaults
    
    //if the file does not exist, make it
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    
    //check if the file exists just to be sure because you do not want to perform actions on a non-existent file
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if (fileExists){
        NSMutableDictionary *userDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
        [userDict setObject:rides_given forKey:@"ridesGiven"];
        [userDict setObject:rides_received forKey:@"ridesReceived"];
        
        [userDict writeToFile:user_info atomically:YES];
    
    }
    /*
    
    /// ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ///
    NSString *user_info1 = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info1]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info1 error:nil];
    }
    
    //check if the file exists just to be sure because you do not want to perform actions on a non-existent file
    BOOL fileExists1 = [[NSFileManager defaultManager] fileExistsAtPath:user_info1];
    if (fileExists1){
        NSMutableDictionary *userDict1 = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info1];
        NSLog(@"rides received: %@", [userDict1 objectForKey:@"ridesReceived"]);
    }
    */
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    isFull = 0;
    //locationManager = [[CLLocationManager alloc] init];
    //locationManager.delegate = self;
    //locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    //locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    //[locationManager startUpdatingLocation];
    // Fix for the compatibility issue for non iOS 8.2 devices
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    riderArray = [[NSMutableArray alloc] init];
    [myTableView reloadData];
    
    
    if (isFull == 0){
        NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/download_newsfeed.php";
        /*
        NSString *urlString4 = [urlString stringByAppendingString:lat];
        NSString *urlString5 = [urlString4 stringByAppendingString:@"&lon="];
        NSString *urlString6 = [urlString5 stringByAppendingString:lon];
        */
        NSString *urlString2 = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"outbound http = %@",urlString2);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString2]];
        [request setHTTPMethod:@"GET"];
        NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString2] encoding:NSUTF8StringEncoding error:nil];
        //returnString = [returnString substringFromIndex:73];
        NSLog(@"return string = %@",returnString);
        
        NSArray *returnArray = [[NSArray alloc] init];
        returnArray = [returnString componentsSeparatedByString:@"#a#"];
        
        NSLog(@"returnArray= %@",returnArray);
        int rr=(int)[returnArray count];
        if(rr>0){
            int i =0;
            int tt = (int)[returnArray count]-1;
            for(i=0;i<tt;i++){
                NSArray *returnArray2=[returnArray[i] componentsSeparatedByString:@"##"];
                NSMutableDictionary *myDict = [[NSMutableDictionary alloc] init];
                [myDict setObject:[returnArray2 objectAtIndex:0] forKey:@"rider_name"];
                [myDict setObject:[returnArray2 objectAtIndex:1] forKey:@"rider_location"];
                [myDict setObject:[returnArray2 objectAtIndex:2] forKey:@"rider_time"];
                [myDict setObject:[returnArray2 objectAtIndex:3] forKey:@"rider_image"];
                /*
                [myDict setObject:[returnArray2 objectAtIndex:2] forKey:@"car"];
                [myDict setObject:[returnArray2 objectAtIndex:3] forKey:@"proximity"];
                [myDict setObject:[returnArray2 objectAtIndex:4] forKey:@"rating"];
                [myDict setObject:[returnArray2 objectAtIndex:5] forKey:@"image"];
                [myDict setObject:[returnArray2 objectAtIndex:6] forKey:@"phone"];
                [myDict setObject:[returnArray2 objectAtIndex:7] forKey:@"latitude"];
                [myDict setObject:[returnArray2 objectAtIndex:8] forKey:@"longitude"];
                 */
                [riderArray addObject:myDict];
            }
        }
        NSLog(@"rider array = %@", riderArray);
        [myTableView reloadData];
        isFull = 1;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
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
    [report_button addTarget:self action:@selector(btnSelected) forControlEvents:UIControlEventTouchUpInside];
    
    image_view.image = report_image;
    
    [report_button addSubview:image_view];
    
    [title_view addSubview:title_label];
    [title_view addSubview:report_button];

    return title_view;
}

- (void)btnSelected {
    NSLog(@"button clicked");
    [self performSegueWithIdentifier:@"report_segue" sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1; //There will be one section for the news feed
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [riderArray count]; //This will display a news feed row for each sample rider.
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTableIdentifier" forIndexPath:indexPath];
    
    //locate the table cell that will be manipulated
    //static NSString *CellIdentifier = @"TableCell";
    //TableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    //Each row is formatted to display the values at the corresponding indices
    //of the sample arrays generated in the viewDidLoad method.  For example, the first
    //row displays the values at the first index of all the arrays (name = "Sam Borowsky",
    //car = "Toyota Rav4", image = "Borowsky.jpg", rating = "3.4/5").
    //int row = [indexPath row];
    
    //    int row = (int)[indexPath row];
    
    //NSString *value = [_Availability objectAtIndex:row];
    //NSLog(value);
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
   // [cell.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
   // [cell.contentView.layer setBorderWidth:1.0f];
    
    if (indexPath.row % 2 == 1){
        cell.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1];
        //[cell.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        //[cell.contentView.layer setBorderWidth:0.4f];
    }
    //AppDelegate *dataCenter = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    //cell2.messageTitle=[tempArray objectAtIndex:1];
    //cell2.posterName=[tempArray objectAtIndex:3];
    //cell2.courseImageName=[tempArray objectAtIndex:2];
    //cell2.messageText=[tempArray objectAtIndex:4];
    
    NSMutableDictionary *tDict = [[NSMutableDictionary alloc] initWithDictionary:[riderArray objectAtIndex:indexPath.row]];
    
    // NSLog(@"tDict for Drivers = %@",[tDict objectForKey:@"firstname"]);
    
    cell.riderImageName = [tDict objectForKey:@"rider_image"];
    
    NSString *messageName = [tDict objectForKey:@"rider_name"];
    NSString *messageConstant = @" got scooped to ";
    NSString *messageLocation = [tDict objectForKey:@"rider_location"];
    
    NSString *messageString = messageName;
    NSString *messageString2 = [messageString stringByAppendingString:messageConstant];
    NSString *messageString3 = [messageString2 stringByAppendingString:messageLocation];
    
    cell.messageLabelValue = messageString3;
    
    NSString *dropoff_time = [tDict objectForKey:@"rider_time"];
    NSString *dropoff_month = [dropoff_time substringWithRange:NSMakeRange(5,2)];
    NSString *dropoff_day = [dropoff_time substringWithRange:NSMakeRange(8,2)];
    NSString *dropoff_year = [dropoff_time substringWithRange:NSMakeRange(0,4)];
    NSString *dropoff_hm = [dropoff_time substringWithRange:NSMakeRange(11,5)];
    
    NSString *dropoff_time_pretty = dropoff_month;
    dropoff_time_pretty = [dropoff_time_pretty stringByAppendingString:@"-"];
    dropoff_time_pretty = [dropoff_time_pretty stringByAppendingString:dropoff_day];
    dropoff_time_pretty = [dropoff_time_pretty stringByAppendingString:@"-"];
    dropoff_time_pretty = [dropoff_time_pretty stringByAppendingString:dropoff_year];
    dropoff_time_pretty = [dropoff_time_pretty stringByAppendingString:@" at "];
    dropoff_time_pretty = [dropoff_time_pretty stringByAppendingString:dropoff_hm];

    
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"MM-dd-yyyy 'at' HH:mm"];
    NSTimeZone *est = [NSTimeZone timeZoneWithName:@"ET"];
    [date_formatter setTimeZone:est];
    
    NSDate *dropoff_date = [date_formatter dateFromString:dropoff_time_pretty];
    
    NSString *current_date_str = [date_formatter stringFromDate:[NSDate date]];
    NSDate *current_date = [date_formatter dateFromString:current_date_str];

    NSTimeInterval elapsed_time = [current_date timeIntervalSinceDate:dropoff_date];

    float total_hours = elapsed_time/3600;
    
    NSString *total_hours_str = [NSString stringWithFormat:@"%1.6f", total_hours];
    
    NSArray *hm_array = [total_hours_str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
    NSString *final_hours = [hm_array objectAtIndex:0];
    NSString *decimal = @".";
    NSString *final_mins = [hm_array objectAtIndex:1];
    decimal = [decimal stringByAppendingString:final_mins];
    float mins_float = [decimal floatValue];
    int mins_int = (int)round(mins_float * 60);
    NSString *mins_str = [NSString stringWithFormat:@"%d", mins_int];
    
    NSString *final_time = [final_hours stringByAppendingString:@"h "];
    final_time = [final_time stringByAppendingString:mins_str];
    final_time = [final_time stringByAppendingString:@"m"];
    
    cell.timeLabelValue = final_time;
    
    //cell.riderImageValue = [tDict objectForKey:@"car"];
    
    // null until I figure out how to access rider images...in database?
    //cell.riderImageName = NULL;
    
    /*
    NSString *firstPhone = [tDict objectForKey:@"phone"];
    NSString *num1 = [firstPhone substringWithRange:NSMakeRange(0, 3)];
    NSString *num2 = [firstPhone substringWithRange:NSMakeRange(3, 3)];
    NSString *num3 = [firstPhone substringWithRange:NSMakeRange(6, 4)];
    
    NSString *phoneString = [@"(" stringByAppendingString:num1];
    NSString *phoneString2 = [phoneString stringByAppendingString:@") "];
    NSString *phoneString3 = [phoneString2 stringByAppendingString: num2];
    NSString *phoneString4 = [phoneString3 stringByAppendingString:@"-"];
    NSString *phoneString5 = [phoneString4 stringByAppendingString:num3];
    
     
    cell.phoneValue = phoneString5;
    NSString *dist = [tDict objectForKey:@"proximity"];
    // int prox_length = (int)[dist count];
    if ([dist length] >= 3){
        dist = [dist substringToIndex:3];
    }
    NSString *dist2 = [dist stringByAppendingString:@" mi"];
    cell.distValue = dist2;
    cell.driverImageName=[tDict objectForKey:@"image"];
    
    //NSLog(@"tdict %@",[tDict objectForKey:@"firstname"]);
    
    //cell.DriverImage.image = [tDict objectForKey:@"image"];
    //cell.NameLabel.text=[tDict objectForKey:@"firstname"];
    //cell.CarLabel.text = [tDict objectForKey:@"car"];
    //cell.RatingLabel.text = [tDict objectForKey:@"phone"]; //get the phone number
    //cell.ProximityLabel.text = [tDict objectForKey:@"proximity"]; //get the proper driver proximity
    
      UIImage *driver = [UIImage imageNamed:[_Images objectAtIndex:indexPath.row]];
     CALayer *imageLayer = cell.DriverImage.layer;
     [imageLayer setCornerRadius:40];
     [imageLayer setBorderWidth:1];
     [imageLayer setMasksToBounds:YES];
     cell.DriverImage.image = driver; //get the proper image
     */
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end