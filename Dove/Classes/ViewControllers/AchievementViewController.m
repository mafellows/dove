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
        self.highScore = [[NSUserDefaults standardUserDefaults] integerForKey:kHighScore]; 
    }
    
    return self;
}

- (void)loadView
{
    SAMGradientView *backgroundView = [[SAMGradientView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    backgroundView.gradientColors = @[ [UIColor colorWithRed:198.0f / 255.0f green:68.0f / 255.0f blue:252.0f / 255.0f alpha:1.0f],
                                       [UIColor colorWithRed:88.0f / 255.0f green:86.0f / 255.0f blue:214.0f / 255.0f alpha:1.0f] ];
    self.view = backgroundView;
    
    CGFloat padding = 10.0f;
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.frame = CGRectMake(padding, padding + 20.0f, 36.0f, 36.0f);
    [dismissButton setImage:[UIImage imageNamed:@"x-circle"] forState:UIControlStateNormal];
    [dismissButton addTarget:self
                      action:@selector(dismiss:)
            forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:dismissButton];
    
    CGRect labelFrame = CGRectMake(padding, 100.0f, kBLScreenWidth - 2 * padding, 60.0f);
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    label.text = [NSString stringWithFormat:@"High Score:\n%d", self.highScore];
    label.numberOfLines = 2;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont fontWithName:@"Helvetica-Light" size:24.0f];
    label.textColor = [UIColor whiteColor];
    [backgroundView addSubview:label];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - selector

- (void)dismiss:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil]; 
}

@end
