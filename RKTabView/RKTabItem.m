//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. License: MIT.

#import "RKTabItem.h"

@interface RKTabItem ()

@property (readwrite) SEL selector;
@property (nonatomic, assign) id target;

@property (nonatomic, strong) UIImage *imageEnabled;
@property (nonatomic, strong) UIImage *imageDisabled;
@property (readwrite) TabType tabType;

@end

@implementation RKTabItem

+ (RKTabItem *)createUsualItemWithImageEnabled:(UIImage *)imageEnabled
                      imageDisabled:(UIImage *)imageDisabled {
    RKTabItem *tabItem = [[RKTabItem alloc] init];
    if (tabItem) {
        tabItem.imageEnabled = imageEnabled;
        tabItem.imageDisabled = imageDisabled;
        tabItem.tabState = TabStateDisabled;
        tabItem.tabType = TabTypeUsual;
    }
    return tabItem;
}

+ (RKTabItem *)createUnexcludableItemWithImageEnabled:(UIImage *)imageEnabled
                             imageDisabled:(UIImage *)imageDisabled {
    RKTabItem *tabItem = [[RKTabItem alloc] init];
    if (tabItem) {
        tabItem.imageEnabled = imageEnabled;
        tabItem.imageDisabled = imageDisabled;
        tabItem.tabState = TabStateDisabled;
        tabItem.tabType = TabTypeUnexcludable;
    }
    return tabItem;
}

+ (RKTabItem *)createButtonItemWithImage:(UIImage *)image
                       target:(id)target
                     selector:(SEL)selector {
    RKTabItem *tabItem = [[RKTabItem alloc] init];
    if (tabItem) {
        tabItem.imageEnabled = image;
        tabItem.tabType = TabTypeButton;
        tabItem.target = target;
        tabItem.selector = selector;
    }
    return tabItem;
}

- (UIImage *)imageEnabled {
    if (!_imageEnabled) {
        _imageEnabled = self.imageDisabled;
    }
    return _imageEnabled;
}

- (UIImage *)imageForCurrentState {
    switch (self.tabState) {
        case TabStateEnabled:
            return self.imageEnabled;
            break;
        case TabStateDisabled:
            return self.imageDisabled;
            break;
        default:
            return nil;
            break;
    }
}

- (void)switchState {
    switch (self.tabState) {
        case TabStateEnabled:
            self.tabState = TabStateDisabled;
            break;
        case TabStateDisabled:
            self.tabState = TabStateEnabled;
            break;
        default:
            return;
            break;
    }
}

@end
