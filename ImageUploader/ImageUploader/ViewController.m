//
//  ViewController.m
//  ImageUploader
//
//  Created by Gavin Fox on 3/11/15.
//  Copyright (c) 2015 Merject LLC. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    
    //This loads the profile pic from the document directory once it has been saved
    NSArray *sysPaths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *docDirectory = [sysPaths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/profile_pic.jpg", docDirectory];
    imageView.image = [[UIImage alloc] initWithContentsOfFile:filePath];
    //*****************************************************************************
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backgroundTap:(id)sender{
    [self.view endEditing:YES];
}

-(IBAction)submitImage:(id)sender{
    //this grabs the image and makes it a 90% quality jpeg
    NSData *imageData = UIImageJPEGRepresentation(image, 90);
    
    //this saves the image file internally to the documents directory of the phone/app
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    [imageData writeToFile:[basePath stringByAppendingPathComponent:@"profile_pic.jpg"] atomically:YES];
    
    
    //this is made up and should be replaced
    
    NSString *userID = @"test_user";
    
    NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/upload_image.php?internet_id=";
    NSString *urlString1 = [urlString stringByAppendingString:userID];
    NSString *urlString2 = [urlString1 stringByAppendingString:@"&firstname"];
    NSString *urlString3 = [urlString2 stringByAppendingString:firstname.text];
    NSString *urlString4 = [urlString3 stringByAppendingString:@"&lastname="];
    NSString *urlString5 = [urlString4 stringByAppendingString:lastname.text];
    NSString *urlString6 = [urlString5 stringByAppendingString:@"&phone="];
    NSString *urlString7 = [urlString6 stringByAppendingString:phone.text];
    
    //add any vars using stringbyappendingstring prior to upload
    
    NSString *urlString22 = [urlString7 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
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
            UIAlertView *alertView7 = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Your memory has been added." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView7 show];
           
        }else{
            UIAlertView *alertView7 = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Your image failed to upload." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alertView7 show];
        }
    }
    
}


-(void)useCameraRoll:(id)sender{
    
//    AppDelegate *dataCenter = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    dataCenter.inTheImage=1;
    
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
        if(newMedia){
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
        }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
            //video is not supported
        }
    }
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
