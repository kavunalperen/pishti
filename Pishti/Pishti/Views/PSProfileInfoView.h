//
//  PSProfileInfoView.h
//  Pishti
//
//  Created by Alperen Kavun on 18/04/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ProfileInfoUpdateCompletedNotification @"profileInfoUpdateCompleted"
#define ProfileInfoUpdateCanceledNotification @"profileInfoUpdateCanceled"

@interface PSProfileInfoView : UIView <UITextFieldDelegate, UIPickerViewDelegate>

@end
