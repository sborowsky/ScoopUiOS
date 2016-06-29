//
//  User.h
//  Scoop©
//
//  Created by Samuel Borowsky on 7/20/15.
//  Copyright (c) 2015 Sam Borowsky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * user_id;
@property (nonatomic, retain) NSString * f_name;
@property (nonatomic, retain) NSString * l_name;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * car;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * photo;

@end
