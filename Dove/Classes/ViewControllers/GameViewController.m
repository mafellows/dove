//
//  GameViewController.m
//  Dove
//
//  Created by Michael Fellows on 4/9/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import "GameViewController.h"
#import "AchievementViewController.h"
#import "DOVEInstructionsViewController.h"
#import "DOVETileView.h"
#import "DOVEScene.h"
#import "ResetView.h"
#import <AudioToolbox/AudioToolbox.h>

#define kTileDiameter 100.0f

@interface GameViewController () {
    CGFloat _padding;
    int secondsCount;
}

@property (nonatomic, copy) NSArray *images;
@property (nonatomic, weak) SKScene *scene;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, assign) NSInteger lives;
@property (nonatomic, weak) UILabel *scoreLabel;
@property (nonatomic, weak) UILabel *livesLabel;
@property (nonatomic, strong) ResetView *resetView;

@end

@implementation GameViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.points = 0;
        self.lives = 3;
        
        _padding = 10.0f;
        self.navigationItem.title = @"Dove Dove Tap";
        self.tabBarItem.image = [UIImage imageNamed:@"trophy-tab"]; 
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"trophy"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(showAchievements:)];
        self.navigationItem.rightBarButtonItem = rightBarButton;
        
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"_info"]
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(showInstructions:)];
        self.navigationItem.leftBarButtonItem = leftBarButton;
        
    }
    return self;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self gameOver];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addCircleViews];
    [self registerNotifications];
    [self addLabels];
    [self setDuration];
    [self setUpTimer];
}

#pragma mark - Notifications

- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kIncrementScore
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(incrementScore:)
                                                 name:kIncrementScore
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kRemoveLife
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeLife:)
                                                 name:kRemoveLife
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kPauseGame
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pauseGame:)
                                                 name:kPauseGame
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kResumeGame
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resumeGame:)
                                                 name:kResumeGame
                                               object:nil];
}

#pragma mark - Helper

- (void)setUpTimer
{
    secondsCount = 1800;
    [NSTimer scheduledTimerWithTimeInterval:20.0
                                     target:self
                                   selector:@selector(runTimer:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)addCircleViews
{
    CGFloat x;
    CGFloat y;
    for (int i = 0 ; i < 9; i++) {
        if (i < 3) {
            x = kTileDiameter * i;
            y = 0;
        } else if (i >= 3 && i < 6) {
            x = kTileDiameter * (i - 3);
            y = kTileDiameter;
        } else if (i >= 6) {
            x = kTileDiameter * (i - 6);
            y = 2*kTileDiameter;
        }
        
        DOVETileView *tileView = [[DOVETileView alloc] initWithFrame:CGRectMake(_padding + x, _padding + y, kTileDiameter, kTileDiameter)];
        tileView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:tileView];
        
        DOVEScene *scene = [[DOVEScene alloc] initWithSize:tileView.frame.size];
        scene.scaleMode = UIViewContentModeScaleAspectFill;
        scene.anchorPoint = CGPointMake(0.5, 0.5); 
        [tileView presentScene:scene];
    }
}

- (void)addLabels
{
    CGFloat labelHeight = 30.0f;
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(2 * _padding, kBLScreenWidth, kBLScreenWidth / 2.0f, labelHeight)];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.points];
    scoreLabel.textColor = [UIColor purpleColor];
    scoreLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:scoreLabel];
    self.scoreLabel = scoreLabel;
    
    UILabel *livesLabel = [[UILabel alloc] initWithFrame:CGRectMake(kBLScreenWidth / 2.0f, kBLScreenWidth, (kBLScreenWidth / 2.0f) - 2 * _padding, labelHeight)];
    livesLabel.text = [NSString stringWithFormat:@"Lives: %d", self.lives];
    livesLabel.textColor = [UIColor purpleColor];
    livesLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:livesLabel];
    self.livesLabel = livesLabel;
}

- (void)setDuration
{
    [[NSUserDefaults standardUserDefaults] setFloat:2.6
                                             forKey:kDuration];
}

#pragma mark - Selector

- (void)showAchievements:(id)sender
{
    AchievementViewController *achievementVC = [[AchievementViewController alloc] init];
    [self presentViewController:achievementVC
                       animated:YES
                     completion:nil];
}

- (void)showInstructions:(id)sender
{
    DOVEInstructionsViewController *instructionsVC = [[DOVEInstructionsViewController alloc] init];
    [self presentViewController:instructionsVC animated:YES completion:nil]; 
}

- (void)incrementScore:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:kIncrementScore]) {
        self.points += 10;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.points];
    }
}

- (void)removeLife:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:kRemoveLife]) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); 
        self.lives -= 1;
        self.livesLabel.text = [NSString stringWithFormat:@"Lives: %d", self.lives];
        if (self.lives <= 0) {
            [self gameOver];
        }
    }
}

- (void)resetGame:(id)sender
{
    NSInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:kHighScore];
    
    if (self.points > highScore) {
        [[NSUserDefaults standardUserDefaults] setInteger:self.points
                                                   forKey:kHighScore];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kResetGame
                                                        object:self];
    [self.resetView removeFromSuperview];
    [self setDuration];
    
    self.lives = 3;
    self.points = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.points];
    self.livesLabel.text = [NSString stringWithFormat:@"Lives: %d", self.lives];
}

- (void)runTimer:(NSTimer *)timer
{
    secondsCount -= 20;
    CGFloat duration = [[NSUserDefaults standardUserDefaults] floatForKey:kDuration];
    NSLog(@"%f", duration);
    if (duration > 0.2) {
        duration -= 0.2;
        [[NSUserDefaults standardUserDefaults] setFloat:duration forKey:kDuration];
    }
}

- (void)gameOver
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGameOver
                                                        object:self];
    [self.resetView removeFromSuperview];
    self.resetView = [[ResetView alloc] initWithFrame:self.view.bounds];
    [self.resetView.resetButton addTarget:self
                                   action:@selector(resetGame:)
                         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.resetView];
    [self.view bringSubviewToFront:self.resetView];
}

- (void)pauseGame:(NSNotification *)notification
{
    
}

- (void)resumeGame:(NSNotification *)notification
{
    
}

@end
