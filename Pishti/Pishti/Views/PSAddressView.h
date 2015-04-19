//
//  PSAddressView.h
//  Pishti
//
//  Created by Alperen Kavun on 18/04/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>

#define     AddressOperationCanceledNotification    @"addressOperationCanceled"
#define     AddressOperationCompletedNotification   @"addressOperationCompleted"

@interface PSAddressView : UIView

- (id) initWithAddress:(NSDictionary*)address;

@end
