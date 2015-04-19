//
//  PSAuthenticationManager.m
//  Pishti
//
//  Created by Alperen Kavun on 30/03/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "PSAuthenticationManager.h"
#import "User.h"
#import "PSLoginView.h"
#import "PSCommons.h"
#import "PSAppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
#import "PSAddressView.h"
#import "PSProfileInfoView.h"

static PSAuthenticationManager* __sharedInstance = nil;

@implementation PSAuthenticationManager
{
    User* authenticatedUser;
    PSLoginView* loginView;
}
#pragma mark - Class Methods

+ (PSAuthenticationManager*) sharedInstance
{
    if (__sharedInstance == nil) {
        __sharedInstance = [[PSAuthenticationManager alloc] init];
        __sharedInstance.isAuthenticated = NO;
        [[NSNotificationCenter defaultCenter] addObserver:__sharedInstance selector:@selector(addressUpdateCompleted) name:AddressOperationCompletedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:__sharedInstance selector:@selector(profileUpdateCompleted) name:ProfileInfoUpdateCompletedNotification object:nil];
    }
    
    return __sharedInstance;
}

#pragma mark - Instance Methods

- (void) checkAuthentication
{
    NSString* token = [self getTokenForAuthenticatedUser];
    if (token != nil && ![token isEqualToString:@""]) {
        self.isAuthenticated = YES;
        [self getAuthenticatedUser];
        return;
    } else {
        // facebook login dialog etc..
        loginView = [[PSLoginView alloc] initWithFrame:SCREEN_FRAME];
        [((PSAppDelegate*)([UIApplication sharedApplication].delegate)).window addSubview:loginView];
    }
}
- (void) addressUpdateCompleted
{
    if (authenticatedUser != nil) {
        [self saveAuthenticatedUserDictionary:[authenticatedUser getUserDictionary]];
    }
}
- (void) profileUpdateCompleted
{
    if (authenticatedUser != nil) {
        [self saveAuthenticatedUserDictionary:[authenticatedUser getUserDictionary]];
    }
}
- (void) closeLoginView
{
    [loginView removeFromSuperview];
    loginView = nil;
}

- (BOOL) signupWithEmail:(NSString*)email
             andPassword:(NSString*)password
               andGender:(NSString*)gender
             andFullName:(NSString*)fullName
{
    NSDictionary* userDict = @{@"id":[NSNumber numberWithInteger:[[NSDate new] timeIntervalSince1970]],
                               @"full_name":fullName,
                               @"email":email,
                               @"gender":gender,
                               @"password":password};
    
    User* user = [User CreateUserWithDictionary:userDict];
    if (user) {
        [self saveAuthenticatedUserDictionary:userDict];
        [self saveTokenForAuthenticatedUser:[NSString stringWithFormat:@"auth_token:%f",[[NSDate new] timeIntervalSince1970]]];
        [self getAuthenticatedUser];
        return YES;
    } else {
        return NO;
    }
}
-(NSString*) sha1:(NSString*)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
- (NSString*) getTokenForAuthenticatedUser
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:AUTHENTICATION_TOKEN_KEY];
}
- (void) saveTokenForAuthenticatedUser:(NSString*)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:AUTHENTICATION_TOKEN_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSDictionary*) getAuthenticatedUserDictionary
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:AUTHENTICATED_USER_DICTIONARY_KEY];
}
- (void) saveAuthenticatedUserDictionary:(NSDictionary*)dictionary
{
    [[NSUserDefaults standardUserDefaults] setObject:dictionary forKey:AUTHENTICATED_USER_DICTIONARY_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (User*) getAuthenticatedUser
{
    if (authenticatedUser == nil) {
        NSDictionary* dictionary = [self getAuthenticatedUserDictionary];
        if (dictionary != nil) {
            authenticatedUser = [User CreateUserWithDictionary:dictionary];
        }
    }
    
    return authenticatedUser;
}

- (void)logout
{
    [self clearAuthenticatedUserData];
    [self checkAuthentication];
}

- (void) clearAuthenticatedUserData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:AUTHENTICATION_TOKEN_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:AUTHENTICATED_USER_DICTIONARY_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.isAuthenticated = NO;
    authenticatedUser = nil;
}

@end
