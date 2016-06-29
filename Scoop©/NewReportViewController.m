//
//  NewReportViewController.m
//  Scoop©
//
//  Created by Samuel Borowsky on 4/28/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "NewReportViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface NewReportViewController ()

@end

@implementation NewReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //format the "Submit" button
    _submit_report.layer.shadowColor = [UIColor blackColor].CGColor;
    _submit_report.layer.shadowOffset = CGSizeMake(7.0, 7.0);
    _submit_report.layer.shadowOpacity = 0.9;
    _submit_report.layer.shadowRadius = 5.0;
    
    _submit_report.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.6]; //set the background color of the "update" button to royal blue
    
    //format the "Go Home" button
    _back_home.layer.shadowColor = [UIColor blackColor].CGColor;
    _back_home.layer.shadowOffset = CGSizeMake(7.0, 7.0);
    _back_home.layer.shadowOpacity = 0.9;
    _back_home.layer.shadowRadius = 5.0;
    
    _back_home.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.6]; //set the background color of the "update" button to royal blue
    
    
    
    //create header for view controller that says "Scoop Report"
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    subview.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8]; //set the background color of the title label to royal blue
    
    UILabel *title_label = [[UILabel alloc] init];
    title_label.frame = CGRectMake(0, (subview.frame.size.height/2)-10, subview.frame.size.width, 40);
    title_label.textAlignment = NSTextAlignmentCenter;
    title_label.font = [UIFont fontWithName:@"Noteworthy-Bold" size:24];
    title_label.textColor = [UIColor whiteColor];
    title_label.text = @"Scoop Report";
    
    [subview addSubview:title_label];
    [self.view addSubview:subview];
    
    
    _title_label.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8]; //set the background color of the title label to royal blue
    _report_image.layer.cornerRadius = 50;
    _report_image.layer.masksToBounds = YES;
    
    [_select_image_btn.layer setCornerRadius:50];
    [_select_image_btn.layer setMasksToBounds:YES];
    
    // Do any additional setup after loading the view.
}



//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 70;
//}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1; //There will be one section for the news feed
}

- (IBAction)submit_report:(id)sender {
    
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
    NSString *urlString8 = [urlString7 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"outbound http = %@",urlString8);
    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString8]];
    
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
            
            //[myDict setObject:f_name_label.text forKey:@"firstname"];
            // [myDict setObject:l_name_label.text forKey:@"lastname"];
            // [myDict setObject:car_label.text forKey:@"car"];
            //[myDict setObject:phone_label.text forKey:@"cellNumber"];
            
            
            //NSString *filePath = [NSString stringWithFormat:@"%@/%@",
            //documentsDirectory, @"profile.jpg"];
            //[imageData writeToFile:filePath atomically:YES];
            
            //  [myDict writeToFile:user_info atomically:YES];
            
            UIAlertView *alertView7 = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your report has been successfully added." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView7 show];
            
        }else{
            UIAlertView *alertView7 = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Your report failed to upload." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView7 show];
        }
    }else{
        UIAlertView *alertView8 = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Your report must include a picture." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView8 show];
        
        //NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString8] encoding:NSUTF8StringEncoding error:nil];
        // NSLog(@"return string = %@",returnString);
    }
    
}

// [request setHTTPMethod:@"GET"];
/*
 NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString8] encoding:NSUTF8StringEncoding error:nil];
 NSLog(@"return string = %@",returnString);
 //if([returnString isEqualToString:@"success"]){
 UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Your Report Was Successfully Uploaded." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
 [error show];
 
 //[self performSegueWithIdentifier:@"back_to_feed" sender:self];
 
 else{
 UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We were unable to change your status at this time." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
 [error show];
 }
 */


// Dismiss the keyboard when the user taps the background
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)go_home:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)loadImage:(id)sender{
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
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:nil];
    if([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        _report_image.image=image;
        //        profileImage.imageView.image=image;
        [_select_image_btn setImage:image forState:UIControlStateNormal];
        if(newMedia){
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
        }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
            //video is not supported
        }
    }
    [_report_image.layer setCornerRadius:50];
    [_report_image.layer setMasksToBounds:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //        self.imageView=nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if(error){UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save Failed" message:@"The Image Failed to Save" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

