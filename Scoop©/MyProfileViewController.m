//
//  MyProfileViewController.m
//  Scoop©
//
//  Created by Samuel Borowsky on 2/19/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import "MyProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ScoopAppDelegate.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController
@synthesize imageView, profileImage;


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    NSMutableDictionary *myDict = [[NSMutableDictionary alloc] init];
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if(fileExists){
        myDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
    }
    
    
    f_name_label.text = [myDict objectForKey:@"firstName"];
    l_name_label.text = [myDict objectForKey:@"lastName"];
    car_label.text = [myDict objectForKey:@"car"];
    NSLog(@"car value: %@", [myDict objectForKey:@"car"]);
    email_label.text = [myDict objectForKey:@"email"];
    phone_label.text = [myDict objectForKey:@"cellNumber"];
    
//    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
//    NSString *docDirectory = [sysPaths objectAtIndex:0];
//    NSString *filePath = [NSString stringWithFormat:@"%@/profile_pic.jpg", docDirectory];
//    imageView.image = [[UIImage alloc] initWithContentsOfFile:filePath];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"profile.jpg"];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image2 = [UIImage imageWithData:imageData];
    [imageView setImage:image2];
    [profileImage.imageView setImage:image2];
    NSLog(@"logging");
    //NSString *string = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", imageData);
    if (imageData == nil){
        NSLog(@"hi");
        UIImage *def_image = [UIImage imageNamed:@"new_report_def.jpg"];
        [imageView setImage:def_image];
    }

    [profileImage.layer setCornerRadius:50];
    [profileImage.layer setMasksToBounds:YES];
    
    [imageView.layer setMasksToBounds:YES];
    [imageView.layer setCornerRadius:50];
    
   // NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    
   // NSString *documentsDirectory = [paths objectAtIndex:0];
   // NSString *filePath;
    
   // filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"profile.jpg"];
  
   // NSData *data1 = [[NSData alloc] initWithContentsOfFile:filePath];
   // imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data1]];
    
//          [profileImage setImage:image forState:UIControlStateNormal];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //create header for view controller that says "My Profile"
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    subview.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8]; //set the background color of the title label to royal blue
    
    UILabel *title_label = [[UILabel alloc] init];
    title_label.frame = CGRectMake(0, (subview.frame.size.height/2)-10, subview.frame.size.width, 40);
    title_label.textAlignment = NSTextAlignmentCenter;
    title_label.font = [UIFont fontWithName:@"Noteworthy-Bold" size:24];
    title_label.textColor = [UIColor whiteColor];
    title_label.text = @"My Profile";
    
    UIButton *history_button = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].applicationFrame.size.width-50, 27, 40, 40)];
    //history_button.alpha = .8;
    [history_button addTarget:self action:@selector(historySelected) forControlEvents:UIControlEventTouchUpInside];

    //UIImageView *hist_image_view = [[UIImageView alloc] initWithFrame:CGRectMake(255, 10, 70, 70)];
    //hist_image_view.alpha = .8;
    UIImage *history_image = [UIImage imageNamed:@"history_2.jpg"];
    [history_button setImage:history_image forState:UIControlStateNormal];
    //[subview addSubview:history_button]; COMMENTED OUT BECAUSE THE RIDES HISTORY FEATURE IS NOT YET READY

    
    [subview addSubview:title_label];
    [self.view addSubview:subview];
    
    //header_label.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:1]; //set the background color of the title label to royal blue
    // Do any additional setup after loading the view.
    
    _titleLabel.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:1]; //set the background color of the title label to royal blue
    
    /*
    _update_profile.layer.shadowColor = [UIColor blackColor].CGColor;
    _update_profile.layer.shadowOffset = CGSizeMake(7.0, 7.0);
    _update_profile.layer.shadowOpacity = 0.9;
    _update_profile.layer.shadowRadius = 5.0;

    _update_profile.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:1]; //set the background color of the "update" button to royal blue
    */
    
    [[_update_profile layer] setBorderWidth:3.0f];
    [[_update_profile layer] setBorderColor:[UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8].CGColor];
    [[_update_profile layer] setCornerRadius:5];
    [[_update_profile layer] setMasksToBounds:YES];
    _update_profile.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
    [_update_profile setTitleColor:[UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8] forState:UIControlStateNormal];
    
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 50;
    
//    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
//    NSString *docDirectory = [sysPaths objectAtIndex:0];
//    NSString *filePath = [NSString stringWithFormat:@"%@/profile_pic.jpg", docDirectory];
//    imageView.image = [[UIImage alloc] initWithContentsOfFile:filePath];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)historySelected{
    NSLog(@"in history selected");
    [self performSegueWithIdentifier:@"viewHistory" sender:self];
}

-(NSString *)docsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

- (IBAction)update_profile:(id)sender {
    NSLog(@"update pressed.....");
    NSMutableDictionary *myDict = [[NSMutableDictionary alloc] init];
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if(fileExists){
        myDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
    }
    
    NSString *userID = [myDict objectForKey:@"onlineCode"];
    
    //this grabs the image and makes it a 90% quality jpeg
    NSData *imageData = UIImageJPEGRepresentation(image, 90);
    
    //this saves the image file internally to the documents directory of the phone/app
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask,YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    [imageData writeToFile:[basePath stringByAppendingPathComponent:@"profile_pic.jpg"] atomically:YES];
    
    NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/upload_image.php?internetcode=";
    
    NSString *urlString1 = [urlString stringByAppendingString:userID];
    NSString *urlString2 = [urlString1 stringByAppendingString:@"&firstname="];
    NSString *urlString3 = [urlString2 stringByAppendingString:f_name_label.text];
    NSString *urlString4 = [urlString3 stringByAppendingString:@"&lastname="];
    NSString *urlString5 = [urlString4 stringByAppendingString:l_name_label.text];
    NSString *urlString6 = [urlString5 stringByAppendingString:@"&phone="];
    NSString *urlString7 = [urlString6 stringByAppendingString:phone_label.text];
    NSString *urlString8 = [urlString7 stringByAppendingString:@"&email="];
    NSString *urlString9 = [urlString8 stringByAppendingString:email_label.text];
    NSString *urlString10 = [urlString9 stringByAppendingString:@"&car="];
    NSString *urlString11 = [urlString10 stringByAppendingString:car_label.text];
 
    //add any vars using stringbyappendingstring prior to upload
    
    NSString *urlString22 = [urlString11 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString22]];
    NSLog(@"url= %@",urlString22);
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
            NSLog(@"TESTING");
            UIAlertView *alertView7 = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your profile has been added." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView7 show];
            
            [myDict setObject:f_name_label.text forKey:@"firstname"];
            [myDict setObject:l_name_label.text forKey:@"lastname"];
            [myDict setObject:car_label.text forKey:@"car"];
            [myDict setObject:phone_label.text forKey:@"cellNumber"];
            
            
            //NSString *filePath = [NSString stringWithFormat:@"%@/%@",
                        //documentsDirectory, @"profile.jpg"];
            //[imageData writeToFile:filePath atomically:YES];
            
            [myDict writeToFile:user_info atomically:YES];
            
            //UIAlertView *alertView7 = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your profile has been added." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            //[alertView7 show];
            
        }else{
            UIAlertView *alertView7 = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Your image failed to upload." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView7 show];
        }
    }else{
        NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString22] encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"return string = %@",returnString);
        if([returnString isEqualToString:@"success1"]){
            NSLog(@"TESTING");
            
            [myDict setObject:f_name_label.text forKey:@"firstname"];
            [myDict setObject:l_name_label.text forKey:@"lastname"];
            [myDict setObject:car_label.text forKey:@"car"];
            NSLog(@"car value: %@", car_label.text);
            [myDict setObject:phone_label.text forKey:@"cellNumber"];
           
            [myDict writeToFile:user_info atomically:YES];
            
            UIAlertView *alertView100 = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your profile has been added." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView100 show];
        }

    }
    
}

/*- (IBAction)sign_out_user:(id)sender {
    
}

- (IBAction)done_editing:(id)sender{
    
}*/

-(IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


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
        imageView.image=image;
//        profileImage.imageView.image=image;
        [profileImage setImage:image forState:UIControlStateNormal];
        if(newMedia){
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
        }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
            //video is not supported
        }
    }
    
//    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
//    NSString *docDirectory = [sysPaths objectAtIndex:0];
//    NSString *filePath = [NSString stringWithFormat:@"%@/profile_pic.jpg", docDirectory];
    NSData *imageData = UIImageJPEGRepresentation(image, 90);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"profile.jpg"];
    [imageData writeToFile:filePath atomically:YES];
//    [imageView setImage:image];
//    [profileImage.imageView setImage:image];
    
    [imageView.layer setMasksToBounds:YES];
    [imageView.layer setCornerRadius: 50];
    
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


@end
