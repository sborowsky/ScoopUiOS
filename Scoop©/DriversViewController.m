//
//  Scoop©
//  Sam Borowsky
//  DriversViewController.m
//  The implementation file for the avialable drivers table controller
//  01.29.2015
//

#import "DriversViewController.h"
#import "CustomCell.h"
#import "ScoopAppDelegate.h"
//#import "TableCell.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface DriversViewController ()

@end

@implementation DriversViewController
@synthesize locationManager,lat,lon,driverArray,driversTableView,isFull,title_view;

static NSString *cellIdentifier = @"cellTableIdentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    driversTableView = (id)[driversTableView viewWithTag:20];
    [driversTableView registerClass:[CustomCell class] forCellReuseIdentifier:cellIdentifier];
    
    self.driversTableView.delegate = self;
    self.driversTableView.dataSource = self;
    
    //_AvailableLabel.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:1]; //set the background color of the title label to royal blue
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //Add values to the Names array -- these are our sample drivers
        _Names = @[@"Javier",
                  @"Patrick",
                  @"Tim",
                  @"Thomas",
                  @"Chris",
                   @"Alex",
                   @"Walker"];
    
    //Add values to the Cars array -- these are our sample cars
    _Cars = @[@"Range Rover",
              @"GMC Yukon",
              @"Jeep Cherokee",
              @"Chevy Tahoe",
              @"Lexus LS460",
              @"Toyota Rav4",
              @"Honda Civic"];
    
    //Add values to the Phone array
    _Phones = @[@"(452) 181-7535",
                @"(241) 878-3944",
                @"(608) 590-3402",
                @"(973) 044-8276",
                @"(744) 105-7299",
                @"(504) 613-5944",
                @"(306) 723-0491"];
    
    //Add values to the Images array -- these are images of our sample drivers
    _Images = @[@"javier_sub.jpg",
                @"patrick_sub.jpg",
                @"tim_sub.jpg",
                @"thomas_sub.jpg",
                @"chadam_sub.jpg",
                @"fox_sub.png",
                @"walker_sub.png"];
    
    //Add sample ratings corresponding to the drivers
    _Ratings = @[@"3.4/5",
                 @"3.0/5",
                 @"3.8/5",
                 @"4.7/5",
                 @"4.1/5",
                 @"2.3/5",
                 @"4.9/5"];
    
    //Set sample availability status for each driver
    _Availability = @[@"Yes",
                      @"Yes",
                      @"No",
                      @"No",
                      @"Yes",
                      @"Yes"];
    
    _Proximity = @[@"2.4 mi",
                   @"2.6 mi",
                   @"3.0 mi",
                   @"3.5 mi",
                   @"3.9 mi",
                   @"4.1 mi",
                   @"6.8 mi"];
    
    
    //_AvailableLabel.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8]; //set the background color of the title label to royal blue
 
    [driversTableView setAllowsSelection:YES];
    
    //adding the header for the view
    self.title_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    title_view.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8]; //set the background color of the title label to royal blue
    
    UILabel *title_label = [[UILabel alloc] init];
    title_label.frame = CGRectMake(0, (title_view.frame.size.height/2)-10, self.view.frame.size.width, 40);
    title_label.textAlignment = NSTextAlignmentCenter;
    title_label.font = [UIFont fontWithName:@"Noteworthy-Bold" size:24];
    title_label.textColor = [UIColor whiteColor];
    title_label.text = @"Available Drivers";
    
    [title_view addSubview:title_label];
    [self.view addSubview:title_view];
}

/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * title_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    title_view.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:1]; //set the background color of the title label to royal blue
    
    UILabel * title_label = [[UILabel alloc] init];
    title_label.frame = CGRectMake(0, (title_view.frame.size.height/2)-10, tableView.frame.size.width, 40);
    title_label.textAlignment = NSTextAlignmentCenter;
    title_label.font = [UIFont fontWithName:@"Noteworthy-Bold" size:24];
    title_label.textColor = [UIColor whiteColor];
    title_label.text = @"Available Drivers";
    
    [title_view addSubview:title_label];
    return title_view;
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"in view did appear");
    [super viewDidAppear:YES];
    isFull = 0;
    /*
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    */
    // Fix for the compatibility issue for non iOS 8.2 devices
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
    {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    driverArray = [[NSMutableArray alloc] init];
    //[self getDrivers];
    [driversTableView reloadData];
    isFull = 1;
}

/*
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@",error.description);
}
*/
 
//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
- (void)getDrivers
{
    /*
    
    // NSLog(@"didUpdateToLocation: %@", newLocation);
    
    //CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        lon = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        NSLog(@"lon: %@", lon);
        NSLog(@"lat: %@", lat);
        lat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        //            NSLog(@"lat = %@",lat);
        //            NSLog(@"lon = %@",lon);
     */
    
    ScoopAppDelegate *appDelegate = (ScoopAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableArray *lat_lon = appDelegate.location_array;
    lat = [lat_lon objectAtIndex:0];
    lon = [lat_lon objectAtIndex:1];
    
    if (isFull == 0){
        NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/download_info.php?lat=";
        NSString *urlString4 = [urlString stringByAppendingString:lat];
        NSString *urlString5 = [urlString4 stringByAppendingString:@"&lon="];
        NSString *urlString6 = [urlString5 stringByAppendingString:lon];
        
        NSString *urlString9 = [urlString6 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"outbound http = %@",urlString9);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString9]];
        [request setHTTPMethod:@"GET"];
        NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString9] encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"return string = %@",returnString);
        
        NSArray *returnArray = [returnString componentsSeparatedByString:@"#a#"];
        NSLog(@"returnArray= %@",returnArray);
        int rr=(int)[returnArray count];
        if(rr>0){
            int i =0;
            int tt = (int)[returnArray count]-1;
            for(i=0;i<tt;i++){
                NSArray *returnArray2=[returnArray[i] componentsSeparatedByString:@"##"];
                NSMutableDictionary *myDict = [[NSMutableDictionary alloc] init];
                [myDict setObject:[returnArray2 objectAtIndex:0] forKey:@"firstname"];
                [myDict setObject:[returnArray2 objectAtIndex:1] forKey:@"lastname"];
                [myDict setObject:[returnArray2 objectAtIndex:2] forKey:@"car"];
                [myDict setObject:[returnArray2 objectAtIndex:3] forKey:@"proximity"];
                [myDict setObject:[returnArray2 objectAtIndex:4] forKey:@"rating"];
                [myDict setObject:[returnArray2 objectAtIndex:5] forKey:@"image"];
                [myDict setObject:[returnArray2 objectAtIndex:6] forKey:@"phone"];
                [myDict setObject:[returnArray2 objectAtIndex:7] forKey:@"latitude"];
                [myDict setObject:[returnArray2 objectAtIndex:8] forKey:@"longitude"];
                [driverArray addObject:myDict];
            }
        }
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"proximity" ascending: YES selector:@selector(localizedStandardCompare:)];
        [driverArray sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];

        
        NSLog(@"driver array = %@", driverArray);
        //[driversTableView reloadData];
        //isFull = 1;
    }
    
    // Stop Location Manager
    //[locationManager stopUpdatingLocation];
}
    


-(NSString *)docsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1; //There will be one section for the available drivers
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    //return [driverArray count];
    return 7; //This will display 7 (sample) driver profiles, though ultimately we want to display all
    //the drivers that are available rather than this fixed number that I specify.
    //This will require me to figure out how to filter through the Availability array
    //to distinguish between the drivers that are available and those that are not available.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // ~ ~ ~ commented out because app currently does not retrieve live driver information (driverArray) - rather, the drivers table
    // ~ ~ ~ is populated with sample data
    
    /*
    NSMutableDictionary *tDict = [[NSMutableDictionary alloc] initWithDictionary:[driverArray objectAtIndex:indexPath.row]];

    NSString *num3=[tDict objectForKey:@"phone"];
    */
    
    
    CustomCell *selectedCell = (CustomCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSString *driverPhone = selectedCell.phoneValue;
    
    NSString *num1 = [driverPhone substringWithRange:NSMakeRange(1, 3)];
    NSString *num2 = [num1 stringByAppendingString:[driverPhone substringWithRange:NSMakeRange(6, 3)]];
    NSString *num3 = [num2 stringByAppendingString:[driverPhone substringWithRange:NSMakeRange(10, 4)]];
    
    
    NSString *prompt = @"telprompt://";
    NSString *prompt2 = [prompt stringByAppendingString:num3];
    NSLog(@"number to call: %@", prompt2);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:prompt2]];
     
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"in cellForRow........");
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
    
    //int row = (int)[indexPath row];
    
    //NSString *value = [_Availability objectAtIndex:row];
    //NSLog(value);
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];  // disable cell highlighting
    /*
    if (indexPath.row % 2 == 1){
        cell.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1];
        //[cell.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        //[cell.contentView.layer setBorderWidth:0.4f];
    }
    */
     
    NSLog(@"in cell for row");
 
    cell.nameLabelValue = [_Names objectAtIndex:indexPath.row];
    cell.carValue = [_Cars objectAtIndex:indexPath.row];
    cell.phoneValue = [_Phones objectAtIndex:indexPath.row];
    cell.driverNoImageName = [_Images objectAtIndex:indexPath.row];
    cell.distValue = [_Proximity objectAtIndex:indexPath.row];
        
    
    //AppDelegate *dataCenter = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    //cell2.messageTitle=[tempArray objectAtIndex:1];
    //cell2.posterName=[tempArray objectAtIndex:3];
    //cell2.courseImageName=[tempArray objectAtIndex:2];
    //cell2.messageText=[tempArray objectAtIndex:4];
    
    
    
    /* - - - -
    
    
    NSMutableDictionary *tDict = [[NSMutableDictionary alloc] initWithDictionary:[driverArray objectAtIndex:indexPath.row]];
    
   // NSLog(@"tDict for Drivers = %@",[tDict objectForKey:@"firstname"]);
    
    cell.nameLabelValue = [tDict objectForKey:@"firstname"];
    
    if ([[tDict objectForKey:@"car"] isEqualToString:@""]){
        cell.carValue = @"Car N/A";
    }
    else{
        cell.carValue = [tDict objectForKey:@"car"];
    }
    
    NSString *firstPhone = [tDict objectForKey:@"phone"];
    if ([firstPhone length] < 10){
       // NSLog(@"error");
        cell.phoneValue = @"error";

    }
    else{
        
    NSString *num1 = [firstPhone substringWithRange:NSMakeRange(0, 3)];
    NSString *num2 = [firstPhone substringWithRange:NSMakeRange(3, 3)];
    NSString *num3 = [firstPhone substringWithRange:NSMakeRange(6, 4)];

    NSString *phoneString = [@"(" stringByAppendingString:num1];
    NSString *phoneString2 = [phoneString stringByAppendingString:@") "];
    NSString *phoneString3 = [phoneString2 stringByAppendingString: num2];
    NSString *phoneString4 = [phoneString3 stringByAppendingString:@"-"];
    NSString *phoneString5 = [phoneString4 stringByAppendingString:num3];
    cell.phoneValue = phoneString5;

    }
    //cell.phoneValue = phoneString5;
    NSString *dist = [tDict objectForKey:@"proximity"];
    float dist_float = [dist floatValue];
    NSString *dist_str_pretty = [NSString stringWithFormat:@"%.1f",dist_float];
    
    
    
   ----- */
    
    
    /*
   // int prox_length = (int)[dist count];
    if ([dist length] >= 3){
        dist = [dist substringToIndex:4];
    }
    */
    
    
    
    /* - - - -
    
    
    NSString *dist2 = [dist_str_pretty stringByAppendingString:@" mi"];
    cell.distValue = dist2;
    
    
    if ([[tDict objectForKey:@"image"] isEqualToString:@""]){
        cell.driverNoImageName = @"icon_official_60.png";
    }
    else{
        cell.driverImageName = [tDict objectForKey:@"image"];
    }
     
     
     
    */
     
     
    
    //cell.driverImageName=[tDict objectForKey:@"image"];
   
    //NSLog(@"tdict %@",[tDict objectForKey:@"firstname"]);
    
    //cell.DriverImage.image = [tDict objectForKey:@"image"];
    //cell.NameLabel.text=[tDict objectForKey:@"firstname"];
    //cell.CarLabel.text = [tDict objectForKey:@"car"];
    //cell.RatingLabel.text = [tDict objectForKey:@"phone"]; //get the phone number
    //cell.ProximityLabel.text = [tDict objectForKey:@"proximity"]; //get the proper driver proximity
    
    /*  UIImage *driver = [UIImage imageNamed:[_Images objectAtIndex:indexPath.row]];
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