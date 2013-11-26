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
    RKTabItem *flickr = [RKTabItem createButtonItemWithImage:[UIImage imageNamed:@"twitter"] target:self selector:@selector(buttonTabPressed:)];
    RKTabItem *twitter = [RKTabItem createButtonItemWithImage:[UIImage imageNamed:@"flickr"] target:self selector:@selector(buttonTabPressed:)];
    
    self.tabViewSocial.horizontalInsets = HorizontalEdgeInsetsMake(70, 70);
    self.tabViewSocial.drawSeparators = YES;
    [self.tabViewSocial setTabItems:@[tabItemGooglePlus, facebook, flickr, twitter]];
}

#pragma mark - Button handler

- (void)buttonTabPressed:(id)sender {
    NSLog(@"Button %@ has been pressed in tabView", sender);
}

@end
