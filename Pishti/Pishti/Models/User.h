//
//  User.h
//  Pishti
//
//  Created by Alperen Kavun on 30/03/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

#pragma mark - Properties

@property   NSInteger   userId;
@property   NSString*   fullName;
@property   NSString*   email;
@property   NSString*   gender;
@property   NSString*   passHash;

#pragma mark - Class Methods

+ (User*)   CreateUserWithDictionary:(NSDictionary*)dictionary;

@end
