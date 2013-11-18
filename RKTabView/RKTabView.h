//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. All rights reserved.

#import <UIKit/UIKit.h>

@class RKTabItem;
@class RKTabView;

@protocol RKTabViewDelegate <NSObject>

//Called for all types except TabTypeButton
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem;
//Called Only for unexludable items. (TabTypeUnexludable)
- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem;

@end

@interface RKTabView : UIView

@property (nonatomic, assign) IBOutlet id<RKTabViewDelegate> delegate;
@property (readwrite) BOOL darkensBackgroundForEnabledTabs;
@property (readwrite) BOOL drawSeparators;

@property (nonatomic, strong) NSArray *tabItems;

- (id)initWithFrame:(CGRect)frame andTabItems:(NSArray *)tabItems;

@end
