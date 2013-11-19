//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. License: MIT.

#import "TitledItemsExampleController.h"

#import "RKTabItem.h"
#import "RKTabView.h"

@interface TitledItemsExampleController () <RKTabViewDelegate>
@property (nonatomic, strong) IBOutlet RKTabView *titledTabsView;
@end

@implementation TitledItemsExampleController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Titled tabs view";
    
    RKTabItem *mastercardTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"mastercard"]];
    mastercardTabItem.title = @"MasterCard";
    RKTabItem *paypalTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"paypal"]];
    paypalTabItem.title = @"PayPal";
    RKTabItem *visaTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"visa"]];
    visaTabItem.title = @"Visa";
    RKTabItem *wuTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"wu"]];
    wuTabItem.title = @"Western Union";
    RKTabItem *wireTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"wire-transfer"]];
    wireTabItem.title = @"Wire Transfer";
    
    //mastercardTabItem.tabState = TabStateEnabled;
    
    self.titledTabsView.darkensBackgroundForEnabledTabs = YES;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(25, 25);
    self.titledTabsView.titleColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    
    self.titledTabsView.tabItems = @[mastercardTabItem, paypalTabItem, visaTabItem, wuTabItem, wireTabItem];
}

#pragma mark - RKTabViewDelegate

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %d became enabled on tab view", index);
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %d became disabled on tab view", index);
}

@end
