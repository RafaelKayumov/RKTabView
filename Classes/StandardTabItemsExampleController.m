//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. License: MIT.

#import "StandardTabItemsExampleController.h"

#import "RKTabView.h"

@interface StandardTabItemsExampleController () <RKTabViewDelegate>
@property (nonatomic, strong) IBOutlet RKTabView *standardView;
@end

@implementation StandardTabItemsExampleController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Standard items example";
    
    RKTabItem *filtersTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"tab_filters_enabled"] imageDisabled:[UIImage imageNamed:@"tab_filters_disabled"]];
    filtersTabItem.tabState = TabStateEnabled;
    
    RKTabItem *frameTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"tab_frame_enabled"] imageDisabled:[UIImage imageNamed:@"tab_frame_disabled"]];
    RKTabItem *rotateTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"tab_rotate_enabled"] imageDisabled:[UIImage imageNamed:@"tab_rotate_disabled"]];
    RKTabItem *contrastTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"tab_contrast_enabled"] imageDisabled:[UIImage imageNamed:@"tab_contrast_disabled"]];
    RKTabItem *brightnessTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"tab_brightness_enabled"] imageDisabled:[UIImage imageNamed:@"tab_brightness_disabled"]];
    RKTabItem *blurTabItem = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"tab_blur_enabled"] imageDisabled:[UIImage imageNamed:@"tab_blur_disabled"]];
    
    self.standardView.horizontalInsets = HorizontalEdgeInsetsMake(25, 25);
    
    self.standardView.darkensBackgroundForEnabledTabs = YES;
    self.standardView.drawSeparators = YES;
    self.standardView.tabItems = @[filtersTabItem, frameTabItem, rotateTabItem, contrastTabItem, brightnessTabItem,  blurTabItem];
}

#pragma mark - RKTabViewDelegate

- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %d became enabled on tab view", index);
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem {
    NSLog(@"Tab № %d became disabled on tab view", index);
}

@end
