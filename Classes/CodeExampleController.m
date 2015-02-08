//
//  CodeExampleController.m
//  RKTabView
//
//  Created by Rafael Kayumov on 08.02.15.
//  Copyright (c) 2015 Rafael Kayumov. All rights reserved.
//

#import "CodeExampleController.h"

#import "RKTabView.h"

@implementation CodeExampleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Code implementation example";
    
    RKTabItem *tabItemGooglePlus = [RKTabItem createButtonItemWithImage:[UIImage imageNamed:@"googleplus"] target:self selector:@selector(buttonTabPressed:)];
    RKTabItem *facebook = [RKTabItem createButtonItemWithImage:[UIImage imageNamed:@"facebook"] target:self selector:@selector(buttonTabPressed:)];
    RKTabItem *flickr = [RKTabItem createButtonItemWithImage:[UIImage imageNamed:@"twitter"] target:self selector:@selector(buttonTabPressed:)];
    RKTabItem *twitter = [RKTabItem createButtonItemWithImage:[UIImage imageNamed:@"flickr"] target:self selector:@selector(buttonTabPressed:)];
    
    RKTabView* tabView = [[RKTabView alloc] initWithFrame:CGRectMake(0, 248, 320, 72)
                                              andTabItems:@[
                                                             tabItemGooglePlus,
                                                             facebook,
                                                             flickr,
                                                             twitter
                                                             ]];
    tabView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1f];
    tabView.horizontalInsets = HorizontalEdgeInsetsMake(70, 70);
    tabView.drawSeparators = YES;
    [self.view addSubview:tabView];
    
    //autolayout configuration
    [tabView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSDictionary *views = @{@"tabView" : tabView};
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tabView]|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:views];
    NSArray *heightConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[tabView(==72)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:views];
    NSLayoutConstraint *verticalCenterConstraint = [NSLayoutConstraint constraintWithItem:tabView
                                                                                attribute:NSLayoutAttributeCenterY
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:tabView.superview
                                                                                attribute:NSLayoutAttributeCenterY
                                                                               multiplier:1.0f
                                                                                 constant:0.0f];
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:heightConstraint];
    [self.view addConstraint:verticalCenterConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonTabPressed:(id)sender {
    NSLog(@"Button %@ has been pressed in tabView", sender);
}

@end
