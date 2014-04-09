//
//  AppDelegate.m
//  Dove
//
//  Created by Michael Fellows on 4/9/14
//  Copyright (c) 2014 Broadway Lab, Inc.. All rights reserved.
//

#import "AppDelegate.h"
#import "GameViewController.h"
#import "PhotoViewController.h"
#import "InstagramViewController.h"
#import "TwitterViewController.h"
#import "MFBaseNavigationController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    GameViewController *gameViewController = [[GameViewController alloc] init];
    MFBaseNavigationController *gameNav = [[MFBaseNavigationController alloc] initWithRootViewController:gameViewController];

    PhotoViewController *photoViewController = [[PhotoViewController alloc] init];
    MFBaseNavigationController *photoNav = [[MFBaseNavigationController alloc] initWithRootViewController:photoViewController];
    
    InstagramViewController *instagramViewController = [[InstagramViewController alloc] init];
    MFBaseNavigationController *instagramNav = [[MFBaseNavigationController alloc] initWithRootViewController:instagramViewController];
    
    TwitterViewController *twitterViewController = [[TwitterViewController alloc] init];
    MFBaseNavigationController *twitterNav = [[MFBaseNavigationController alloc] initWithRootViewController:twitterViewController];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[ gameNav, photoNav, instagramNav, twitterNav ];
    self.window.rootViewController = tabBarController; 
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
