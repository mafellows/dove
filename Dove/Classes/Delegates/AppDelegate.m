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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    GameViewController *gameViewController = [[GameViewController alloc] init];
    PhotoViewController *photoViewController = [[PhotoViewController alloc] init];
    InstagramViewController *instagramViewController = [[InstagramViewController alloc] init];
    TwitterViewController *twitterViewController = [[TwitterViewController alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[ gameViewController, photoViewController, instagramViewController, twitterViewController ];
    self.window.rootViewController = tabBarController; 
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
