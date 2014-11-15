//
//  PSPriceManager.h
//  Pishti
//
//  Created by Alperen Kavun on 15.11.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import <Foundation/Foundation.h>

#define INCHES_TO_CM 2.54
#define POINT_TO_INCHES 0.01388

#define BASE_MODEL_KEY @"kBaseModelKey"
#define SLEEVE_TYPE_KEY @"kSleeveType"
#define COLLAR_TYPE_KEY @"kCollarType"
#define FABRIC_TYPE_KEY @"kFabricType"
#define IMAGES_KEY @"kImages"
#define LABELS_KEY @"kLabels"

#define IMAGE_UNIT_PRICE_KEY @"kImageUnitPrice"
#define LABEL_UNIT_PRICE_KEY @"kLabelUnitPrice"
#define GENERAL_COLLAR_PRICE_KEY @"kGeneralCollarPrice"
#define GENERAL_SLEEVE_PRICE_KEY @"kGeneralSleevePrice"
#define GENERAL_FABRIC_PRICE_KEY @"kGeneralFabricPrice"
#define BASE_MODEL_PRICE_KEY @"kBaseModelPrice"
#define TOTAL_PRICE_KEY @"kTotalPrice"

typedef enum VIEW_TYPE
{
    VIEW_TYPE_IMAGE,
    VIEW_TYPE_LABEL
} VIEW_TYPE;

@interface PSPriceManager : NSObject

+ (PSPriceManager*) sharedInstance;
- (void) computePriceWithDesignOptions:(NSMutableDictionary*)designOptions;

@end
