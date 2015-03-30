//
//  PSCommons.h
//  Pishti
//
//  Created by Alperen Kavun on 8.04.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//
// color macros
#define BLACK_COLOR [UIColor blackColor]
#define GRAY_COLOR [UIColor grayColor]
#define WHITE_COLOR [UIColor whiteColor]
#define GREEN_COLOR [UIColor greenColor]
#define BLUE_COLOR [UIColor blueColor]
#define ORANGE_COLOR [UIColor orangeColor]
#define RED_COLOR [UIColor redColor]

// screen related macros
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SCREEN_FRAME [UIScreen mainScreen].bounds
#define SCREEN_SCALE [UIScreen mainScreen].scale

// cn => HelveticaNeue

// design menu fonts
#define DESIGN_MENU_SUBMENU_TITLES_FONT [UIFont fontWithName:@"HelveticaNeue" size:15.0]
#define DESIGN_MENU_SUBMENU_VALUES_FONT [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0]
#define DESIGN_MENU_SUBMENU_PRICE_FONT [UIFont fontWithName:@"HelveticaNeue-Light" size:30.0]
#define DESIGN_MENU_SUBMENU_SLIDER_FONT [UIFont fontWithName:@"HelveticaNeue-Light" size:11.0]
#define DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_FONT [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0]
#define DESIGN_MENU_SUBMENU_TEMPLATE_TEXT_FIELD_FONT [UIFont fontWithName:@"" size:20.0]

// design menu colors
#define DESIGN_MENU_SUBMENU_TITLES_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0]
#define DESIGN_MENU_SUBMENU_VALUES_COLOR [UIColor colorWithRed:231.0/255.0 green:48.0/255.0 blue:50.0/255.0 alpha:1.0]
#define DESIGN_MENU_SUBMENU_BORDER_BOTTOM_COLOR [UIColor colorWithRed:214.0/255.0 green:216.0/255.0 blue:228.0/255.0 alpha:1.0]
#define DESIGN_MENU_SUBMENU_PRICE_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0]
#define DESIGN_MENU_SUBMENU_TEXTVIEW_BORDER_COLOR [UIColor colorWithRed:214.0/255.0 green:216.0/255.0 blue:228.0/255.0 alpha:1.0]
#define DESIGN_MENU_SUBMENU_SLIDER_TEXT_COLOR [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
#define DESIGN_MENU_SUBMENU_IMAGE_GALLERY_BACKGROUND_COLOR [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]
#define DESIGN_MENU_SUBMENU_IMAGE_GALLERY_BORDER_COLOR [UIColor colorWithRed:214.0/255.0 green:216.0/255.0 blue:228.0/255.0 alpha:1.0]
#define DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_NORMAL_TEXT_COLOR [UIColor colorWithRed:152.0/255.0 green:157.0/255.0 blue:195.0/255.0 alpha:1.0]
#define DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_HIGHLIGHTED_TEXT_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0]
#define DESIGN_MENU_SUBMENU_TABLEVIEW_CELL_SELECTED_TEXT_COLOR [UIColor colorWithRed:231.0/255.0 green:48.0/255.0 blue:50.0/255.0 alpha:1.0]

#define DESIGN_MENU_SUBMENU_TEMPLATE_COLLECTION_VIEW_HOLDER_BORDER_COLOR [UIColor colorWithRed:214.0/255.0 green:216.0/255.0 blue:228.0/255.0 alpha:1.0]
#define DESIGN_MENU_SUBMENU_TEMPLATE_TEXT_FIELD_PLACEHOLDER_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:0.4]

#define SUBMENU_BACKGROUND_COLOR [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]

// login view fonts
#define LOGIN_VIEW_TITLE_FONT [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0]
#define LOGIN_VIEW_TITLE_INFORMATION_FONT [UIFont fontWithName:@"HelveticaNeue" size:11.0]
#define LOGIN_VIEW_SWITCH_BUTTON_FONT [UIFont fontWithName:@"HelveticaNeue" size:15.0]
#define LOGIN_VIEW_FORGOT_PASSWORD_BUTTON_FONT [UIFont fontWithName:@"HelveticaNeue" size:13.0]
#define LOGIN_VIEW_SIGNIN_BUTTON_FONT [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:30.0]
#define LOGIN_VIEW_TEXT_FIELDS_FONT [UIFont fontWithName:@"HelveticaNeue" size:30.0]
#define LOGIN_VIEW_TEXT_FIELDS_PLACEHOLDER_FONT [UIFont fontWithName:@"HelveticaNeue" size:30.0]

// login view colors
#define LOGIN_VIEW_OVERLAY_COLOR [UIColor colorWithRed:20.0/255.0 green:26.0/255.0 blue:72.0/255.0 alpha:0.85]
#define LOGIN_VIEW_TITLE_COLOR [UIColor colorWithRed:231.0/255.0 green:48.0/255.0 blue:50.0/255.0 alpha:1.0]
#define LOGIN_VIEW_TITLE_INFORMATION_COLOR [UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0]
#define LOGIN_VIEW_SWITCH_BUTTON_NORMAL_COLOR [UIColor colorWithRed:231.0/255.0 green:48.0/255.0 blue:50.0/255.0 alpha:1.0]
#define LOGIN_VIEW_SWITCH_BUTTON_HIGHLIGHTED_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0]
#define LOGIN_VIEW_FORGOT_PASSWORD_BUTTON_NORMAL_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:0.5]
#define LOGIN_VIEW_FORGOT_PASSWORD_BUTTON_HIGHLIGHTED_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0]
#define LOGIN_VIEW_SIGNIN_BUTTON_NORMAL_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:0.13]
#define LOGIN_VIEW_SIGNIN_BUTTON_HIGHLIGHTED_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0]
#define LOGIN_VIEW_SIGNIN_BUTTON_TITLE_NORMAL_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0]
#define LOGIN_VIEW_SIGNIN_BUTTON_TITLE_HIGHLIGHTED_COLOR [UIColor whiteColor]
#define LOGIN_VIEW_TEXT_FIELDS_TEXT_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:1.0]
#define LOGIN_VIEW_TEXT_FIELDS_PLACEHOLDER_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:0.35]
#define LOGIN_VIEW_TEXT_FIELDS_BORDER_COLOR [UIColor colorWithRed:40.0/255.0 green:53.0/255.0 blue:144.0/255.0 alpha:0.13]

// design overview fonts
#define ORDER_DETAILS_TITLE_FONT [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:24.0]
#define ORDER_DETAILS_DETAILS_TITLE_FONT [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0]
#define ORDER_DETAILS_DETAILS_VALUE_FONT [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:24.0]

// design overview colors
#define DESIGN_OVERVIEW_BORDERS_COLOR [UIColor colorWithRed:215.0/255.0 green:188.0/255.0 blue:156.0/255.0 alpha:1.0]
#define ORDER_DETAILS_TITLE_TEXT_COLOR [UIColor colorWithRed:231.0/255.0 green:48.0/255.0 blue:50.0/255.0 alpha:1.0]
#define ORDER_DETAILS_GENERAL_PRICE_BACKGROUND_COLOR [UIColor colorWithRed:215.0/255.0 green:188.0/255.0 blue:156.0/255.0 alpha:0.3]
#define ORDER_DETAILS_DETAILS_TITLE_TEXT_COLOR [UIColor colorWithRed:0.0/255.0 green:62.0/255.0 blue:100.0/255.0 alpha:1.0]



