//
//  PSAddressTableViewCell.h
//  Pishti
//
//  Created by Alperen Kavun on 18/04/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSLabel.h"

#define AddressTableViewCellIdentifier @"iAddressTableViewCell"
#define AddressWillBeUpdatedNotification @"addressWillBeUpdatedNotification"

@interface PSAddressTableViewCell : UITableViewCell

@property   PSLabel*        addressTitle;
@property   PSLabel*        address;
@property   PSLabel*        addressCity;
@property   PSLabel*        addressCounty;
@property   UIButton*       updateButton;
@property   NSDictionary*   currentAddress;

- (void) customizeWithCurrentAddress;

@end
