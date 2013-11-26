//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. License: MIT.

#import "TitledItemsExampleController.h"

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
    mastercardTabItem.titleString = @"MasterCard";
    RKTabItem *paypalTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"paypal"]];
    paypalTabItem.titleString = @"PayPal";
    RKTabItem *visaTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"visa"]];
    visaTabItem.titleString = @"Visa";
    RKTabItem *wuTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"wu"]];
    wuTabItem.titleString = @"Western Union";
    RKTabItem *wireTabItem = [RKTabItem createUsualItemWithImageEnabled:nil imageDisabled:[UIImage imageNamed:@"wire-transfer"]];
    wireTabItem.titleString = @"Wire Transfer";
    
    //mastercardTabItem.tabState = TabStateEnabled;
    
    self.titledTabsView.darkensBackgroundForEnabledTabs = YES;
    self.titledTabsView.horizontalInsets = HorizontalEdgeInsetsMake(25, 25);
    self.titledTabsView.titlesFontColor = [UIColor colorWithWhite:0.9f alpha:0.8f];
    
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
