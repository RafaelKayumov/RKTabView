//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. All rights reserved.

#import <Foundation/Foundation.h>

typedef enum {
    TabStateEnabled,
    TabStateDisabled
} TabState;

typedef enum {
    TabTypeUsual,
    TabTypeButton,
    TabTypeUnexludable
} TabType;

@interface RKTabItem : NSObject

@property (readwrite) TabState tabState;
@property (readonly) TabType tabType;

@property (nonatomic, assign, readonly) id target;
@property (readonly) SEL selector;

@property (nonatomic, strong) UIColor *backgroundColor;
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
