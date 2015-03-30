//
//  PSLoginView.m
//  Pishti
//
//  Created by Alperen Kavun on 30/03/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "PSLoginView.h"
#import "PSCommons.h"
#import "Util.h"
#import "PSAuthenticationManager.h"
#import "PSLoginTextField.h"

@implementation PSLoginView
{
    LoginViewState state;
    
    UIView* subviewsHolder;
    
    UILabel* titleLabel;
    
    UIButton* switchButton;
    UIButton* forgotPasswordButton;
    UIView* approveAgreements;
    
    UIButton* signinButton;
    UIButton* signupButton;
    
    BOOL isFemale;
    BOOL agrementChecked;
    UIImageView* approveAgreementsCheck;
    
    PSLoginTextField* signinPasswordField;
    PSLoginTextField* signinEmailField;
    
    PSLoginTextField* signupFullNameField;
    PSLoginTextField* signupPasswordField;
    PSLoginTextField* signupEmailField;
    
    UIView* femaleCheckView;
    UIView* maleCheckView;
    
    UILabel* femaleText;
    UILabel* maleText;
}
- (CGRect) subviewsHolderFrame
{
    return CGRectMake(215.0, 232.0, 430.0, 536.0);
}
- (CGRect) loginBackgroundFrame
{
    return CGRectMake(0.0, 0.0, 430.0, 536.0);
}
- (CGRect) closeButtonFrame
{
    return CGRectMake(339.0, 24.0, 45.0, 45.0);
}
- (CGRect) titleLabelFrame
{
    return CGRectMake(15.0, 63.0, 260.0, 38.0);
}
- (CGRect) titleInformationLabelFrame
{
    return CGRectMake(15.0, 101.0, 260.0, 15.0);
}
- (CGRect) switchButtonFrame
{
    return CGRectMake(15.0, 491.0, 94.0, 30.0);
}
- (CGRect) forgotPasswordButtonFrame
{
    return CGRectMake(109.0, 491.0, 260.0, 30.0);
}
- (CGRect) signinButtonFrame
{
    return CGRectMake(15.0, 416.0, 354.0, 60.0);
}
- (CGRect) approveAggrementsFrame
{
    return CGRectMake(109.0, 491.0, 260.0, 30.0);
}
- (CGRect) approveAggrementsTextFrame
{
    return CGRectMake(0.0, 0.0, 234.0, 30.0);
}
- (CGRect) approveAggrementsCheckFrame
{
    return CGRectMake(238.0, 4.0, 22.0, 22.0);
}
- (CGRect) signinPasswordFieldFrame
{
    return CGRectMake(15.0, 354.0, 324.0, 38.0);
}
- (CGRect) signinEmailFieldFrame
{
    return CGRectMake(15.0, 292.0, 324.0, 38.0);
}
- (CGRect) signupFullNameFieldFrame
{
    return CGRectMake(15.0, 354.0, 324.0, 38.0);
}
- (CGRect) signupPasswordFieldFrame
{
    return CGRectMake(15.0, 230.0, 324.0, 38.0);
}
- (CGRect) signupEmailFieldFrame
{
    return CGRectMake(15.0, 168.0, 324.0, 38.0);
}
- (CGRect) maleCheckFrame
{
    return CGRectMake(187.0, 292.0, 152.0, 38.0);
}
- (CGRect) femaleCheckFrame
{
    return CGRectMake(15.0, 292.0, 152.0, 38.0);
}
- (CGRect) maleTextFrame
{
    return CGRectMake(5.0, 0.0, 140.0, 38.0);
}
- (CGRect) femaleTextFrame
{
    return CGRectMake(5.0, 0.0, 140.0, 38.0);
}
- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initialSetups];
        agrementChecked = NO;
        isFemale = YES;
        state = LoginViewStateSignin;
        [self configureContent];
    }
    
    return self;
}

- (void) initialSetups
{
    self.backgroundColor = LOGIN_VIEW_OVERLAY_COLOR;
    
    subviewsHolder = [[UIView alloc] initWithFrame:[self subviewsHolderFrame]];
    subviewsHolder.backgroundColor = [UIColor clearColor];
    subviewsHolder.userInteractionEnabled = YES;
    [self addSubview:subviewsHolder];
    
    UIImageView* loginBackgroundView = [[UIImageView alloc] initWithFrame:[self loginBackgroundFrame]];
    loginBackgroundView.backgroundColor = [UIColor clearColor];
    loginBackgroundView.image = [UIImage imageNamed:@"uyelik_bg.png"];
    [subviewsHolder addSubview:loginBackgroundView];
    
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = [self closeButtonFrame];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close_btn_normal.png"] forState:UIControlStateNormal];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"close_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [closeButton addTarget:self action:@selector(closeLoginView) forControlEvents:UIControlEventTouchUpInside];
    [subviewsHolder addSubview:closeButton];
    
    titleLabel = [[UILabel alloc] initWithFrame:[self titleLabelFrame]];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = LOGIN_VIEW_TITLE_FONT;
    titleLabel.textColor = LOGIN_VIEW_TITLE_COLOR;
    [subviewsHolder addSubview:titleLabel];
    
    UILabel* titleInformationLabel = [[UILabel alloc] initWithFrame:[self titleInformationLabelFrame]];
    titleInformationLabel.backgroundColor = [UIColor clearColor];
    titleInformationLabel.font = LOGIN_VIEW_TITLE_INFORMATION_FONT;
    titleInformationLabel.textColor = LOGIN_VIEW_TITLE_INFORMATION_COLOR;
    titleInformationLabel.text = @"Bundan sonraki adımlar için giriş yap ya da kaydol";
    [subviewsHolder addSubview:titleInformationLabel];
    
    CGRect frame = [self switchButtonFrame];
    
    switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    switchButton.frame = frame;
    switchButton.backgroundColor = [UIColor clearColor];
    switchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    switchButton.titleLabel.font = LOGIN_VIEW_SWITCH_BUTTON_FONT;
    [switchButton setTitleColor:LOGIN_VIEW_SWITCH_BUTTON_NORMAL_COLOR forState:UIControlStateNormal];
    [switchButton setTitleColor:LOGIN_VIEW_SWITCH_BUTTON_HIGHLIGHTED_COLOR forState:UIControlStateHighlighted];
    [switchButton addTarget:self action:@selector(switchContent) forControlEvents:UIControlEventTouchUpInside];
    [subviewsHolder addSubview:switchButton];
    
}

- (void) switchContent
{
    [self clearOldContent];
    
    if (state == LoginViewStateSignin) {
        state = LoginViewStateSignup;
    } else {
        state = LoginViewStateSignin;
    }
    
    [self configureContent];
}
- (void) clearOldContent
{
    if (state == LoginViewStateSignin) {
        [forgotPasswordButton removeFromSuperview];
        forgotPasswordButton = nil;
        
        [signinButton removeFromSuperview];
        signinButton = nil;
        
        [signinPasswordField removeFromSuperview];
        signinPasswordField = nil;
        
        [signinEmailField removeFromSuperview];
        signinEmailField = nil;
    } else {
        [approveAgreements removeFromSuperview];
        approveAgreements = nil;
        
        [signupButton removeFromSuperview];
        signupButton = nil;
        
        [signupFullNameField removeFromSuperview];
        signupFullNameField = nil;
        
        [signupPasswordField removeFromSuperview];
        signupPasswordField = nil;
        
        [signupEmailField removeFromSuperview];
        signupEmailField = nil;
        
        [maleCheckView removeFromSuperview];
        maleCheckView = nil;
        
        [femaleCheckView removeFromSuperview];
        femaleCheckView = nil;
    }
}
- (void) configureContent
{
    if (state == LoginViewStateSignin) {
        [self configureForSignin];
    } else {
        [self configureForSignup];
    }
}
- (void) configureForSignup
{
    titleLabel.text = @"KULLANICI KAYDI";
    [switchButton setTitle:@"Giriş Yap" forState:UIControlStateNormal];
    
    approveAgreements = [[UIView alloc] initWithFrame:[self forgotPasswordButtonFrame]];
    approveAgreements.backgroundColor = [UIColor clearColor];
    [subviewsHolder addSubview:approveAgreements];
    
    UILabel* approveAgreementsText = [[UILabel alloc] initWithFrame:[self approveAggrementsTextFrame]];
    approveAgreementsText.backgroundColor = [UIColor clearColor];
    approveAgreementsText.font = LOGIN_VIEW_FORGOT_PASSWORD_BUTTON_FONT;
    approveAgreementsText.textColor = LOGIN_VIEW_FORGOT_PASSWORD_BUTTON_NORMAL_COLOR;
    approveAgreementsText.text = @"Haklarımı okudum, kabul ediyorum.";
    approveAgreementsText.textAlignment = NSTextAlignmentRight;
    [approveAgreements addSubview:approveAgreementsText];
    
    approveAgreementsCheck = [[UIImageView alloc] initWithFrame:[self approveAggrementsCheckFrame]];
    approveAgreementsCheck.backgroundColor = [UIColor clearColor];
    [approveAgreements addSubview:approveAgreementsCheck];
    
    [self setAgreementImage];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(agreementTapped)];
    [approveAgreements addGestureRecognizer:tapGesture];
    
    signupButton = [UIButton buttonWithType:UIButtonTypeCustom];
    signupButton.backgroundColor = [UIColor clearColor];
    signupButton.frame = [self signinButtonFrame];
    signupButton.titleLabel.font = LOGIN_VIEW_SIGNIN_BUTTON_FONT;
    [signupButton setTitleColor:LOGIN_VIEW_SIGNIN_BUTTON_TITLE_NORMAL_COLOR forState:UIControlStateNormal];
    [signupButton setTitleColor:LOGIN_VIEW_SIGNIN_BUTTON_TITLE_HIGHLIGHTED_COLOR forState:UIControlStateHighlighted];
    [signupButton setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:LOGIN_VIEW_SIGNIN_BUTTON_NORMAL_COLOR] forState:UIControlStateNormal];
    [signupButton setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:LOGIN_VIEW_SIGNIN_BUTTON_HIGHLIGHTED_COLOR] forState:UIControlStateHighlighted];
    [signupButton setTitle:@"KAYDOL" forState:UIControlStateNormal];
    [signupButton addTarget:self action:@selector(signup) forControlEvents:UIControlEventTouchUpInside];
    [subviewsHolder addSubview:signupButton];
    
    signupFullNameField = [[PSLoginTextField alloc] initWithFrame:[self signupFullNameFieldFrame]];
    signupFullNameField.placeholder = @"adınız soyadınız";
    [subviewsHolder addSubview:signupFullNameField];
    
    signupPasswordField = [[PSLoginTextField alloc] initWithFrame:[self signupPasswordFieldFrame]];
    signupPasswordField.placeholder = @"şifreniz";
    signupPasswordField.secureTextEntry = YES;
    [subviewsHolder addSubview:signupPasswordField];
    
    signupEmailField = [[PSLoginTextField alloc] initWithFrame:[self signupEmailFieldFrame]];
    signupEmailField.placeholder = @"e-posta adresiniz";
    [subviewsHolder addSubview:signupEmailField];
    
    CGRect frame = [self femaleCheckFrame];
    
    femaleCheckView = [[UIView alloc] initWithFrame:frame];
    femaleCheckView.backgroundColor = [UIColor clearColor];
    [subviewsHolder addSubview:femaleCheckView];
    
    femaleCheckView.clipsToBounds = YES;
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.borderColor = LOGIN_VIEW_TEXT_FIELDS_BORDER_COLOR.CGColor;
    bottomBorder.borderWidth = 1;
    bottomBorder.frame = CGRectMake(0.0, frame.size.height-1.0, frame.size.width, 1.0);
    [femaleCheckView.layer addSublayer:bottomBorder];
    
    UITapGestureRecognizer* femaleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(femaleTapped)];
    [femaleCheckView addGestureRecognizer:femaleTap];
    
    femaleText = [[UILabel alloc] initWithFrame:[self femaleTextFrame]];
    femaleText.backgroundColor = [UIColor clearColor];
    femaleText.textColor = LOGIN_VIEW_TEXT_FIELDS_PLACEHOLDER_COLOR;
    femaleText.font = LOGIN_VIEW_TEXT_FIELDS_PLACEHOLDER_FONT;
    femaleText.text = @"kadın";
    [femaleCheckView addSubview:femaleText];
    
    maleCheckView = [[UIView alloc] initWithFrame:[self maleCheckFrame]];
    maleCheckView.backgroundColor = [UIColor clearColor];
    [subviewsHolder addSubview:maleCheckView];
    
    CGRect frame2 = [self maleCheckFrame];
    
    maleCheckView.clipsToBounds = YES;
    CALayer *rightBorder2 = [CALayer layer];
    rightBorder2.borderColor = LOGIN_VIEW_TEXT_FIELDS_BORDER_COLOR.CGColor;
    rightBorder2.borderWidth = 1;
    rightBorder2.frame = CGRectMake(0.0, frame2.size.height-1.0, frame2.size.width, 1.0);
    [maleCheckView.layer addSublayer:rightBorder2];
    
    UITapGestureRecognizer* maleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maleTapped)];
    [maleCheckView addGestureRecognizer:maleTap];
    
    maleText = [[UILabel alloc] initWithFrame:[self maleTextFrame]];
    maleText.backgroundColor = [UIColor clearColor];
    maleText.textColor = LOGIN_VIEW_TEXT_FIELDS_PLACEHOLDER_COLOR;
    maleText.font = LOGIN_VIEW_TEXT_FIELDS_PLACEHOLDER_FONT;
    maleText.text = @"erkek";
    [maleCheckView addSubview:maleText];
    
    [self setGender];
}

- (void) configureForSignin
{
    titleLabel.text = @"KULLANICI GİRİŞİ";
    [switchButton setTitle:@"Yeni Üyelik" forState:UIControlStateNormal];
    
    forgotPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    forgotPasswordButton.backgroundColor = [UIColor clearColor];
    forgotPasswordButton.frame = [self forgotPasswordButtonFrame];
    forgotPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    forgotPasswordButton.titleLabel.font = LOGIN_VIEW_FORGOT_PASSWORD_BUTTON_FONT;
    [forgotPasswordButton setTitleColor:LOGIN_VIEW_FORGOT_PASSWORD_BUTTON_NORMAL_COLOR forState:UIControlStateNormal];
    [forgotPasswordButton setTitleColor:LOGIN_VIEW_FORGOT_PASSWORD_BUTTON_HIGHLIGHTED_COLOR forState:UIControlStateHighlighted];
    [forgotPasswordButton setTitle:@"Şifremi Unuttum" forState:UIControlStateNormal];
    [forgotPasswordButton addTarget:self action:@selector(forgotPassword) forControlEvents:UIControlEventTouchUpInside];
    [subviewsHolder addSubview:forgotPasswordButton];
    
    signinButton = [UIButton buttonWithType:UIButtonTypeCustom];
    signinButton.backgroundColor = [UIColor clearColor];
    signinButton.frame = [self signinButtonFrame];
    signinButton.titleLabel.font = LOGIN_VIEW_SIGNIN_BUTTON_FONT;
    [signinButton setTitleColor:LOGIN_VIEW_SIGNIN_BUTTON_TITLE_NORMAL_COLOR forState:UIControlStateNormal];
    [signinButton setTitleColor:LOGIN_VIEW_SIGNIN_BUTTON_TITLE_HIGHLIGHTED_COLOR forState:UIControlStateHighlighted];
    [signinButton setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:LOGIN_VIEW_SIGNIN_BUTTON_NORMAL_COLOR] forState:UIControlStateNormal];
    [signinButton setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:LOGIN_VIEW_SIGNIN_BUTTON_HIGHLIGHTED_COLOR] forState:UIControlStateHighlighted];
    [signinButton setTitle:@"GİRİŞ" forState:UIControlStateNormal];
    [signinButton addTarget:self action:@selector(signin) forControlEvents:UIControlEventTouchUpInside];
    [subviewsHolder addSubview:signinButton];
    
    signinPasswordField = [[PSLoginTextField alloc] initWithFrame:[self signinPasswordFieldFrame]];
    signinPasswordField.placeholder = @"şifreniz";
    signinPasswordField.secureTextEntry = YES;
    [subviewsHolder addSubview:signinPasswordField];
    
    signinEmailField = [[PSLoginTextField alloc] initWithFrame:[self signinEmailFieldFrame]];
    signinEmailField.placeholder = @"e-posta adresiniz";
    [subviewsHolder addSubview:signinEmailField];
    
}
- (void) setAgreementImage
{
    UIImage* checkImage;
    if (agrementChecked) {
        checkImage = [UIImage imageNamed:@"checkbox_checked.png"];
    } else {
        checkImage = [UIImage imageNamed:@"checkbox_normal.png"];
    }
    
    approveAgreementsCheck.image = checkImage;
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
- (void) forgotPassword
{
    NSLog(@"forgot password");
}
- (void) signin
{
    NSLog(@"signin");
}
- (void) signup
{
    NSLog(@"signup");
    NSString* email = signupEmailField.text;
    NSString* password = signupPasswordField.text;
    NSString* gender = isFemale ? @"female" : @"male";
    NSString* fullName = signupFullNameField.text;
    
    if (email != nil && ![email isEqualToString:@""]) {
        if (password != nil && ![password isEqualToString:@""]) {
            if (fullName != nil && ![fullName isEqualToString:@""]) {
                if (agrementChecked) {
                    BOOL success = [[PSAuthenticationManager sharedInstance] signupWithEmail:email
                                                                                 andPassword:password
                                                                                   andGender:gender
                                                                                 andFullName:fullName];
                    if (success) {
                        [[PSAuthenticationManager sharedInstance] closeLoginView];
                        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Done"
                                                                            message:@"Üye kaydınız başarıyla oluşturulmuştur. Profil ekranı kodlaması tamamlanınca profilinizi görüntüleyebilirsiniz."
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"Tamam"
                                                                  otherButtonTitles:nil, nil];
                        [alertView show];
                    } else {
                        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hata"
                                                                            message:@"Üye kaydınız oluşturulurken bir hata oluştu, lütfen daha sonra tekrar deneyiniz."
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"Tamam"
                                                                  otherButtonTitles:nil, nil];
                        [alertView show];
                    }
                } else {
                    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hata"
                                                                        message:@"Lütfen kullanıcı sözleşmesini onaylayınız."
                                                                       delegate:nil
                                                              cancelButtonTitle:@"Tamam"
                                                              otherButtonTitles:nil, nil];
                    [alertView show];
                }
            } else {
                UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hata"
                                                                    message:@"Lütfen adınızı giriniz."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Tamam"
                                                          otherButtonTitles:nil, nil];
                [alertView show];
            }
        } else {
            UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hata"
                                                                message:@"Lütfen şifrenizi giriniz."
                                                               delegate:nil
                                                      cancelButtonTitle:@"Tamam"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
    } else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Hata"
                                                            message:@"Lütfen emailinizi giriniz."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Tamam"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    }
}
- (void) agreementTapped
{
    agrementChecked = !agrementChecked;
    [self setAgreementImage];
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
- (void) closeLoginView
{
    [[PSAuthenticationManager sharedInstance] closeLoginView];
}

@end
