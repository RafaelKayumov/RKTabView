//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. All rights reserved.

#import "ViewController.h"
#import "RKTabItem.h"
#import "RKTabView.h"

@interface ViewController () <RKTabViewDelegate>

@property (nonatomic, strong) IBOutlet RKTabView* tabView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    RKTabItem *tabItem1 = [RKTabItem createButtonItemWithImage:[UIImage imageNamed:@"text-book-disabled"] target:nil selector:nil];
    RKTabItem *tabItem2 = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"photo-enabled"] imageDisabled:[UIImage imageNamed:@"photo-disabled"]];
    RKTabItem *tabItem3 = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"calendar-enabled"] imageDisabled:[UIImage imageNamed:@"calendar-disabled"]];
    RKTabItem *tabItem4 = [RKTabItem createUnexcludableItemWithImageEnabled:[UIImage imageNamed:@"circle-enabled"] imageDisabled:[UIImage imageNamed:@"circle-disabled"]];
    
    [self.tabView setTabItems:@[tabItem1, tabItem2, tabItem3, tabItem4]];
    self.tabView.drawSeparators = YES;
    self.tabView.darkensBackgroundForEnabledTabs = YES;
}

#pragma mark - RKTabViewDelegate

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %d became enabled on tab view", index);
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %d became disabled on tab view", index);
}

@end
