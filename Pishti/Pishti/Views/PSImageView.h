//
//  PSImageView.h
//  Pishti
//
//  Created by Alperen Kavun on 4.07.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSImageView : UIImageView

@property NSMutableDictionary* imageSettings;
@property CGSize originalSize;

- (id) initWithCenter:(CGPoint)center;

- (void) configureImageWithSettings;

@end
