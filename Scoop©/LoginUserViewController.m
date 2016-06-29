//
//  Scoop©
//  Sam Borowsky
//  LoginUserViewController.m
//  The implementation file for the log in/register view controller
//  01.29.2015
//

#import "LoginUserViewController.h"

@interface LoginUserViewController ()

@end

@implementation LoginUserViewController //Interface is LoginUserViewController.h
@synthesize internalCode;

-(NSString *)docsDir{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//need to know when the page comes back to life
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];

    //create header for view controller that says "Welcome To Scoop"
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
    subview.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8]; //set the background color of the title label to royal blue
    
    UILabel *title_label = [[UILabel alloc] init];
    title_label.frame = CGRectMake(0, (subview.frame.size.height/2)-10, subview.frame.size.width, 40);
    title_label.textAlignment = NSTextAlignmentCenter;
    title_label.font = [UIFont fontWithName:@"Noteworthy-Bold" size:24];
    title_label.textColor = [UIColor whiteColor];
    title_label.text = @"Welcome To Scoop";
    
    [subview addSubview:title_label];
    [self.view addSubview:subview];
    
    // Do any additional setup after loading the view, typically from a nib.
    _loginBtn.hidden=true;
    NSLog(@"hiding cover plate");
    coverPlate.hidden=true;
    
    //styling the "Sign Up" button
    [[_registerBtn layer] setBorderWidth:3.0f];
    [[_registerBtn layer] setBorderColor:[UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8].CGColor];
    [[_registerBtn layer] setCornerRadius:5];
    [[_registerBtn layer] setMasksToBounds:YES];
    _registerBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:22.0f];
    [_registerBtn setTitleColor:[UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:.8] forState:UIControlStateNormal];
    
    _welcomeLabel.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(35/255.0) blue:(102/255.0) alpha:1]; //set the background color of the welcome label to royal blue
    
    
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    NSLog(@"did become active notification");
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if(fileExists){
        NSMutableDictionary *myDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
        int hasLength = (int)[myDict count];
        //NSString *strFromInt = [NSString stringWithFormat:@"%d",your];
        NSLog(@"hasLength=%@",myDict);
        //if the file has length, then check for key @"onlineCode"
        if(hasLength>0){
            //if the online code exists, then move to the next page
            NSLog(@"got past has length");
            
            NSLog(@"onlineCode = %@", [myDict objectForKey:@"onlineCode"]);
            
            int lenDict=(int)[[myDict objectForKey:@"onlineCode"] length];
            // if(lenDict>0){
            NSLog(@"lenOnlineCode = %i",lenDict);
            if(lenDict > 0){
                [self performSegueWithIdentifier:@"segue11" sender:self];
            }else{
                //if the code does not exist, go check the internet for it based on the uniquePhone id
                //put an ImageView over everything that says, "waiting for email confirmation"
                coverPlate.hidden=false;
                
                NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/check_registration.php?idstring=";
                NSString *urlString2 = [urlString stringByAppendingString:[myDict objectForKey:@"phoneCode"]];
                NSString *urlString3 = [urlString2 stringByAppendingString:@"&email="];
                NSString *urlString4 = [urlString3 stringByAppendingString:[myDict objectForKey:@"email"]];
                NSString *urlString9 = [urlString4 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSLog(@"outbound http = %@",urlString9);
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                [request setURL:[NSURL URLWithString:urlString9]];
                [request setHTTPMethod:@"GET"];
                NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString9] encoding:NSUTF8StringEncoding error:nil];
                NSLog(@"return string = %@",returnString);
                //partition the return string
                NSArray *returnArray=[returnString componentsSeparatedByString:@"##"];
                if([returnArray[0] isEqualToString:@"success"]){
                    int retArray1 = (int)[returnArray[1] length];
                    NSLog(@"ret array 1 = %i",retArray1);
                    if(retArray1>0){
                        NSLog(@"return array [1], %@",returnArray[1]);
                        [myDict setObject:returnArray[1] forKey:@"onlineCode"];
                        [myDict writeToFile:user_info atomically:YES];
                     NSLog(@"myDict = %@",myDict);
                        [self performSegueWithIdentifier:@"segue11" sender:self];
                    }
                }
            }
        }
    }
}


-(void)viewDidAppear:(BOOL)animated{
        [super viewDidAppear:YES];
    
    //[self performSegueWithIdentifier:@"segue11" sender:self];
    
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if(fileExists){
        NSMutableDictionary *myDict = [[NSMutableDictionary alloc] initWithContentsOfFile:user_info];
        int hasLength = (int)[myDict count];
        //NSString *strFromInt = [NSString stringWithFormat:@"%d",your];
        NSLog(@"hasLength=%@",myDict);
        //if the file has length, then check for key @"onlineCode"
        if(hasLength>0){
            //if the online code exists, then move to the next page
            NSLog(@"got past has length");
            
            NSLog(@"onlineCode = %@", [myDict objectForKey:@"onlineCode"]);
            
            int lenDict=(int)[[myDict objectForKey:@"onlineCode"] length];
           // if(lenDict>0){
            NSLog(@"lenOnlineCode = %i",lenDict);
            if(lenDict > 0){
                [self performSegueWithIdentifier:@"segue11" sender:self];
            }else{
                //if the code does not exist, go check the internet for it based on the uniquePhone id
                //put an ImageView over everything that says, "waiting for email confirmation"
                coverPlate.hidden=false;
                
                NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/check_registration.php?idstring=";
                NSString *urlString2 = [urlString stringByAppendingString:[myDict objectForKey:@"phoneCode"]];
                NSString *urlString3 = [urlString2 stringByAppendingString:@"&email="];
                NSString *urlString4 = [urlString3 stringByAppendingString:[myDict objectForKey:@"email"]];
                NSString *urlString9 = [urlString4 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSLog(@"outbound http = %@",urlString9);
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                [request setURL:[NSURL URLWithString:urlString9]];
                [request setHTTPMethod:@"GET"];
                NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString9] encoding:NSUTF8StringEncoding error:nil];
                NSLog(@"return string = %@",returnString);
                //partition the return string
                NSArray *returnArray=[returnString componentsSeparatedByString:@"##"];
                if([returnArray[0] isEqualToString:@"success"]){
                    int retArray1 = (int)[returnArray[1] length];
                    NSLog(@"ret array 1 = %i",retArray1);
                        if(retArray1>0){
                            NSLog(@"return array [1], %@",returnArray[1]);
                            [myDict setObject:returnArray[1] forKey:@"onlineCode"];
                            [myDict writeToFile:user_info atomically:YES];
                            NSLog(@"myDict = %@",myDict);
                            [self performSegueWithIdentifier:@"segue11" sender:self];
                        }
                }
            }
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)registerUser:(id)sender {
    
    //set up the registration bypass for the app evaluator
    if ([_emailField.text isEqualToString:@"demo@scoop.com"]){
        
        NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
        
        //write the username and password and set BOOL value in NSUserDefaults
        
        //if the file does not exist, make it
        if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
            [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
        }
        
        //check if the file exists just to be sure because you do not want to perform actions on a non-existent file
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
        if (fileExists){
            //make an array to hold multiple dictionaries of info. We are only holding one here, but it is
            //easy to expand arrays to hold more rows of data e.g., customers
            //NSMutableArray *temp_array = [[NSMutableArray alloc] init];
            //make a temporary dictionary for the username and password values
            
            
            //send all of this to the internet and if successful, put it in the file
            //otherwise, tell them they need internet access
            [self createRandomCode];
            
            NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/confirm_email.php?confirmCode=";
            NSString *reCode = [NSString stringWithFormat:@"%i",(int)internalCode];
            NSString *urlString2 = [urlString stringByAppendingString:reCode];
            NSString *urlString3 = [urlString2 stringByAppendingString:@"&email="];
            NSString *urlString4 = [urlString3 stringByAppendingString:_emailField.text];
            NSString *urlString5 = [urlString4 stringByAppendingString:@"&firstname="];
            NSString *urlString6 = [urlString5 stringByAppendingString:_firstNameField.text];
            NSString *urlString7 = [urlString6 stringByAppendingString:@"&lastname="];
            NSString *urlString8 = [urlString7 stringByAppendingString:_lastNameField.text];
            NSString *urlString9 = [urlString8 stringByAppendingString:@"&cell="];
            NSString *urlString10 = [urlString9 stringByAppendingString:_cellField.text];
            //I TOOK THIS OUT BECUASE YOUR PASSENGERS SHOULD NOT FEEL THAT THEY NEED TO REGISTER A CAR
            // NSString *urlString11 = [urlString10 stringByAppendingString:@"&car="];
            // NSString *urlString12 = [urlString11 stringByAppendingString:_carModelField.text];
            
            
            NSString *urlString13 = [urlString10 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"outbound http = %@",urlString13);
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:urlString13]];
            [request setHTTPMethod:@"GET"];
            NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString13] encoding:NSUTF8StringEncoding error:nil];
            NSLog(@"return string = %@",returnString);
            
            if([returnString isEqualToString:@"success"]){
                
                NSMutableDictionary *temp_dict = [[NSMutableDictionary alloc] init];
                //obtain the username and password values and enter them into the dictionary
                
                NSString *internalCode2 = [NSString stringWithFormat:@"%i",(int)internalCode];
                
                [temp_dict setObject: _firstNameField.text forKey:@"firstName"];
                [temp_dict setObject: _lastNameField.text forKey:@"lastName"];
                [temp_dict setObject: _emailField.text forKey:@"email"];
                [temp_dict setObject: _cellField.text forKey:@"cellNumber"];
                [temp_dict setObject: internalCode2 forKey:@"phoneCode"];
                [temp_dict setObject:@"" forKey:@"car"];
                [temp_dict setObject: @"19443920520" forKey:@"onlineCode"];
                [temp_dict setObject: @"Off" forKey:@"scoopUp"]; //new
                [temp_dict setObject:[[NSMutableArray alloc] init] forKey:@"liked_reports"];
                [temp_dict setObject: [NSMutableArray arrayWithObjects:@"heada16@mail.wlu.edu", @"yacoubiana16@mail.wlu.edu", nil] forKey:@"ridesReceived"];
                //add this dictionary info into the temporary array
                //[temp_array addObject:temp_dict];
                //write the temporary array to the file (i.e., store it internally on the phone)
                [temp_dict writeToFile:user_info atomically:YES];
                
                NSLog(@"has reached segue bypass....");
                
                [self performSegueWithIdentifier:@"segue11" sender:self];
                return;
            }
        }
    }
    
    //check if all text fields are completed
    if ([_firstNameField.text isEqualToString:@""] || [_lastNameField.text isEqualToString:@""] ||[_emailField.text isEqualToString:@""] || [_reEnterEmailField.text isEqualToString:@""]) {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You must complete all fields" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [error show];
    }else {
        [self checkEmailMatch];
    }
}

- (void) checkEmailMatch {
    
    //check that the two email fields are identical
    if ([_emailField.text isEqualToString:_reEnterEmailField.text]) {
        NSLog(@"email match!");
        //if the emails are identical, then make sure it is a .edu address
        [self checkEmailIsEDU];
    }
    else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Your entered emails do not match" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
}

-(void)checkEmailIsEDU{
    NSString *eduCheck = _emailField.text;
    int endRange = (int)[eduCheck length];
    int startRange = endRange-4;
    NSString *eduCheck2 = [eduCheck substringWithRange: NSMakeRange(startRange,4)];
    NSLog(@"educheck = %@", eduCheck2);
    if([eduCheck2 isEqualToString:@".edu"]){
        //begin the registration process online and create an alert saying check your email
        [self registerNewUser];
    }else{
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"For the security of our members your email address must end in .edu to use this app." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [error show];
    }
}

- (void) registerNewUser {
    
    
    NSString *user_info = [[self docsDir] stringByAppendingPathComponent:@"my_profile.plist"];
    
    //write the username and password and set BOOL value in NSUserDefaults
    
    //if the file does not exist, make it
    if(![[NSFileManager defaultManager]fileExistsAtPath:user_info]){
        [[NSFileManager defaultManager] copyItemAtPath:[[NSBundle mainBundle]pathForResource:@"my_profile" ofType:@"plist"] toPath:user_info error:nil];
    }
    
    //check if the file exists just to be sure because you do not want to perform actions on a non-existent file
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:user_info];
    if (fileExists){
        //make an array to hold multiple dictionaries of info. We are only holding one here, but it is
        //easy to expand arrays to hold more rows of data e.g., customers
        //NSMutableArray *temp_array = [[NSMutableArray alloc] init];
        //make a temporary dictionary for the username and password values
        
        
        //send all of this to the internet and if successful, put it in the file
        //otherwise, tell them they need internet access
        [self createRandomCode];
        
        NSString *urlString = @"http://www.dubyuhnellapps.com/team_folders/scoop/confirm_email.php?confirmCode=";
        NSString *reCode = [NSString stringWithFormat:@"%i",(int)internalCode];
        NSString *urlString2 = [urlString stringByAppendingString:reCode];
        NSString *urlString3 = [urlString2 stringByAppendingString:@"&email="];
        NSString *urlString4 = [urlString3 stringByAppendingString:_emailField.text];
        NSString *urlString5 = [urlString4 stringByAppendingString:@"&firstname="];
        NSString *urlString6 = [urlString5 stringByAppendingString:_firstNameField.text];
        NSString *urlString7 = [urlString6 stringByAppendingString:@"&lastname="];
        NSString *urlString8 = [urlString7 stringByAppendingString:_lastNameField.text];
        NSString *urlString9 = [urlString8 stringByAppendingString:@"&cell="];
        NSString *urlString10 = [urlString9 stringByAppendingString:_cellField.text];
        //I TOOK THIS OUT BECUASE YOUR PASSENGERS SHOULD NOT FEEL THAT THEY NEED TO REGISTER A CAR
       // NSString *urlString11 = [urlString10 stringByAppendingString:@"&car="];
       // NSString *urlString12 = [urlString11 stringByAppendingString:_carModelField.text];
        
        
        NSString *urlString13 = [urlString10 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"outbound http = %@",urlString13);
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:urlString13]];
        [request setHTTPMethod:@"GET"];
        NSString *returnString = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:urlString13] encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"return string = %@",returnString);
        
        if([returnString isEqualToString:@"success"]){
            
            NSMutableDictionary *temp_dict = [[NSMutableDictionary alloc] init];
            //obtain the username and password values and enter them into the dictionary
            
            NSString *internalCode2 = [NSString stringWithFormat:@"%i",(int)internalCode];
            
            [temp_dict setObject: _firstNameField.text forKey:@"firstName"];
            [temp_dict setObject: _lastNameField.text forKey:@"lastName"];
            [temp_dict setObject: _emailField.text forKey:@"email"];
            [temp_dict setObject: _cellField.text forKey:@"cellNumber"];
            [temp_dict setObject: internalCode2 forKey:@"phoneCode"];
            [temp_dict setObject:@"" forKey:@"car"];
            [temp_dict setObject: @"" forKey:@"onlineCode"];
            [temp_dict setObject: @"Off" forKey:@"scoopUp"]; //new
            [temp_dict setObject:[[NSMutableArray alloc] init] forKey:@"liked_reports"];
            //add this dictionary info into the temporary array
            //[temp_array addObject:temp_dict];
            //write the temporary array to the file (i.e., store it internally on the phone)
            [temp_dict writeToFile:user_info atomically:YES];
            
            coverPlate.hidden=false;
            _emailField.enabled=false;
            _firstNameField.enabled=false;
            _lastNameField.enabled=false;
            _cellField.enabled=false; //show Fox
            _emailField.hidden=true;
            _firstNameField.hidden=true;
            _lastNameField.hidden=true;
            _loginBtn.hidden=true;
            
            UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Go to your email and click the confirmation link in it. Then, once you restart the app, you will have access." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [success show];
        }else{
            UIAlertView *success = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You must be connected to the Internet for us to email you the confirmation code generated by your phone." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [success show];
        }
    } //end the "if file exists" statement
}


// Dismiss the keyboard when the user taps the background
- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

-(void)createRandomCode{
    internalCode=arc4random_uniform(1000000000000);
    
    NSLog(@"internal code = %i",(int)internalCode);
}

@end


