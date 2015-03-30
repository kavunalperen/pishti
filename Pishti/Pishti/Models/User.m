//
//  User.m
//  Pishti
//
//  Created by Alperen Kavun on 30/03/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "User.h"

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
        
        NSInteger userId = [[dictionary objectForKey:@"id"] integerValue];
        NSString* fullName = [dictionary objectForKey:@"full_name"];
        NSString* email = [dictionary objectForKey:@"email"];
        NSString* gender = [dictionary objectForKey:@"gender"];
        NSString* passHash = [dictionary objectForKey:@"pass_hash"];
        
        self.userId = userId;
        self.fullName = fullName;
        self.email = email;
        self.gender = gender;
        self.passHash = passHash;
    }
    
    return self;
}

@end

