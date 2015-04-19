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

@property   NSInteger           userId;
@property   NSString*           fullName;
@property   NSString*           email;
@property   NSString*           phone;
@property   NSString*           gender;
@property   NSDate*             birthdate;
@property   NSString*           city;
@property   NSString*           password;
@property   NSMutableArray*     addresses;
@property   NSInteger           addressCounter;

#pragma mark - Class Methods

+ (User*)           CreateUserWithDictionary:(NSDictionary*)dictionary;

- (void)            addAddressWithDictionary:(NSDictionary*)dictionary;
- (void)            updateAddressWithDictionary:(NSDictionary*)dictionary;

- (NSInteger)       getNewAddressId;

- (NSDictionary*)   getUserDictionary;

- (NSString*)       getUserFirstName;
- (NSString*)       getUserLastName;
- (NSString*)       getUserGender;
- (BOOL)            isFemale;
- (void)            setIsFemale:(BOOL)isFemale;
- (NSString*)       getUserBirthDateString;

@end
