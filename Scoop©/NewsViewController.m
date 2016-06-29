//
//  Scoop©
//  Sam Borowsky
//  LoggedInTableViewController.m
//  The implementation file for the app's news feed that appears after
//  a user successfully logs in.
//  02.12.2015
//

#import "NewsViewController.h"  //the interface for the view controller
#import "NewsCell.h"
#import <QuartzCore/QuartzCore.h>


@interface NewsViewController ()

@end

@implementation NewsViewController
@synthesize locationManager,lat,lon,riderArray,myTableView,isFull,title_view,report_button,display_str, userDict, user_info, back_button;


static NSString *cellIdentifier = @"CellTableIdentifier";


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(NSString *)docsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.display_str = @"table";
    
    myTableView = (id)[myTableView viewWithTag:200];
    [myTableView registerClass:[NewsCell class] forCellReuseIdentifier:cellIdentifier];
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.display_str = [[NSString alloc] init];
    self.display_str = @"table";
    
    self.title_view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    title_view.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8]; //set the background color of the title label to royal blue
    
    UILabel *title_label = [[UILabel alloc] init];
    title_label.frame = CGRectMake(0, (title_view.frame.size.height/2)-10, self.view.frame.size.width, 40);
    title_label.textAlignment = NSTextAlignmentCenter;
    title_label.font = [UIFont fontWithName:@"Noteworthy-Bold" size:24];
    title_label.textColor = [UIColor whiteColor];
    title_label.text = @"Scoop Feed";
    
    self.report_button = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width-50, 27, 40, 40)];
    UIImageView *image_view = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width-50, 25, 40, 40)];
    image_view.alpha = .4;
    UIImage *report_image = [UIImage imageNamed:@"feed_btn_pic3.png"];
    [report_button setImage:report_image forState:UIControlStateNormal];
    [report_button addTarget:self action:@selector(showReportForm) forControlEvents:UIControlEventTouchUpInside];
    image_view.image = report_image;
    [report_button addSubview:image_view];
    
    self.back_button = [[UIButton alloc] initWithFrame:CGRectMake(15, 36, 22, 22)];
    [back_button setHidden:YES];

    UIImage *back_button_img = [UIImage imageNamed:@"report_back_0"];
    [back_button setBackgroundImage:back_button_img forState:UIControlStateNormal];
    [back_button addTarget:self action:@selector(showTableView) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [title_view addSubview:title_label];
    [title_view addSubview:report_button];
    [title_view addSubview:back_button];
    
    [self.view addSubview:title_view];
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
    
    

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    //self.display_str = @"table";
    NSLog(@"display string= %@", display_str);
    
    [self preferredStatusBarStyle]; ///
    
    if ([display_str isEqualToString:@"table"]){
        [self showTableView];
        [self downloadFeed];
        [myTableView reloadData];
    }
    
    else {
        [self showReportForm];
    }
    
    
}

- (void)showTableView {
    self.display_str = @"table";
    [back_button setHidden:YES];
    [report_button setHidden:NO];
    [_name_field setHidden:YES];
    [_location_field setHidden:YES];
    [_view_label setHidden:YES];
    [_submit_report setHidden:YES];
    [_select_image_btn setHidden:YES];
    
    [myTableView setHidden:NO];
}

- (void)downloadFeed{
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
    [self.myTableView reloadData];


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
                [myDict setObject:[returnArray2 objectAtIndex:4] forKey:@"report_id"];
                [myDict setObject:[returnArray2 objectAtIndex:0] forKey:@"rider_name"];
                [myDict setObject:[returnArray2 objectAtIndex:1] forKey:@"rider_location"];
                [myDict setObject:[returnArray2 objectAtIndex:2] forKey:@"rider_time"];
                [myDict setObject:[returnArray2 objectAtIndex:3] forKey:@"rider_image"];
                [myDict setObject:[returnArray2 objectAtIndex:5] forKey:@"total_likes"];
                [myDict setObject:@"beforeLike.jpg" forKey:@"like_image"];
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
        [self.myTableView reloadData];
        isFull = 1;
    }
}

- (void)showReportForm {
    NSLog(@"button clicked");
    
    [self preferredStatusBarStyle];
    
    display_str = @"report";
    
    [myTableView setHidden:YES];
    [report_button setHidden:YES];
    
    [back_button setHidden:NO];
    [_name_field setHidden:NO];
    //[_name_field setText:@""];
    
    [_location_field setHidden:NO];
    //[_location_field setText:@""];
    
    [_view_label setHidden:NO];
    
    [_submit_report setHidden:NO];
    //_submit_report.layer.shadowColor = [UIColor blackColor].CGColor;
    //_submit_report.layer.shadowOffset = CGSizeMake(7.0, 7.0);
    //_submit_report.layer.shadowOpacity = 0.9;
    //_submit_report.layer.shadowRadius = 5.0;
    [[_submit_report layer] setBorderWidth:3.0f];
    [_submit_report.layer setBorderColor:[UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8].CGColor];
    [_submit_report.layer setCornerRadius:5];
    [_submit_report.layer setMasksToBounds:YES];
    _submit_report.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
    [_submit_report setTitleColor:[UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8] forState:UIControlStateNormal];
    //[_submit_report.layer setBackgroundColor:[UIColor colorWithRed:(180/255.0) green:(180/255.0) blue:(180/255.0) alpha:1].CGColor];
    
    [_select_image_btn setHidden:NO];
    //[_select_image_btn setImage:[UIImage imageNamed:@"new_report_def.jpg"] forState:UIControlStateNormal];
    [_select_image_btn.layer setCornerRadius:50];
    [_select_image_btn.layer setMasksToBounds:YES];
    
    self.view.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"";
}


- (IBAction)submitReport:(id)sender {
    //this grabs the image and makes it a 90% quality jpeg
    NSData *imageData = UIImageJPEGRepresentation(image, 90);
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"America/Atikokan"]];
    NSLog(@"%@",[formatter stringFromDate:now]);
    
    NSString *user_name = _name_field.text;
    //NSMutableArray *name_array = [[user_name componentsSeparatedByString:@" "] mutableCopy];
    NSArray *name_array = [user_name componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    int array_size = (int)[name_array count];
    NSLog(@"array size: %d", array_size);
    if (array_size != 2){
        UIAlertView *alertView0 = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You must include a first and last name in the report." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView0 show];
        return;
    }
    //NSLog([name_array objectAtIndex:0]);
    //NSLog([name_array objectAtIndex:1]);
    NSString *user_first_name = [name_array objectAtIndex:0];
    NSString *user_last_name = [name_array objectAtIndex:1];
    NSString *user_location = _location_field.text;
    
    //load the position and status to the web.
    NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/upload_to_newsfeed.php?id=";
    NSString *urlString2 = [urlString stringByAppendingString:@"&first_name="];
    NSString *urlString3 = [urlString2 stringByAppendingString:user_first_name];
    NSString *urlString4 = [urlString3 stringByAppendingString:@"&last_name="];
    NSString *urlString5 = [urlString4 stringByAppendingString:user_last_name];
    NSString *urlString6 = [urlString5 stringByAppendingString:@"&location="];
    NSString *urlString7 = [urlString6 stringByAppendingString:user_location];
    NSString *urlString8 = [urlString7 stringByAppendingString:@"&likes="];
    NSString *urlString9 = [urlString8 stringByAppendingString:@"0"];
    NSString *urlString10 = [urlString9 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"outbound http = %@",urlString10);
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString10]];
    
    if(image){
        [request setHTTPMethod:@"POST"];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"item_file.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody: body];
        
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        
        
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"return string = %@",returnString);
        if([returnString isEqualToString:@"success"]){
            
            UIAlertView *alertView7 = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your report has been successfully added." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            alertView7.tag = 100;
            [alertView7 show];
            
        }else{
            UIAlertView *alertView8 = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Your report failed to upload." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView8 show];
        }
    }else{
        UIAlertView *alertView9 = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Your report must include a picture." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView9 show];
        
        //NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString8] encoding:NSUTF8StringEncoding error:nil];
        // NSLog(@"return string = %@",returnString);
    }
    
}


-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // Is this my Alert View?
    if (alertView.tag == 100) {
        if (buttonIndex == 0) { // 1st Button
            display_str = @"table";
            
            [self downloadFeed];
            [self showTableView];
            [myTableView reloadData];
            
            [self preferredStatusBarStyle];
        }
    }
    
}


- (IBAction)loadImage:(id)sender {
    NSLog(@"in loadImage");
    self.display_str = @"report";
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        [self presentViewController:imagePicker animated:YES completion:nil];
        newMedia = NO;
    }
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"in imagePickerController");
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        _report_image.image=image;
        //        profileImage.imageView.image=image;
        //[_select_image_btn setImage:image forState:UIControlStateNormal];
        [_select_image_btn.imageView setImage:image];
        if(newMedia){
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
        }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
            //video is not supported
        }
    }
    [_select_image_btn.layer setCornerRadius:50];
    [_select_image_btn.layer setMasksToBounds:YES];
    
    [self preferredStatusBarStyle];
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"in imagePicker cancelled...");
    //        self.imageView=nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    NSLog(@"in finishedSavingWithError");
    if(error){UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Failed" message:@"The Image Failed to Save" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
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

- (void)likeClicked:(UIButton*)sender{
    NSLog(@"in likeClicked");
    
    NSInteger btnTag = [sender tag];
    
    NSMutableDictionary *tDict = [riderArray objectAtIndex:btnTag];
    
    self.user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    
    //if the file does not exist, make it
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    
    //check if the file exists just to be sure because you do not want to perform actions on a non-existent file
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if (fileExists){
        self.userDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
        
    }

    NSMutableArray *user_likes = [userDict objectForKey:@"liked_reports"];
    
    NSString *id_str = [tDict objectForKey:@"report_id"];
    
    if ([user_likes containsObject:id_str]){
        return;
    }
    
    
    NSInteger likes_int = [[tDict objectForKey:@"total_likes"] intValue];
    NSInteger likes_int_new = likes_int + 1;
    NSString *likes_str_new = [NSString stringWithFormat:@"%ld", (long)likes_int_new];
    
    NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/add_newsfeed_like.php?";
    NSString *urlString2 = [urlString stringByAppendingString:@"id="];
    NSString *urlString3 = [urlString2 stringByAppendingString:id_str];
    NSString *urlString4 = [urlString3 stringByAppendingString:@"&likes="];
    NSString *urlString5 = [urlString4 stringByAppendingString:likes_str_new];
    NSString *urlString6 = [urlString5 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"outbound http = %@",urlString6);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString6]];
    [request setHTTPMethod:@"GET"];
    NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString6] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"return string = %@",returnString);

    
    [tDict setObject:likes_str_new forKey:@"total_likes"];
    [tDict setObject:@"afterLike.jpg" forKey:@"like_image"];
    
    [user_likes addObject:id_str];
    [userDict setObject:user_likes forKey:@"liked_reports"];
    [userDict writeToFile:user_info atomically:YES];
    
    [riderArray replaceObjectAtIndex:btnTag withObject:tDict];
    [myTableView reloadData];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"in cellForRow...");

    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];  // disable cell highlighting
    
    cell.likeButton.tag =indexPath.row;
    [cell.likeButton addTarget:self action:@selector(likeClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableDictionary *tDict = [[NSMutableDictionary alloc] initWithDictionary:[riderArray objectAtIndex:indexPath.row]];
    
    //cell.likeImageName = [tDict objectForKey:@"like_image"];
    
    ///// if the report has been liked, show afterLike.jpg image, otherwise show beforeLike.jpg image /////
    self.user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    
    //if the file does not exist, make it
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    
    //check if the file exists just to be sure because you do not want to perform actions on a non-existent file
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if (fileExists){
        self.userDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
        
    }
    
    NSMutableArray *user_likes = [userDict objectForKey:@"liked_reports"];
    
    if ([user_likes containsObject:([tDict objectForKey:@"report_id"])]){
        cell.likeImageName = @"afterLike.jpg";
    }
    else{
        cell.likeImageName = @"beforeLike.jpg";
    }
    ///// end setting like button image /////
    
    NSString *likes = [tDict objectForKey:@"total_likes"];
    cell.likeTotal = likes;
    
    NSLog(@"populating cell, dictionary= %@", tDict);
    
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
    NSLog(@"total hours= %f", total_hours);
    
    if (total_hours < 1) {
        NSInteger mins = total_hours * 60;
        NSString *mins_str = [NSString stringWithFormat:@"%ld", (long)mins];
        NSString *mins_str2 = [mins_str stringByAppendingString:@"m"];
        cell.timeLabelValue = mins_str2;
    }
    
    else if (total_hours >= 24) {
        NSInteger days = total_hours/24;
        NSString *days_str = [NSString stringWithFormat:@"%ld", (long)days];
        NSString *days_str2 = [days_str stringByAppendingString:@"d"];
        cell.timeLabelValue = days_str2;
    }
    
    else {
        NSString *total_hours_str = [NSString stringWithFormat:@"%1.6f", total_hours];
        
        NSArray *hm_array = [total_hours_str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
        NSString *final_hours = [hm_array objectAtIndex:0];
        //NSString *decimal = @".";
        //NSString *final_mins = [hm_array objectAtIndex:1];
        //decimal = [decimal stringByAppendingString:final_mins];
        //float mins_float = [decimal floatValue];
        //int mins_int = (int)round(mins_float * 60);
        //NSString *mins_str = [NSString stringWithFormat:@"%d", mins_int];
        
        NSString *final_time = [final_hours stringByAppendingString:@"h"];
        //final_time = [final_time stringByAppendingString:mins_str];
        //final_time = [final_time stringByAppendingString:@"m"];
        
        cell.timeLabelValue = final_time;
    }
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

// Dismiss the keyboard when the user taps the background
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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