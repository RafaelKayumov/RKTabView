//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. License: MIT.

#import "ButtonItemsExampleController.h"

#import "RKTabView.h"

@interface ButtonItemsExampleController ()
@property (nonatomic, strong) IBOutlet RKTabView* tabViewSocial;
@end

@implementation ButtonItemsExampleController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Button items example";
    
    RKTabItem *tabItemGooglePlus = [RKTabItem createButtonItemWithImage:[UIImage imageNamed:@"googleplus"] target:self selector:@selector(buttonTabPressed:)];
    RKTabItem *facebook = [RKTabItem createButtonItemWithImage:[UIImage imageNamed:@"facebook"] target:self selector:@selector(buttonTabPressed:)];
    RKTabItem *flickr = [RKTabItem createButtonItemWithImage:[UIImage imageNamed:@"flickr"] target:self selector:@selector(buttonTabPressed:)];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureTriggered)];
    gesture.numberOfTapsRequired = 2;
    RKTabItem *customGestureTwitter = [RKTabItem createItemWithImage:[UIImage imageNamed:@"twitter"] gesture:gesture];
    
    self.tabViewSocial.horizontalInsets = HorizontalEdgeInsetsMake(70, 70);

    self.tabViewSocial.drawSeparators = YES;
    self.tabViewSocial.upperSeparatorLineColor = [UIColor colorWithWhite:0.0 alpha:0.2f];
    self.tabViewSocial.lowerSeparatorLineColor = [UIColor colorWithWhite:0.5 alpha:0.6f];
    
    [self.tabViewSocial setTabItems:@[tabItemGooglePlus, facebook, flickr,  customGestureTwitter]];
}

- (void)gestureTriggered {
    NSLog(@"Gesture triggered!");
}

#pragma mark - Button handler

- (void)buttonTabPressed:(id)sender {
    NSLog(@"Button %@ has been pressed in tabView", sender);
}

@end
