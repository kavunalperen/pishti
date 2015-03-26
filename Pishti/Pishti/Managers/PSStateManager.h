//
//  PSStateManager.h
//  Pishti
//
//  Created by Alperen Kavun on 26/03/15.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#define kIsSavedDesignAvailable @"isSavedDesignAvailableKey"
#define kSavedDesignData @"savedDesignDataKey"

#import <Foundation/Foundation.h>

@interface PSStateManager : NSObject

+ (PSStateManager*) sharedInstance;
- (BOOL) isSavedDesignAvailable;
- (void) clearSavedDesign;
- (void) saveDesign;
- (NSMutableDictionary*) getSavedDesign;

@end
