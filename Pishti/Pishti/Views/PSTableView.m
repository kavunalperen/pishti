//
//  PSTableView.m
//  Pishti
//
//  Created by Alperen Kavun on 26.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSTableView.h"
#import <QuartzCore/QuartzCore.h>
#import "PSCommons.h"

@implementation PSTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = SUBMENU_BACKGROUND_COLOR;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

@end
