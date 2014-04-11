//
//  MFBaseNavigationController.m
//  MFToolbelt
//
//  Created by Michael Fellows on 4/8/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import "MFBaseNavigationController.h"

@interface MFBaseNavigationController ()

@end

@implementation MFBaseNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        self.navigationBar.translucent = NO;
        [[UINavigationBar appearance] setTintColor:[UIColor purpleColor]]; // button tint
        [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor purpleColor],
                                                               NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Light" size:18.0]}];
        
    }
    return self;
    
}

#pragma mark - Status Bar Style

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


@end
