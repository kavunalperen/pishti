//
//  PSTemplateView.m
//  Pishti
//
//  Created by Alperen Kavun on 5.02.2015.
//  Copyright (c) 2015 pishti. All rights reserved.
//

#import "PSTemplateView.h"
#import "SBJson.h"
#import "PSSubmenuManager.h"
#import "PSDesignViewController2.h"

static NSArray* __allTemplates;

@implementation PSTemplateView

- (id) initWithTemplateId:(NSString*)templateId
{
    if (self = [super init]) {
        _templateId = templateId;
        NSDictionary* template = [PSTemplateView getTemplateWithTemplateId:templateId];
        NSString* imageName = [template objectForKey:@"image_name"];
        CGFloat imageWidth = [[template objectForKey:@"image_width"] floatValue];
        CGFloat imageHeight = [[template objectForKey:@"image_height"] floatValue];
        NSString* fontName = [template objectForKey:@"font_name"];
        CGFloat fontSize = [[template objectForKey:@"font_size"] floatValue];
        CGFloat textWidth = [[template objectForKey:@"text_width"] floatValue];
        CGFloat textHeight = [[template objectForKey:@"text_height"] floatValue];
        CGFloat textLeft = [[template objectForKey:@"text_left"] floatValue];
        CGFloat textTop = [[template objectForKey:@"text_top"] floatValue];
        NSInteger char_limit = [[template objectForKey:@"character_limit"] integerValue];
        NSString* defaultText = [template objectForKey:@"default_text"];
        
        self.frame = CGRectMake(0.0, 0.0, imageWidth, imageHeight);
        
        self.image = [UIImage imageNamed:imageName];
        
        self.textField = [[PSTemplateTextField alloc] initWithFrame:CGRectMake(textLeft, textTop, textWidth, textHeight)];
//        self.textField.backgroundColor = [UIColor greenColor];
        self.textField.font = [UIFont fontWithName:fontName size:fontSize];
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.delegate = self;
        self.characterLimit = char_limit;
        self.defaultText = defaultText;
        self.textField.text = self.defaultText;
        [self addSubview:self.textField];
        
        self.originalSize = CGSizeZero;
    }
    self.userInteractionEnabled = YES;
    
    return self;
}
- (void) configureTemplateWithSettings
{
    CGFloat opacity = [[_templateSettings objectForKey:TEMPLATE_OPACITY_KEY] floatValue];
    self.alpha = opacity;
    
    NSInteger textColorIndex = [[_templateSettings objectForKey:TEMPLATE_TEXT_COLOR_INDEX_KEY] integerValue];
    UIColor* color = [[PSSubmenuManager sharedInstance] getColorWithColorIndex:textColorIndex];
    self.textField.textColor = color;
    self.textField.tintColor = color;
    
    if (CGSizeEqualToSize(self.originalSize, CGSizeZero)) {
        self.originalSize = self.frame.size;
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    int remaining = (int)(self.characterLimit - textField.text.length);
    
    if( (int)string.length - (int)range.length > remaining ) {
        NSRange fieldRange = {0, remaining + range.length};
        
        string = [string substringWithRange:fieldRange];
        
        NSString* replacedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        textField.text = replacedString;
        return NO;
    } else {
        return YES;
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.designView makeTemplateSelected:self];
    return YES;
}
+ (NSDictionary*) getTemplateWithTemplateId:(NSString*)templateId
{
    NSArray* templates = [PSTemplateView getAllTemplates];
    NSDictionary* template;
    for (NSDictionary* temp in templates) {
        if ([[temp objectForKey:@"id"] isEqualToString:templateId]) {
            template = temp;
        }
    }
    return template;
}

+ (NSArray*) getAllTemplates
{
    if (__allTemplates == nil) {
        NSString* content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"templates" ofType:@"json"]
                                                      encoding:NSUTF8StringEncoding
                                                         error:NULL];
        
        
        SBJsonParser* parser = [[SBJsonParser alloc] init];
        __allTemplates = [[parser objectWithString:content] objectForKey:@"templates"];
        
    }
    return __allTemplates;
}

@end
