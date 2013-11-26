//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. License: MIT.

#import "UnexcludableTabsExampleController.h"

#import "RKTabView.h"

@interface UnexcludableTabsExampleController () <RKTabViewDelegate>
@property (nonatomic, strong) IBOutlet RKTabView *unexcludableTabsView;
@end

@implementation UnexcludableTabsExampleController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.title = @"Unexcludable tabs view";
    
    RKTabItem *globeTabItem = [RKTabItem createUnexcludableItemWithImageEnabled:[UIImage imageNamed:@"globe_enabled"] imageDisabled:[UIImage imageNamed:@"globe_disabled"]];
    RKTabItem *cameraTabItem = [RKTabItem createUnexcludableItemWithImageEnabled:[UIImage imageNamed:@"camera_enabled"] imageDisabled:[UIImage imageNamed:@"camera_disabled"]];
    RKTabItem *cloudTabItem = [RKTabItem createUnexcludableItemWithImageEnabled:[UIImage imageNamed:@"cloud_enabled"] imageDisabled:[UIImage imageNamed:@"cloud_disabled"]];
    RKTabItem *userTabItem = [RKTabItem createUnexcludableItemWithImageEnabled:[UIImage imageNamed:@"user_enabled"] imageDisabled:[UIImage imageNamed:@"user_disabled"]];
    RKTabItem *watchTabItem = [RKTabItem createUnexcludableItemWithImageEnabled:[UIImage imageNamed:@"watch_enabled"] imageDisabled:[UIImage imageNamed:@"watch_disabled"]];
    
    self.unexcludableTabsView.horizontalInsets = HorizontalEdgeInsetsMake(40, 40);
    
    self.unexcludableTabsView.enabledTabBackgrondColor = [UIColor colorWithRed:103.0f/256.0f green:87.0f/256.0f blue:226.0f/256.0f alpha:0.5];
    self.unexcludableTabsView.tabItems = @[globeTabItem, cameraTabItem, cloudTabItem, userTabItem, watchTabItem];
}

#pragma mark - RKTabViewDelegate

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %d became enabled on tab view", index);
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %d became disabled on tab view", index);
}

@end
