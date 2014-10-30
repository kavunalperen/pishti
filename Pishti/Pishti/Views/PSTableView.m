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

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return self;
}

@end
