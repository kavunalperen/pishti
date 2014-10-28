//
//  PSTableViewController.m
//  Pishti
//
//  Created by Alperen Kavun on 28.10.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSTableViewController.h"
#import "PSTableView.h"

@interface PSTableViewController ()

@end

@implementation PSTableViewController
{
    PSTableView* fabricColorTableView;
    PSTableView* textColorTableView;
    PSTableView* textFontTableView;
    
    NSArray* colors;
    NSArray* colorNames;
    
    NSArray* fonts;
    NSArray* fontNames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView == fabricColorTableView) {
        return colors.count;
    } else if (tableView == textColorTableView) {
        return colors.count;
    } else if (tableView == textFontTableView) {
        return fonts.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Configure the cell...
    
    return nil;
}

@end
