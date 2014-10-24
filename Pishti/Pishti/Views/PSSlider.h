//
//  PSSlider.h
//  Pishti
//
//  Created by Alperen Kavun on 24.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol PSSliderDelegate <NSObject>
//
//@required
//- (void) slider:(PSSlider*)slider didChangeValue:(CGFloat)value;
//
//@end

@interface PSSlider : UISlider

@property UIImageView* tooltip;
@property UILabel* tooltipLabel;

- (void) setSliderValue:(CGFloat)value;

@end
