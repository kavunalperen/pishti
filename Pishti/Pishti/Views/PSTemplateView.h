//
//  PSTemplateView.h
//  Pishti
//
//  Created by Alperen Kavun on 5.02.2015.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTemplateTextField.h"

@interface PSTemplateView : UIImageView <UITextFieldDelegate>

@property NSString* templateId;
@property PSTemplateTextField* textField;
@property NSMutableDictionary* templateSettings;
@property CGSize originalSize;
@property NSInteger characterLimit;
@property NSString* defaultText;

+ (NSMutableArray*) getAllTemplates;
- (id) initWithTemplateId:(NSString*)templateId;
- (void) configureTemplateWithSettings;



@end
