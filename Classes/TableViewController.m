//  Created by Rafael Kayumov (RealPoc).
//  Copyright (c) 2013 Rafael Kayumov. License: MIT.

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blurred_background.png"]];
    UIWindow *keyWindow = [UIApplication sharedApplication].windows[0];
    imageView.frame = keyWindow.bounds;
    [keyWindow insertSubview:imageView atIndex:0];
    
    self.view.tintColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setAlpha:0];
    }];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setAlpha:1];
    }];
}

@end
