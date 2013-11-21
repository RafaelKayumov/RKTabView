//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. License: MIT.

#import <Foundation/Foundation.h>

typedef enum {
    TabStateEnabled,
    TabStateDisabled
} TabState;

typedef enum {
    TabTypeUsual,
    TabTypeButton,
    TabTypeUnexcludable
} TabType;

@interface RKTabItem : NSObject

@property (readwrite) TabState tabState;
@property (readonly) TabType tabType;

@property (nonatomic, assign, readonly) id target;
@property (readonly) SEL selector;

@property (nonatomic, strong) UIColor *selectedBackgroundColor;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong, readonly) UIImage *imageForCurrentState;

+ (RKTabItem *)createUsualItemWithImageEnabled:(UIImage *)imageEnabled
                               imageDisabled:(UIImage *)imageDisabled;

+ (RKTabItem *)createUnexcludableItemWithImageEnabled:(UIImage *)imageEnabled
                               imageDisabled:(UIImage *)imageDisabled;

+ (RKTabItem *)createButtonItemWithImage:(UIImage *)image
                         target:(id)target
                       selector:(SEL)selector;

- (void)switchState;

@end
