//
//  PSProfileInfoView.m
//  Pishti
//
//  Created by Alperen Kavun on 18/04/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "PSProfileInfoView.h"
#import "PSCommons.h"
#import "Util.h"
#import "PSLoginTextField.h"
#import "PSAuthenticationManager.h"
#import "User.h"

@implementation PSProfileInfoView
{
    PSLoginTextField* firstNameField;
    PSLoginTextField* lastNameField;
    PSLoginTextField* emailField;
    PSLoginTextField* phoneField;
    
    UILabel* femaleText;
    UILabel* maleText;
    
    UIDatePicker* birthdatePicker;
    PSLoginTextField* birthdateField;
    PSLoginTextField* cityField;
    PSLoginTextField* passwordField;
    
    UIButton* updateButton;
    
    User* user;
    
    BOOL isFemale;
}
- (CGRect) profileInfoHolderFrame
{
    return CGRectMake(0.0, 0.0, 678.0, 150.0);
}

- (CGRect) firstNameFrame
{
    return CGRectMake(9.0, 9.0, 214.0, 38.0);
}

- (CGRect) lastNameFrame
{
    return CGRectMake(232.0, 9.0, 214.0, 38.0);
}

- (CGRect) emailFrame
{
    return CGRectMake(455.0, 9.0, 214.0, 38.0);
}

- (CGRect) phoneFrame
{
    return CGRectMake(9.0, 56.0, 214.0, 38.0);
}

- (CGRect) femaleFrame
{
    return CGRectMake(232.0, 56.0, 102.0, 38.0);
}

- (CGRect) maleFrame
{
    return CGRectMake(344.0, 56.0, 102.0, 38.0);
}

- (CGRect) birtdateFrame
{
    return CGRectMake(455.0, 56.0, 214.0, 38.0);
}

- (CGRect) cityFrame
{
    return CGRectMake(9.0, 103.0, 214.0, 38.0);
}

- (CGRect) passwordFrame
{
    return CGRectMake(232.0, 103.0, 214.0, 38.0);
}

- (CGRect) updateButtonFrame
{
    return CGRectMake(455.0, 103.0, 214.0, 38.0);
}
- (id) init
{
    if (self = [super init]) {
        [self initialSetups];
        [self configureViews];
    }
    
    return self;
}
- (void) configureViews
{
    user = [[PSAuthenticationManager sharedInstance] getAuthenticatedUser];
    
    firstNameField.text = [user getUserFirstName];
    lastNameField.text = [user getUserLastName];
    emailField.text = user.email;
    phoneField.text = user.phone;
    isFemale = [user isFemale];
    [self setGender];
    if (user.birthdate) {
        birthdatePicker.date = user.birthdate;
    }
    birthdateField.text = [user getUserBirthDateString];
    cityField.text = user.city;
    passwordField.text = user.password;
}
- (void) initialSetups
{
    self.frame = SCREEN_FRAME;
    self.backgroundColor = LOGIN_VIEW_OVERLAY_COLOR;
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
    [self addGestureRecognizer:tapGesture];
    
    UIView* profileInfoHolder = [[UIView alloc] initWithFrame:[self profileInfoHolderFrame]];
    profileInfoHolder.center = self.center;
    profileInfoHolder.backgroundColor = [UIColor whiteColor];
    [self addSubview:profileInfoHolder];
    
    firstNameField = [[PSLoginTextField alloc] initWithFrame:[self firstNameFrame]];
    firstNameField.placeholder = @"Ad";
    firstNameField.font = PROFILE_INFO_FONTS;
    [profileInfoHolder addSubview:firstNameField];
    
    lastNameField = [[PSLoginTextField alloc] initWithFrame:[self lastNameFrame]];
    lastNameField.placeholder = @"Soyad";
    lastNameField.font = PROFILE_INFO_FONTS;
    [profileInfoHolder addSubview:lastNameField];
    
    emailField = [[PSLoginTextField alloc] initWithFrame:[self emailFrame]];
    emailField.placeholder = @"E-posta";
    emailField.font = PROFILE_INFO_FONTS;
    [profileInfoHolder addSubview:emailField];
    
    phoneField = [[PSLoginTextField alloc] initWithFrame:[self phoneFrame]];
    phoneField.placeholder = @"Telefon";
    phoneField.font = PROFILE_INFO_FONTS;
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    [profileInfoHolder addSubview:phoneField];
    
    femaleText = [[UILabel alloc] initWithFrame:[self femaleFrame]];
    femaleText.backgroundColor = [UIColor clearColor];
    femaleText.textColor = LOGIN_VIEW_TEXT_FIELDS_PLACEHOLDER_COLOR;
    femaleText.font = PROFILE_INFO_FONTS;
    femaleText.text = @"kadın";
    femaleText.userInteractionEnabled = YES;
    [profileInfoHolder addSubview:femaleText];
    
    [self addBorderBottomToView:femaleText withColor:LOGIN_VIEW_TEXT_FIELDS_BORDER_COLOR withHeight:1.0];
    
    UITapGestureRecognizer* femaleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(femaleTapped)];
    [femaleText addGestureRecognizer:femaleTap];
    
    maleText = [[UILabel alloc] initWithFrame:[self maleFrame]];
    maleText.backgroundColor = [UIColor clearColor];
    maleText.textColor = LOGIN_VIEW_TEXT_FIELDS_PLACEHOLDER_COLOR;
    maleText.font = PROFILE_INFO_FONTS;
    maleText.text = @"erkek";
    maleText.userInteractionEnabled = YES;
    [profileInfoHolder addSubview:maleText];
    
    [self addBorderBottomToView:maleText withColor:LOGIN_VIEW_TEXT_FIELDS_BORDER_COLOR withHeight:1.0];
    
    UITapGestureRecognizer* maleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maleTapped)];
    [maleText addGestureRecognizer:maleTap];
    
    birthdateField = [[PSLoginTextField alloc] initWithFrame:[self birtdateFrame]];
    birthdateField.placeholder = @"Doğum Tarihi";
    birthdateField.font = PROFILE_INFO_FONTS;
    birthdateField.delegate = self;
    [profileInfoHolder addSubview:birthdateField];
    
    birthdatePicker = [[UIDatePicker alloc] init];
    birthdatePicker.datePickerMode = UIDatePickerModeDate;
    [birthdatePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
    [birthdateField setInputView:birthdatePicker];
    
    cityField = [[PSLoginTextField alloc] initWithFrame:[self cityFrame]];
    cityField.placeholder = @"Şehir";
    cityField.font = PROFILE_INFO_FONTS;
    [profileInfoHolder addSubview:cityField];
    
    passwordField = [[PSLoginTextField alloc] initWithFrame:[self passwordFrame]];
    passwordField.placeholder = @"Şifre";
    passwordField.font = PROFILE_INFO_FONTS;
    passwordField.secureTextEntry = YES;
    [profileInfoHolder addSubview:passwordField];
    
    updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    updateButton.frame = [self updateButtonFrame];
    updateButton.titleLabel.font = PROFILE_VIEW_UPDATE_BUTTON_FONT;
    [updateButton setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:PROFILE_VIEW_UPDATE_BUTTON_NORMAL_COLOR] forState:UIControlStateNormal];
    [updateButton setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:PROFILE_VIEW_UPDATE_BUTTON_HIGHLIGHTED_COLOR] forState:UIControlStateHighlighted];
    [updateButton setTitleColor:PROFILE_VIEW_UPDATE_BUTTON_TITLE_NORMAL_COLOR forState:UIControlStateNormal];
    [updateButton setTitleColor:PROFILE_VIEW_UPDATE_BUTTON_TITLE_HIGHLIGHTED_COLOR forState:UIControlStateHighlighted];
    [updateButton setTitle:@"GÜNCELLE" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(updateProfileInfo) forControlEvents:UIControlEventTouchUpInside];
    [profileInfoHolder addSubview:updateButton];
}
- (void) datePickerChanged:(UIDatePicker*)picker
{
    birthdateField.text = [[Util sharedInstance] stringFromDate:picker.date];
}
- (void) updateProfileInfo
{
    NSMutableArray* fullNameComponents = @[].mutableCopy;
    [fullNameComponents addObject:firstNameField.text];
    [fullNameComponents addObject:lastNameField.text];
    user.fullName = [fullNameComponents componentsJoinedByString:@" "];
    
    user.email = emailField.text;
    
    user.phone = phoneField.text;
    [user setIsFemale:isFemale];
    
    user.birthdate = birthdatePicker.date;
    user.city = cityField.text;
    user.password = passwordField.text;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ProfileInfoUpdateCompletedNotification object:nil];
}
- (void) femaleTapped
{
    isFemale = YES;
    [self setGender];
}
- (void) maleTapped
{
    isFemale = NO;
    [self setGender];
}
- (void) setGender
{
    if (isFemale) {
        maleText.textColor = LOGIN_VIEW_TEXT_FIELDS_PLACEHOLDER_COLOR;
        femaleText.textColor = LOGIN_VIEW_TEXT_FIELDS_TEXT_COLOR;
    } else {
        maleText.textColor = LOGIN_VIEW_TEXT_FIELDS_TEXT_COLOR;
        femaleText.textColor = LOGIN_VIEW_TEXT_FIELDS_PLACEHOLDER_COLOR;
    }
}
- (void) addBorderBottomToView:(UIView*)view withColor:(UIColor*)color withHeight:(CGFloat)height
{
    CGRect frame = view.frame;
    CALayer* bottomBorder = [CALayer layer];
    bottomBorder.borderColor = color.CGColor;
    bottomBorder.borderWidth = height;
    bottomBorder.frame = CGRectMake(0.0, frame.size.height-height, frame.size.width, height);
    [view.layer addSublayer:bottomBorder];
}

- (void) tapped
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ProfileInfoUpdateCanceledNotification object:nil];
}

@end
