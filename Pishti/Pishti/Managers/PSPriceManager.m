//
//  PSPriceManager.m
//  Pishti
//
//  Created by Alperen Kavun on 15.11.2014.
//  Copyright (c) 2014 pishti. All rights reserved.
//

#import "PSPriceManager.h"

static PSPriceManager* __sharedInstance = nil;

@implementation PSPriceManager
{
    NSMutableDictionary* unitPrices;
}
+ (PSPriceManager*) sharedInstance
{
    if (__sharedInstance == nil) {
        __sharedInstance = [[PSPriceManager alloc] init];
        [__sharedInstance generateUnitPrices];
    }
    
    return __sharedInstance;
}
- (void) generateUnitPrices
{
    unitPrices = @{}.mutableCopy;
    
    // kol tipi kalkabilir
    
    [unitPrices setObject:[NSNumber numberWithFloat:0.01] forKey:LABEL_UNIT_PRICE_KEY];
    [unitPrices setObject:[NSNumber numberWithFloat:0.02] forKey:IMAGE_UNIT_PRICE_KEY];
    [unitPrices setObject:[NSNumber numberWithFloat:0.025] forKey:TEMPLATE_UNIT_PRICE_KEY];
    [unitPrices setObject:[NSNumber numberWithFloat:5.0] forKey:GENERAL_COLLAR_PRICE_KEY];
    [unitPrices setObject:[NSNumber numberWithFloat:5.0] forKey:GENERAL_SLEEVE_PRICE_KEY];
    [unitPrices setObject:[NSNumber numberWithFloat:5.0] forKey:GENERAL_FABRIC_PRICE_KEY];
    [unitPrices setObject:[NSNumber numberWithFloat:30.0] forKey:BASE_MODEL_PRICE_KEY];
}

- (void) computePriceWithDesignOptions:(NSMutableDictionary*)designOptions
{
    CGFloat totalPrice = 0.0;
    
    NSString* baseModelType = [designOptions objectForKey:BASE_MODEL_KEY];
    NSString* collarType = [designOptions objectForKey:COLLAR_TYPE_KEY];
    NSString* sleeveType = [designOptions objectForKey:SLEEVE_TYPE_KEY];
    NSString* fabricType = [designOptions objectForKey:FABRIC_TYPE_KEY];
    
    CGFloat baseModelPrice = [self getBaseModelPriceWithType:baseModelType];
    CGFloat collarPrice = [self getCollarPriceWithType:collarType];
    CGFloat sleevePrice = [self getSleevePriceWithType:sleeveType];
    CGFloat fabricPrice = [self getFabricPriceWithType:fabricType];
    
    totalPrice = baseModelPrice+collarPrice+sleevePrice+fabricPrice;
    
    NSArray* imageElements = [designOptions objectForKey:IMAGES_KEY];
    NSArray* labelElements = [designOptions objectForKey:LABELS_KEY];
    NSArray* templateElements = [designOptions objectForKey:TEMPLATES_KEY];
    
    for (NSNumber* area in imageElements) {
        CGFloat areaInFloat = [area floatValue];
        CGFloat currentItemPrice = [self computePriceWithArea:areaInFloat andType:VIEW_TYPE_IMAGE];
        totalPrice += currentItemPrice;
    }
    
    for (NSNumber* area in labelElements) {
        CGFloat areaInFloat = [area floatValue];
        CGFloat currentItemPrice = [self computePriceWithArea:areaInFloat andType:VIEW_TYPE_LABEL];
        totalPrice += currentItemPrice;
    }
    
    for (NSNumber* area in templateElements) {
        CGFloat areaInFloat = [area floatValue];
        CGFloat currentItemPrice = [self computePriceWithArea:areaInFloat andType:VIEW_TYPE_TEMPLATE];
        totalPrice += currentItemPrice;
    }
    
    
    [designOptions setObject:[NSNumber numberWithFloat:totalPrice] forKey:TOTAL_PRICE_KEY];
    
}
- (CGFloat) getCollarPriceWithType:(NSString*)collarType
{
    return [[unitPrices objectForKey:GENERAL_COLLAR_PRICE_KEY] floatValue];
}
- (CGFloat) getSleevePriceWithType:(NSString*)sleeveType
{
    return [[unitPrices objectForKey:GENERAL_SLEEVE_PRICE_KEY] floatValue];
}
- (CGFloat) getFabricPriceWithType:(NSString*)fabricType
{
    return [[unitPrices objectForKey:GENERAL_FABRIC_PRICE_KEY] floatValue];
}
- (CGFloat) getBaseModelPriceWithType:(NSString*)modelType
{
    return [[unitPrices objectForKey:BASE_MODEL_PRICE_KEY] floatValue];
}
- (CGFloat) computePriceWithArea:(CGFloat)area andType:(VIEW_TYPE)type
{
    CGFloat unitPrice;
    
    if (type == VIEW_TYPE_IMAGE) {
        unitPrice = [[unitPrices objectForKey:IMAGE_UNIT_PRICE_KEY] floatValue];
    } else if (type == VIEW_TYPE_LABEL) {
        unitPrice = [[unitPrices objectForKey:LABEL_UNIT_PRICE_KEY] floatValue];
    } else if (type == VIEW_TYPE_TEMPLATE) {
        unitPrice = [[unitPrices objectForKey:TEMPLATE_UNIT_PRICE_KEY] floatValue];
    }
    
    CGFloat actualPrice = area*POINT_TO_INCHES*INCHES_TO_CM*unitPrice;
    
    return actualPrice;
}

@end
