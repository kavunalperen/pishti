//
//  PSStateManager.m
//  Pishti
//
//  Created by Alperen Kavun on 26/03/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "PSStateManager.h"
#import "PSSubmenuManager.h"

static PSStateManager* __sharedInstance = nil;

@implementation PSStateManager

+ (PSStateManager*) sharedInstance
{
    if (__sharedInstance == nil) {
        __sharedInstance = [[PSStateManager alloc] init];
    }
    
    return __sharedInstance;
}

- (BOOL) isSavedDesignAvailable
{
    NSNumber* isAvailable = [[NSUserDefaults standardUserDefaults] objectForKey:kIsSavedDesignAvailable];
    
    if (isAvailable) {
        return [isAvailable boolValue];
    }
    
    return NO;
}

- (void) clearSavedDesign
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kSavedDesignData];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:kIsSavedDesignAvailable];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableDictionary*) getSavedDesign
{
    NSData* savedData = [[NSUserDefaults standardUserDefaults] objectForKey:kSavedDesignData];
    return [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
}

- (void) saveDesign
{
    NSMutableDictionary* savedDesignData = @{}.mutableCopy;
    [savedDesignData setObject:[[PSSubmenuManager sharedInstance] getFabricSettings] forKey:@"fabricSettings"];
    [savedDesignData setObject:[[PSSubmenuManager sharedInstance] getTextSettings] forKey:@"textSettings"];
    [savedDesignData setObject:[[PSSubmenuManager sharedInstance] getImageSettings] forKey:@"imageSettings"];
    [savedDesignData setObject:[[PSSubmenuManager sharedInstance] getTemplateSettings] forKey:@"templateSettings"];
    [savedDesignData setObject:[[[PSSubmenuManager sharedInstance] getSubmenuDelegate] getAllLabels] forKey:@"allLabels"];
    [savedDesignData setObject:[[[PSSubmenuManager sharedInstance] getSubmenuDelegate] getAllTemplates] forKey:@"allTemplates"];
    [savedDesignData setObject:[[[PSSubmenuManager sharedInstance] getSubmenuDelegate] getAllImages] forKey:@"allImages"];
    [savedDesignData setObject:[NSNumber numberWithInteger:[[PSSubmenuManager sharedInstance] getCurrentSubmenuType]] forKey:@"submenuType"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:savedDesignData] forKey:kSavedDesignData];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:kIsSavedDesignAvailable];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

@end
