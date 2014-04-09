//
//  GameViewController.m
//  Dove
//
//  Created by Michael Fellows on 4/9/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"game"];
        self.navigationItem.title = @"Tap Tap Dove";
        UIBarButtonItem *trophyButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"trophy"] style:UIBarButtonItemStylePlain target:self action:@selector(showAchievements:)];
        self.navigationItem.rightBarButtonItem = trophyButton;
    }
    return self;
}

#pragma mark - Selector

- (void)showAchievements:(id)sender
{
    // Show achievement view controller
}

@end
