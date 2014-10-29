//
//  PSDesignLabel.h
//  Pishti
//
//  Created by Alperen Kavun on 29.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSDesignLabel : UILabel

@property NSMutableDictionary* labelSettings;
@property NSString* originalText;

- (id) initWithCenter:(CGPoint)center;
- (void) configureLabelWithSettings;

@end
