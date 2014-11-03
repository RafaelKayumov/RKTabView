//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. License: MIT.

#import "RKTabView.h"
#import "RkTabItem.h"

#define DARKER_BACKGROUND_VIEW_TAG 33

@interface RKTabView ()

@property (nonatomic, strong) NSMutableArray *tabViews;

@end

@implementation RKTabView

- (id)initWithFrame:(CGRect)frame andTabItems:(NSArray *)tabItems {
    self = [super initWithFrame:frame];
    if (self) {
        self.tabItems = tabItems;
        [self buildUI];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.autoresizesSubviews = YES;
    }
    return self;
}

#pragma mark - Properties

- (RKTabItem *)selectedTabItem {
  int selectedIndex = [self.tabItems indexOfObjectPassingTest:^BOOL(RKTabItem *obj, NSUInteger idx, BOOL *stop) {
    return obj.tabState == TabStateEnabled;
  }];
  
  if (selectedIndex == NSNotFound) {
    return nil;
  }
  
  RKTabItem *selectedItem = [self.tabItems objectAtIndex:selectedIndex];
  return selectedItem;
}

- (void)setTabItems:(NSArray *)tabItems {
    _tabItems = tabItems;
    [self buildUI];
}

- (void)setHorizontalInsets:(HorizontalEdgeInsets)horizontalInsets {
    _horizontalInsets = horizontalInsets;
    [self buildUI];
}

- (NSMutableArray *)tabViews {
    if (!_tabViews) {
        _tabViews = [[NSMutableArray alloc] init];
    }
    return _tabViews;
}

- (UIFont *)titlesFont {
    if (!_titlesFont) {
        _titlesFont = [UIFont systemFontOfSize:9];
    }
    return _titlesFont;
}

- (UIColor *)titlesFontColor {
    if (!_titlesFontColor) {
        _titlesFontColor = [UIColor lightGrayColor];
    }
    return _titlesFontColor;
}

#pragma mark - Private

- (void)cleanTabView {
    for (UIControl *tab in self.tabViews) {
        [tab removeFromSuperview];
    }
    [self.tabViews removeAllObjects];
}

- (void)buildUI {
    //clean before layout items
    [self cleanTabView];
    //build UI
    for (RKTabItem *item in self.tabItems) {
        UIControl *tab = [self tabForItem:item];
        [self addSubview: tab];
        [self.tabViews addObject: tab];
    }
}

- (void)swtichTab:(RKTabItem *)tabItem {
    switch (tabItem.tabType) {
        case TabTypeButton:
            //Do nothing. It has own handler and it does not affect other tabs.
            break;
        case TabTypeUnexcludable:
            //Don't exclude other tabs. Just turn this one on or off and send delegate invocation. Needs invocation for both cases on and off.
            //Switch.
            [tabItem switchState];
            [self setTabContent:tabItem];
            //Call delegate method.
            if (self.delegate) {
                switch (tabItem.tabState) {
                    case TabStateDisabled:
                        if ([self delegateRespondsToDisableSelector]) {
                            [self.delegate tabView:self tabBecameDisabledAtIndex:[self indexOfTab:tabItem] tab:tabItem];
                        }
                        break;
                    case TabStateEnabled:
                        if ([self delegateRespondsToEnableSelector]) {
                            [self.delegate tabView:self tabBecameEnabledAtIndex:[self indexOfTab:tabItem] tab:tabItem];
                        }
                        break;
                }
            }
            [self setTabContent:tabItem];
            break;
        case TabTypeUsual:
            //Exclude excludable items. Send delegate invocation.
            //Tab can we switched only if it's disabled. It can't be switched off by pressing on itself.
            if (tabItem.tabState == TabStateDisabled) {
                //Switch it on.
                [tabItem switchState];
                //Switch down other excludable items.
                for (RKTabItem *item in self.tabItems) {
                    if (item != tabItem && item.tabType == TabTypeUsual) {
                        item.tabState = TabStateDisabled;
                        [self setTabContent:item];
                    }
                }
                //Call delegate method.
                if (self.delegate) {
                    if ([self delegateRespondsToEnableSelector]) {
                        [self.delegate tabView:self tabBecameEnabledAtIndex:[self indexOfTab:tabItem] tab:tabItem];
                    }
                }
            }
            [self setTabContent:tabItem];
            break;
    }
}

#pragma mark - Actions

- (void)pressedTab:(id)sender {
    UIControl *tabView = (UIControl *)sender;
    RKTabItem *tabItem = [self tabItemForTab:tabView];
    [self swtichTab:tabItem];
}

#pragma mark - Helper methods

- (UIControl *)existingTabForTabItem:(RKTabItem *)tabItem {
    int index = [self indexOfTab:tabItem];
    if (index != NSNotFound && self.tabViews.count > index) {
        return self.tabViews[[self indexOfTab:tabItem]];
    } else {
        return nil;
    }
}

- (CGFloat)tabItemWidth {
    CGFloat restrictedWidth = self.frame.size.width - self.horizontalInsets.left - self.horizontalInsets.right;
    return self.tabItems.count > 0 ? restrictedWidth/self.tabItems.count : restrictedWidth;
}

- (CGFloat)tabItemHeight {
    return self.frame.size.height;
}

- (int)indexOfTab:(RKTabItem *)tabItem {
    return [self.tabItems indexOfObject:tabItem];
}

- (RKTabItem *)tabItemForTab:(UIControl *)tab {
    return self.tabItems[[self.tabViews indexOfObject:tab]];
}

- (CGRect)frameForTab:(RKTabItem *)tabItem {
    CGFloat width  = [self tabItemWidth];
    CGFloat height = [self tabItemHeight];
    CGFloat x = self.horizontalInsets.left + [self indexOfTab:tabItem] * width;
    return CGRectMake(x, 0, width, height);
}

- (void)setTabContent:(UIControl *)tab withTabItem:(RKTabItem *)tabItem {
    //clean tab before setting content
    for (UIView *subview in tab.subviews) {
        if (subview != [tab viewWithTag:DARKER_BACKGROUND_VIEW_TAG]) {
            [subview removeFromSuperview];
        }
    }
    
    //Title
    UILabel *titleLabel = nil;
    CGSize titleSize;
    if (tabItem.titleString.length != 0) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 2;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.adjustsLetterSpacingToFitWidth = YES;
        titleLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
        
        UIFont *font = nil;
        if (tabItem.titleFont) {
            font = tabItem.titleFont;
        } else if (!tabItem.titleFont && self.titlesFont) {
            font = self.titlesFont;
        }
        titleLabel.font = font;
        
        UIColor *textColor = nil;
        if (tabItem.tabState == TabStateEnabled && tabItem.titleFontColorEnabled) {
            textColor = tabItem.titleFontColorEnabled;
        } else if (tabItem.tabState == TabStateEnabled && self.titlesFontColorEnabled) {
            textColor = self.titlesFontColorEnabled;
        } else if (tabItem.titleFontColor) {
            textColor = tabItem.titleFontColor;
        } else if (!tabItem.titleFontColor && self.titlesFontColor) {
            textColor = self.titlesFontColor;
        }
        titleLabel.textColor = textColor;
        titleLabel.backgroundColor = [UIColor clearColor];
        
        titleSize = [tabItem.titleString sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(tab.bounds.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        titleLabel.text = tabItem.titleString;
    }
    
    //Image/button
    id interfaceElement = nil;
    
    if (tabItem.tabType == TabTypeButton) {
        interfaceElement = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tabItem.imageForCurrentState.size.width, tabItem.imageForCurrentState.size.height)];
        [((UIButton *)interfaceElement) setImage:tabItem.imageForCurrentState forState:UIControlStateNormal];
        [((UIButton *)interfaceElement) addTarget:tabItem.target action:tabItem.selector forControlEvents:UIControlEventTouchUpInside];
    } else {
        interfaceElement = [[UIImageView alloc] initWithImage:tabItem.imageForCurrentState];
    }
    ((UIView *)interfaceElement).autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    
    //Subviews frames
    if (titleLabel) {
        CGFloat wholeGapHeight = tab.bounds.size.height - ((UIView *)interfaceElement).bounds.size.height - titleSize.height;
        titleLabel.frame = CGRectMake(tab.bounds.size.width/2 - titleSize.width/2, wholeGapHeight*2/3+((UIView *)interfaceElement).bounds.size.height, titleSize.width+2, titleSize.height+2);
        ((UIView *)interfaceElement).frame = CGRectMake(tab.bounds.size.width/2 - ((UIView *)interfaceElement).bounds.size.width/2, wholeGapHeight/3, ((UIView *)interfaceElement).bounds.size.width, ((UIView *)interfaceElement).bounds.size.height);
        [tab addSubview:titleLabel];
    } else {
        ((UIView *)interfaceElement).center = CGPointMake(tab.bounds.size.width/2, tab.bounds.size.height/2);
    }
    
    [tab addSubview:((UIView *)interfaceElement)];
    
    //backgroundColor
    if (self.darkensBackgroundForEnabledTabs) {
        if (tabItem.tabState == TabStateEnabled) {
            [tab viewWithTag:DARKER_BACKGROUND_VIEW_TAG].backgroundColor = [UIColor colorWithWhite:0 alpha:0.15f];
        } else {
            [tab viewWithTag:DARKER_BACKGROUND_VIEW_TAG].backgroundColor = [UIColor clearColor];
        }
    }
    
    //selected tab background color
    if (tabItem.tabState == TabStateEnabled) {
        
        //Apply tabItem selecred background color. If it is nil then apply tabview selected background color (if not nil).
        if (tabItem.enabledBackgroundColor) {
            tab.backgroundColor = tabItem.enabledBackgroundColor;
        } else if (!tabItem.enabledBackgroundColor && self.enabledTabBackgrondColor) {
            tab.backgroundColor = self.enabledTabBackgrondColor;
        }
    } else {
        tab.backgroundColor = tabItem.backgroundColor;
    }
}

- (void)setTabContent:(RKTabItem *)tabItem {
    UIControl *tab = [self tabForItem:tabItem];
    [self setTabContent:tab withTabItem:tabItem];
}

- (UIControl *)tabForItem:(RKTabItem *)tabItem {
    UIControl *tab = [self existingTabForTabItem:tabItem];
    if (tab) {
        return tab;
    } else {
        tab = [[UIControl alloc] initWithFrame:[self frameForTab:tabItem]];
        tab.backgroundColor = tabItem.backgroundColor;
        tab.autoresizesSubviews = YES;
        tab.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
        
        if (tabItem.tabType != TabTypeButton) {
            [tab addTarget:self action:@selector(pressedTab:) forControlEvents:UIControlEventTouchUpInside];
            
            //Add darker background view if necessary
            UIView *darkerBackgroundView = [[UIView alloc] initWithFrame:tab.bounds];
            darkerBackgroundView.userInteractionEnabled = NO;
            darkerBackgroundView.tag = DARKER_BACKGROUND_VIEW_TAG;
            darkerBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            [tab addSubview:darkerBackgroundView];
        }
        
        //setup
        [self setTabContent:tab withTabItem:tabItem];
    }
    return tab;
}

- (BOOL)delegateRespondsToDisableSelector {
    if ([self.delegate respondsToSelector:@selector(tabView:tabBecameDisabledAtIndex:tab:)]) {
        return YES;
    } else {
        NSLog(@"Attention! Your delegate doesn't have tabView:tabBecameDisabledAtIndex:tab: method implementation!");
        return NO;
    }
}

- (BOOL)delegateRespondsToEnableSelector {
    if ([self.delegate respondsToSelector:@selector(tabView:tabBecameEnabledAtIndex:tab:)]) {
        return YES;
    } else {
        NSLog(@"Attention! Your delegate doesn't have tabView:tabBecameEnabledAtIndex:tab: method implementation!");
        return NO;
    }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self buildUI];
    
    self.clipsToBounds = NO;
    if (self.drawSeparators) {
        
        CGFloat darkLineWidth = 0.5f;
        CGFloat lightLineWidth = 0.5f;
        
        UIColor *darkLineColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
        UIColor *lightLineColor = [UIColor colorWithWhite:0.5 alpha:0.4f];
        
        [self draWLineFromPoint:CGPointMake(0, darkLineWidth/2)
                        toPoint:CGPointMake(self.bounds.size.width, darkLineWidth/2)
                      withColor:darkLineColor
                          width:darkLineWidth];
        
        [self draWLineFromPoint:CGPointMake(0, darkLineWidth + lightLineWidth/2)
                        toPoint:CGPointMake(self.bounds.size.width, darkLineWidth + lightLineWidth/2)
                      withColor:lightLineColor
                          width:lightLineWidth];
        
        [self draWLineFromPoint:CGPointMake(0, self.bounds.size.height - darkLineWidth/2 - lightLineWidth)
                        toPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - darkLineWidth/2 - lightLineWidth)
                      withColor:darkLineColor
                          width:darkLineWidth];
        
        [self draWLineFromPoint:CGPointMake(0, self.bounds.size.height - lightLineWidth/2)
                        toPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height - lightLineWidth/2)
                      withColor:lightLineColor
                          width:lightLineWidth];
    }
}

- (void)draWLineFromPoint:(CGPoint)pointFrom toPoint:(CGPoint)pointTo withColor:(UIColor *)color width:(CGFloat)width {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, width);
    CGContextMoveToPoint(context, pointFrom.x, pointFrom.y);
    CGContextAddLineToPoint(context, pointTo.x, pointTo.y);
    CGContextStrokePath(context);
}

@end
