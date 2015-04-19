//
//  User.m
//  Pishti
//
//  Created by Alperen Kavun on 30/03/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "User.h"
#import "Util.h"

@implementation User

#pragma mark - Class Methods

+ (User*) CreateUserWithDictionary:(NSDictionary*)dictionary
{
    return [[User alloc] initWithDictionary:dictionary];
}

#pragma mark - Instance Methods

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    if (self = [super init]) {
        
        NSInteger           userId      =   [[dictionary objectForKey:@"id"] integerValue];
        NSString*           fullName    =   [dictionary objectForKey:@"full_name"];
        NSString*           email       =   [dictionary objectForKey:@"email"];
        NSString*           phone       =   [dictionary objectForKey:@"phone"];
        NSString*           gender      =   [dictionary objectForKey:@"gender"];
        NSDate*             birthdate   =   [dictionary objectForKey:@"birthdate"];
        NSString*           city        =   [dictionary objectForKey:@"city"];
        NSString*           password    =   [dictionary objectForKey:@"password"];
        NSMutableArray*     addresses   =   [NSMutableArray arrayWithArray:[dictionary objectForKey:@"addresses"]];
        
        self.userId         =   userId;
        self.fullName       =   fullName;
        self.email          =   email;
        self.phone          =   phone;
        self.gender         =   gender;
        self.birthdate      =   birthdate;
        self.city           =   city;
        self.password       =   password;
        
        self.addresses      =   addresses ? addresses:@[].mutableCopy;
        
        self.addressCounter =   self.addresses.count;
    }
    
    return self;
}
- (NSDictionary*)   getUserDictionary
{
    NSMutableDictionary* userDictionary = @{}.mutableCopy;
    
    [userDictionary setObject:[NSNumber numberWithInteger:self.userId] forKey:@"id"];
    
    if (self.fullName) {
        [userDictionary setObject:self.fullName forKey:@"full_name"];
    }
    if (self.email) {
        [userDictionary setObject:self.email forKey:@"email"];
    }
    if (self.phone) {
        [userDictionary setObject:self.phone forKey:@"phone"];
    }
    if (self.gender) {
        [userDictionary setObject:self.gender forKey:@"gender"];
    }
    if (self.birthdate) {
        [userDictionary setObject:self.birthdate forKey:@"birthdate"];
    }
    if (self.city) {
        [userDictionary setObject:self.city forKey:@"city"];
    }
    if (self.password) {
        [userDictionary setObject:self.password forKey:@"password"];
    }
    if (self.addresses) {
        [userDictionary setObject:self.addresses forKey:@"addresses"];
    }
    
    return userDictionary;
}
- (void) addAddressWithDictionary:(NSDictionary*)dictionary
{
    [self.addresses addObject:dictionary];
    self.addressCounter += 1;
}
- (void) updateAddressWithDictionary:(NSDictionary*)dictionary
{
    NSInteger index = [[dictionary objectForKey:@"id"] integerValue];
    [self.addresses setObject:dictionary atIndexedSubscript:index];
}

- (NSInteger) getNewAddressId
{
    return self.addressCounter;
}

- (NSString*) getUserLastName
{
    NSArray* nameComponenets = [self.fullName componentsSeparatedByString:@" "];
    return [nameComponenets lastObject];
}
- (NSString*) getUserFirstName
{
    NSMutableArray* nameComponents = [self.fullName componentsSeparatedByString:@" "].mutableCopy;
    [nameComponents removeObject:nameComponents.lastObject];
    return [nameComponents componentsJoinedByString:@" "];
}
- (NSString*) getUserGender
{
    if ([self isFemale]) {
        return @"Kadın";
    } else {
        return @"Erkek";
    }
}
- (BOOL) isFemale
{
    if ([self.gender isEqualToString:@"male"]) {
        return NO;
    } else {
        return YES;
    }
}
- (void) setIsFemale:(BOOL)isFemale
{
    if (isFemale) {
        self.gender = @"female";
    } else {
        self.gender = @"male";
    }
}
- (NSString*) getUserBirthDateString
{
    if (self.birthdate) {
        return [[Util sharedInstance] stringFromDate:self.birthdate];
    }
    return @"";
}
@end

