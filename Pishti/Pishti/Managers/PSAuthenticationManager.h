//
//  PSAuthenticationManager.h
//  Pishti
//
//  Created by Alperen Kavun on 30/03/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AUTHENTICATED_USER_DICTIONARY_KEY @"kAuthenticatedUserDictionary"
#define AUTHENTICATION_TOKEN_KEY @"kAuthenticationToken"

@class User;

@interface PSAuthenticationManager : NSObject

#pragma mark - Properties

@property BOOL isAuthenticated;

#pragma mark - Class Methods

+ (PSAuthenticationManager*) sharedInstance;

#pragma mark - Instance Methods

- (void) checkAuthentication;

- (User*) getAuthenticatedUser;
- (NSString*) getTokenForAuthenticatedUser;

- (void) clearAuthenticatedUserData;

- (BOOL) signupWithEmail:(NSString*)email
             andPassword:(NSString*)password
               andGender:(NSString*)gender
             andFullName:(NSString*)fullName;

- (void) logout;

- (void) closeLoginView;

@end
