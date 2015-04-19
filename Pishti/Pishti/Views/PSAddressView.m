//
//  PSAddressView.m
//  Pishti
//
//  Created by Alperen Kavun on 18/04/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "PSAddressView.h"
#import "PSCommons.h"
#import "PSLoginTextField.h"
#import "Util.h"
#import "User.h"
#import "PSAuthenticationManager.h"

@implementation PSAddressView
{
    NSDictionary* updatedAddress;
    
    PSLoginTextField* addressTitleField;
    PSLoginTextField* addressField;
    
    PSLoginTextField* addressCityField;
    PSLoginTextField* addressCountyField;
    
    UIButton* button;
}

- (CGRect) addressHolderFrame
{
    return CGRectMake(0.0, 0.0, 678.0, 105.0);
}

- (CGRect) addressTitleFrame
{
    return CGRectMake(9.0, 9.0, 210.0, 38.0);
}
- (CGRect) addressFrame
{
    return CGRectMake(228.0, 9.0, 440.0, 38.0);
}
- (CGRect) addressCityFrame
{
    return CGRectMake(9.0, 56.0, 220.0, 38.0);
}
- (CGRect) addressCountyFrame
{
    return CGRectMake(238.0, 56.0, 220.0, 38.0);
}
- (CGRect) buttonFrame
{
    return CGRectMake(467.0, 56.0, 202.0, 38.0);
}
- (id) initWithAddress:(NSDictionary*)address
{
    if (self = [super init]) {
        if (address != nil) {
            updatedAddress = [NSDictionary dictionaryWithDictionary:address];
        }
        [self initialSetups];
        
        if (updatedAddress) {
            [self configureForUpdatedAddress];
        }
    }
    
    return self;
}

- (void) initialSetups
{
    self.frame = SCREEN_FRAME;
    self.backgroundColor = LOGIN_VIEW_OVERLAY_COLOR;
    
    UIView* addressHolder = [[UIView alloc] initWithFrame:[self addressHolderFrame]];
    addressHolder.center = self.center;
    addressHolder.backgroundColor = [UIColor whiteColor];
    [self addSubview:addressHolder];
    
    addressTitleField = [[PSLoginTextField alloc] initWithFrame:[self addressTitleFrame]];
    addressTitleField.placeholder = @"Adres Başlığı";
    addressTitleField.font = ADDRESS_VIEW_FONTS;
    [addressHolder addSubview:addressTitleField];
    
    addressField = [[PSLoginTextField alloc] initWithFrame:[self addressFrame]];
    addressField.placeholder = @"Adres";
    addressField.font = ADDRESS_VIEW_FONTS;
    [addressHolder addSubview:addressField];
    
    addressCityField = [[PSLoginTextField alloc] initWithFrame:[self addressCityFrame]];
    addressCityField.placeholder = @"İl";
    addressCityField.font = ADDRESS_VIEW_FONTS;
    [addressHolder addSubview:addressCityField];
    
    addressCountyField = [[PSLoginTextField alloc] initWithFrame:[self addressCountyFrame]];
    addressCountyField.placeholder = @"İlçe";
    addressCountyField.font = ADDRESS_VIEW_FONTS;
    [addressHolder addSubview:addressCountyField];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = [self buttonFrame];
    button.titleLabel.font = PROFILE_VIEW_UPDATE_BUTTON_FONT;
    [button setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:PROFILE_VIEW_UPDATE_BUTTON_NORMAL_COLOR] forState:UIControlStateNormal];
    [button setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:PROFILE_VIEW_UPDATE_BUTTON_HIGHLIGHTED_COLOR] forState:UIControlStateHighlighted];
    [button setTitleColor:PROFILE_VIEW_UPDATE_BUTTON_TITLE_NORMAL_COLOR forState:UIControlStateNormal];
    [button setTitleColor:PROFILE_VIEW_UPDATE_BUTTON_TITLE_HIGHLIGHTED_COLOR forState:UIControlStateHighlighted];
    [button setTitle:@"EKLE" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [addressHolder addSubview:button];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    [self addGestureRecognizer:tapGesture];
    
}

- (void) configureForUpdatedAddress
{
    addressTitleField.text = [updatedAddress objectForKey:@"addressTitle"];
    addressField.text = [updatedAddress objectForKey:@"address"];
    addressCityField.text = [updatedAddress objectForKey:@"addressCity"];
    addressCountyField.text = [updatedAddress objectForKey:@"addressCounty"];
    
    [button setTitle:@"GÜNCELLE" forState:UIControlStateNormal];
}

- (void) buttonClicked
{
    User* user = [[PSAuthenticationManager sharedInstance] getAuthenticatedUser];
    
    NSNumber* addressId = [updatedAddress objectForKey:@"id"];
    NSString* addressTitle = addressTitleField.text;
    NSString* address = addressField.text;
    NSString* addressCity = addressCityField.text;
    NSString* addressCounty = addressCountyField.text;
    
    if (addressTitle == nil || [addressTitle isEqualToString:@""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hata"
                                                            message:@"Lütfen adres başlığını giriniz."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Tamam"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    } else if (address == nil || [address isEqualToString:@""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hata"
                                                            message:@"Lütfen adresinizi giriniz."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Tamam"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    } else if (addressCity == nil || [addressCity isEqualToString:@""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hata"
                                                            message:@"Lütfen adres ilini giriniz."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Tamam"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    } else if (addressCounty == nil || [addressCounty isEqualToString:@""]) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hata"
                                                            message:@"Lütfen adres ilçesini giriniz."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Tamam"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        if (updatedAddress) {
            NSDictionary* dictionary = @{@"id":addressId,
                                         @"addressTitle":addressTitle,
                                         @"address":address,
                                         @"addressCity":addressCity,
                                         @"addressCounty":addressCounty};
            [user updateAddressWithDictionary:dictionary];
        } else {
            
            
            
            NSInteger addressIdI = [user getNewAddressId];
            
            NSDictionary* dictionary = @{@"id":[NSNumber numberWithInteger:addressIdI],
                                         @"addressTitle":addressTitle,
                                         @"address":address,
                                         @"addressCity":addressCity,
                                         @"addressCounty":addressCounty};
            [user addAddressWithDictionary:dictionary];
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:AddressOperationCompletedNotification object:nil];
    }
}

- (void) tapped
{
    [[NSNotificationCenter defaultCenter] postNotificationName:AddressOperationCanceledNotification object:nil];
}

@end
