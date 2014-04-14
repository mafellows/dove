//
//  AchievementViewController.m
//  Dove
//
//  Created by Michael Fellows on 4/14/14.
//  Copyright (c) 2014 Broadway Lab Inc. All rights reserved.
//

#import "AchievementViewController.h"
#import "SAMGradientView.h"

@interface AchievementViewController ()

@property (nonatomic, assign) NSInteger highScore;

@end

@implementation AchievementViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.highScore = 0; // FIXME: User NSUserDefaults...
    }
    
    return self;
}

- (void)loadView
{
    SAMGradientView *backgroundView = [[SAMGradientView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    backgroundView.gradientColors = @[ [UIColor purpleColor],
                                       [UIColor colorWithRed:88 / 255 green:86 / 255 blue:214 / 255 alpha:1.0f] ];
    backgroundView.gradientLocations = @[ @0.8, @1.0 ];
    self.view = backgroundView;
    
    CGFloat padding = 10.0f;
    CGRect labelFrame = CGRectMake(padding, 100.0f, kBLScreenWidth - 2 * padding, 60.0f);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = [NSString stringWithFormat:@"High Score:\n%d", self.highScore];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
