//
//  PSProfileViewController.m
//  Pishti
//
//  Created by Alperen Kavun on 13/04/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "PSProfileViewController.h"
#import "PSAuthenticationManager.h"
#import "PSCommons.h"
#import "PSLabel.h"
#import "Util.h"
#import "PSAddressTableViewCell.h"
#import "PSAddressView.h"
#import "PSProfileInfoView.h"
#import "User.h"

#define     TOP_BUTTONS_WIDTH           46.0
#define     TOP_BUTTONS_HEIGHT          46.0
#define     ProfileInfoHolderLeft       45.0
#define     ProfileInfoHolderTop        79.0
#define     ProfileInfoHolderWidth      SCREEN_SIZE.width-2*ProfileInfoHolderLeft
#define     ProfileInfoHolderHeight     SCREEN_SIZE.height-2*ProfileInfoHolderTop

@interface PSProfileViewController ()

@end

@implementation PSProfileViewController
{
    UITableView*            addressTableView;
    NSArray*                addresses;
    PSAddressView*          addressView;
    PSProfileInfoView*      profileInfoView;
    
    User*                   user;
    
    PSLabel*    firstNameLabel;
    PSLabel*    lastNameLabel;
    PSLabel*    emailLabel;
    PSLabel*    phoneNumberLabel;
    PSLabel*    genderLabel;
    PSLabel*    birthdateLabel;
    PSLabel*    cityLabel;
    PSLabel*    passwordLabel;
}

- (CGRect) backgroundViewFrame
{
    return CGRectMake(0.0, 0.0, SCREEN_SIZE.width, SCREEN_SIZE.height);
}
- (CGRect) logoFrame
{
    return CGRectMake(SCREEN_SIZE.width-84.0, 18.0, 84.0, 94.0);
}
- (CGRect) topButtonsHolderFrame
{
    return CGRectMake(15.0, 15.0, TOP_BUTTONS_WIDTH*3, TOP_BUTTONS_HEIGHT);
}
- (CGRect) backButtonFrame
{
    return CGRectMake(0.0, 0.0, TOP_BUTTONS_WIDTH, TOP_BUTTONS_HEIGHT);
}
- (CGRect) profileInfoHolderFrame
{
    return CGRectMake(ProfileInfoHolderLeft,
                      ProfileInfoHolderTop,
                      ProfileInfoHolderWidth,
                      ProfileInfoHolderHeight);
}
- (CGRect) userInfoTitleHolderFrame
{
    return CGRectMake(0.0, 0.0, ProfileInfoHolderWidth, 40.0);
}
- (CGRect) userInfoIconFrame
{
    return CGRectMake(0.0, 0.0, 40.0, 40.0);
}
- (CGRect) userInfoTitleFrame
{
    return CGRectMake(40.0, 0.0, ProfileInfoHolderWidth-40.0, 40.0);
}
- (CGRect) userInfoValuesHolderFrame
{
    return CGRectMake(0.0, 60.0, ProfileInfoHolderWidth, 132.0);
}
- (CGRect) firstNameFrame
{
    return CGRectMake(0.0, 0.0, 220.0, 38.0);
}
- (CGRect) lastNameFrame
{
    return CGRectMake(229.0, 0.0, 220.0, 38.0);
}
- (CGRect) emailFrame
{
    return CGRectMake(458.0, 0.0, 220.0, 38.0);
}
- (CGRect) phoneNumberFrame
{
    return CGRectMake(0.0, 47.0, 220.0, 38.0);
}
- (CGRect) genderFrame
{
    return CGRectMake(229.0, 47.0, 220.0, 38.0);
}
- (CGRect) birthdateFrame
{
    return CGRectMake(458.0, 47.0, 220.0, 38.0);
}
- (CGRect) cityFrame
{
    return CGRectMake(0.0, 94.0, 220.0, 38.0);
}
- (CGRect) passwordFrame
{
    return CGRectMake(229.0, 94.0, 220.0, 38.0);
}
- (CGRect) updateButtonFrame
{
    return CGRectMake(458.0, 94.0, 220.0, 38.0);
}
- (CGRect) userAddressesTitleHolderFrame
{
    return CGRectMake(0.0, 232.0, ProfileInfoHolderWidth, 40.0);
}
- (CGRect) userAddressesIconFrame
{
    return CGRectMake(0.0, 0.0, 40.0, 40.0);
}
- (CGRect) userAddressesTitleFrame
{
    return CGRectMake(40.0, 0.0, ProfileInfoHolderWidth-80.0, 40.0);
}
- (CGRect) addNewAddressButtonFrame
{
    return CGRectMake(ProfileInfoHolderWidth-40.0, -10.0, 40.0, 40.0);
}
- (CGRect) addressesTableViewFrame
{
    return CGRectMake(0.0, 272.0, ProfileInfoHolderWidth, 315.0);
}
- (CGRect) oldOrdersTitleHolderFrame
{
    return CGRectMake(0.0, 636.0, ProfileInfoHolderWidth, 40.0);
}
- (CGRect) oldOrdersIconFrame
{
    return CGRectMake(0.0, 0.0, 40.0, 40.0);
}
- (CGRect) oldOrdersTitleFrame
{
    return CGRectMake(40.0, 0.0, ProfileInfoHolderWidth-40.0, 40.0);
}
- (CGRect) oldOrdersCollectionViewFrame
{
    return CGRectMake(0.0, 696.0, ProfileInfoHolderWidth, 159.0);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialSetups];
    [self addLogo];
    [self addTopButtons];
    [self generateProfileInfoViews];
    
    [addressTableView registerClass:[PSAddressTableViewCell class] forCellReuseIdentifier:AddressTableViewCellIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeAddressView) name:AddressOperationCanceledNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeAndUpdateAddressView) name:AddressOperationCompletedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateAddress:) name:AddressWillBeUpdatedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeProfileInfoView) name:ProfileInfoUpdateCanceledNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeAndUpdateProfileInfoView) name:ProfileInfoUpdateCompletedNotification object:nil];
    
    user = [[PSAuthenticationManager sharedInstance] getAuthenticatedUser];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self configureViews];
}
- (void) configureViews
{
    firstNameLabel.text = [user getUserFirstName];
    lastNameLabel.text = [user getUserLastName];
    emailLabel.text = user.email;
    phoneNumberLabel.text = user.phone;
    genderLabel.text = [user getUserGender];
    birthdateLabel.text = [user getUserBirthDateString];
    cityLabel.text = user.city;
    [addressTableView reloadData];
}
- (void) initialSetups
{
    UIImageView* backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainscreen_bg.png"]];
    backgroundView.backgroundColor = [UIColor clearColor];
    backgroundView.frame = [self backgroundViewFrame];
    [self.view addSubview:backgroundView];
}

- (void) addTopButtons
{
    UIView* topButtonsHolder = [[UIView alloc] initWithFrame:[self topButtonsHolderFrame]];
    topButtonsHolder.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topButtonsHolder];
    
    UIButton* backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor clearColor];
    backButton.frame = [self backButtonFrame];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn_normal.png"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [topButtonsHolder addSubview:backButton];
}
- (void) addLogo
{
    UIButton* logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logoButton.backgroundColor = [UIColor clearColor];
    logoButton.frame = [self logoFrame];
    [logoButton setBackgroundImage:[UIImage imageNamed:@"mainscreen_logo.png"] forState:UIControlStateNormal];
    [logoButton setBackgroundImage:[UIImage imageNamed:@"mainscreen_logo.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:logoButton];
}
- (void) generateProfileInfoViews
{
    UIView* profileInfoHolder = [[UIView alloc] initWithFrame:[self profileInfoHolderFrame]];
    profileInfoHolder.backgroundColor = [UIColor clearColor];
    [self.view addSubview:profileInfoHolder];
    
    UIView* userInfoTitleHolder = [[UIView alloc] initWithFrame:[self userInfoTitleHolderFrame]];
    userInfoTitleHolder.backgroundColor = [UIColor clearColor];
    [profileInfoHolder addSubview:userInfoTitleHolder];
    
    UIImageView* userIcon = [[UIImageView alloc] initWithFrame:[self userInfoIconFrame]];
    userIcon.backgroundColor = [UIColor clearColor];
    userIcon.image = [UIImage imageNamed:@"baslik_icon_kisisel.png"];
    [userInfoTitleHolder addSubview:userIcon];
    
    UILabel* userTitle = [[UILabel alloc] initWithFrame:[self userInfoTitleFrame]];
    userTitle.backgroundColor = [UIColor clearColor];
    userTitle.font = PROFILE_TITLES_FONT;
    userTitle.textColor = PROFILE_TITLES_COLOR;
    userTitle.text = @"ÜYELİK BİLGİLERİM";
    [userInfoTitleHolder addSubview:userTitle];
    
    [self addBorderBottomToView:userInfoTitleHolder withColor:PROFILE_TITLES_BORDER_COLOR withHeight:2.0];
    
    UIView* userInfoValuesHolder = [[UIView alloc] initWithFrame:[self userInfoValuesHolderFrame]];
    userInfoValuesHolder.backgroundColor = [UIColor clearColor];
    [profileInfoHolder addSubview:userInfoValuesHolder];
    
    firstNameLabel = [self createValueLabelWithFrame:[self firstNameFrame]];
    [userInfoValuesHolder addSubview:firstNameLabel];
    
    lastNameLabel = [self createValueLabelWithFrame:[self lastNameFrame]];
    [userInfoValuesHolder addSubview:lastNameLabel];
    
    emailLabel = [self createValueLabelWithFrame:[self emailFrame]];
    [userInfoValuesHolder addSubview:emailLabel];
    
    phoneNumberLabel = [self createValueLabelWithFrame:[self phoneNumberFrame]];
    [userInfoValuesHolder addSubview:phoneNumberLabel];
    
    genderLabel = [self createValueLabelWithFrame:[self genderFrame]];
    [userInfoValuesHolder addSubview:genderLabel];
    
    birthdateLabel = [self createValueLabelWithFrame:[self birthdateFrame]];
    [userInfoValuesHolder addSubview:birthdateLabel];
    
    cityLabel = [self createValueLabelWithFrame:[self cityFrame]];
    [userInfoValuesHolder addSubview:cityLabel];
    
    passwordLabel = [self createValueLabelWithFrame:[self passwordFrame]];
    passwordLabel.text = @"• • • • • •";
    [userInfoValuesHolder addSubview:passwordLabel];
    
    UIButton* updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    updateButton.frame = [self updateButtonFrame];
    updateButton.titleLabel.font = PROFILE_VIEW_UPDATE_BUTTON_FONT;
    [updateButton setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:PROFILE_VIEW_UPDATE_BUTTON_NORMAL_COLOR] forState:UIControlStateNormal];
    [updateButton setBackgroundImage:[[Util sharedInstance] UIImageWithUIColor:PROFILE_VIEW_UPDATE_BUTTON_HIGHLIGHTED_COLOR] forState:UIControlStateHighlighted];
    [updateButton setTitleColor:PROFILE_VIEW_UPDATE_BUTTON_TITLE_NORMAL_COLOR forState:UIControlStateNormal];
    [updateButton setTitleColor:PROFILE_VIEW_UPDATE_BUTTON_TITLE_HIGHLIGHTED_COLOR forState:UIControlStateHighlighted];
    [updateButton setTitle:@"GÜNCELLE" forState:UIControlStateNormal];
    [updateButton addTarget:self action:@selector(updateUserProfile) forControlEvents:UIControlEventTouchUpInside];
    [userInfoValuesHolder addSubview:updateButton];
    
    UIView* userAddressesTitleHolder = [[UIView alloc] initWithFrame:[self userAddressesTitleHolderFrame]];
    userAddressesTitleHolder.backgroundColor = [UIColor clearColor];
    [profileInfoHolder addSubview:userAddressesTitleHolder];
    
    UIImageView* addressIcon = [[UIImageView alloc] initWithFrame:[self userAddressesIconFrame]];
    addressIcon.backgroundColor = [UIColor clearColor];
    addressIcon.image = [UIImage imageNamed:@"baslik_icon_adresler.png"];
    [userAddressesTitleHolder addSubview:addressIcon];
    
    UILabel* addressTitle = [[UILabel alloc] initWithFrame:[self userAddressesTitleFrame]];
    addressTitle.backgroundColor = [UIColor clearColor];
    addressTitle.font = PROFILE_TITLES_FONT;
    addressTitle.textColor = PROFILE_TITLES_COLOR;
    addressTitle.text = @"ADRESLERİM";
    [userAddressesTitleHolder addSubview:addressTitle];
    
    UIButton* addNewAddressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addNewAddressButton.backgroundColor = [UIColor clearColor];
    addNewAddressButton.frame = [self addNewAddressButtonFrame];
    [addNewAddressButton setImage:[UIImage imageNamed:@"address_add_btn_normal.png"] forState:UIControlStateNormal];
    [addNewAddressButton setImage:[UIImage imageNamed:@"address_add_btn_highlighted.png"] forState:UIControlStateHighlighted];
    [addNewAddressButton addTarget:self action:@selector(addNewAddress) forControlEvents:UIControlEventTouchUpInside];
    [userAddressesTitleHolder addSubview:addNewAddressButton];
    
    [self addBorderBottomToView:userAddressesTitleHolder withColor:PROFILE_TITLES_BORDER_COLOR withHeight:2.0];
    
    addressTableView = [[UITableView alloc] initWithFrame:[self addressesTableViewFrame]];
    addressTableView.backgroundColor = [UIColor clearColor];
    addressTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    addressTableView.allowsSelection = NO;
    addressTableView.delegate = self;
    addressTableView.dataSource = self;
    addressTableView.canCancelContentTouches = YES;
    [profileInfoHolder addSubview:addressTableView];
    
    [addressTableView setTableFooterView:[UIView new]];
    
    UIView* oldOrdersTitleHolder = [[UIView alloc] initWithFrame:[self oldOrdersTitleHolderFrame]];
    oldOrdersTitleHolder.backgroundColor = [UIColor clearColor];
    [profileInfoHolder addSubview:oldOrdersTitleHolder];
    
    UIImageView* oldOrdersIcon = [[UIImageView alloc] initWithFrame:[self oldOrdersIconFrame]];
    oldOrdersIcon.backgroundColor = [UIColor clearColor];
    oldOrdersIcon.image = [UIImage imageNamed:@"baslik_icon_siparisler.png"];
    [oldOrdersTitleHolder addSubview:oldOrdersIcon];
    
    UILabel* oldOrdersTitle = [[UILabel alloc] initWithFrame:[self oldOrdersTitleFrame]];
    oldOrdersTitle.backgroundColor = [UIColor clearColor];
    oldOrdersTitle.font = PROFILE_TITLES_FONT;
    oldOrdersTitle.textColor = PROFILE_TITLES_COLOR;
    oldOrdersTitle.text = @"SİPARİŞLERİM";
    [oldOrdersTitleHolder addSubview:oldOrdersTitle];
    
    [self addBorderBottomToView:oldOrdersTitleHolder withColor:PROFILE_TITLES_BORDER_COLOR withHeight:2.0];
    
    UIView* view2 = [[UIView alloc] initWithFrame:[self oldOrdersCollectionViewFrame]];
    view2.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
    [profileInfoHolder addSubview:view2];
}
- (PSLabel*) createValueLabelWithFrame:(CGRect)frame
{
    PSLabel* label = [[PSLabel alloc] initWithFrame:frame];
    label.font = PROFILE_VALUES_FONT;
    label.textColor = PROFILE_VALUES_COLOR;
    [self addBorderBottomToView:label withColor:PROFILE_VALUES_BORDER_COLOR withHeight:1.0];
    return label;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return user.addresses.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105.0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PSAddressTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:AddressTableViewCellIdentifier];
    
    cell.currentAddress = [user.addresses objectAtIndex:indexPath.row];
    [cell customizeWithCurrentAddress];
    
    return cell;
}

- (void) addNewAddress
{
    addressView = [[PSAddressView alloc] initWithAddress:nil];
    [self.view addSubview:addressView];
}
- (void) updateAddress:(NSNotification*)notif
{
    addressView = [[PSAddressView alloc] initWithAddress:notif.object];
    [self.view addSubview:addressView];
}
- (void) closeAddressView
{
    [addressView removeFromSuperview];
    addressView = nil;
}
- (void) closeAndUpdateAddressView
{
    [self closeAddressView];
    [addressTableView reloadData];
}
- (void) updateUserProfile
{
    profileInfoView = [[PSProfileInfoView alloc] init];
    [self.view addSubview:profileInfoView];
}
- (void) closeProfileInfoView
{
    [profileInfoView removeFromSuperview];
    profileInfoView = nil;
}
- (void) closeAndUpdateProfileInfoView
{
    [self closeProfileInfoView];
    [self configureViews];
}
- (void) goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
