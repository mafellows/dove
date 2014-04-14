//
//  GameViewController.m
//  Dove
//
//  Created by Michael Fellows on 4/9/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import "GameViewController.h"
#import "DOVETileView.h"
#import "DOVEScene.h"
#import "ResetView.h"

#define kTileDiameter 100.0f

@interface GameViewController () {
    CGFloat _padding;
}

@property (nonatomic, copy) NSArray *images;
@property (nonatomic, weak) SKScene *scene;
@property (nonatomic, assign) NSInteger points;
@property (nonatomic, assign) NSInteger lives;
@property (nonatomic, weak) UILabel *scoreLabel;
@property (nonatomic, weak) UILabel *livesLabel;
@property (nonatomic, weak) ResetView *resetView;

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
        self.tabBarItem.image = [UIImage imageNamed:@"game"];
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"trophy"]
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(showAchievements:)];
        self.navigationItem.rightBarButtonItem = rightBarButton; 
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addCircleViews];
    [self registerNotifications];
    [self addLabels];
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
}

#pragma mark - Helper

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

#pragma mark - Selector

- (void)showAchievements:(id)sender
{
    // Show achievement view controller
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
        self.lives -= 1;
        self.livesLabel.text = [NSString stringWithFormat:@"Lives: %d", self.lives];
        if (self.lives <= 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kGameOver
                                                                object:self];
            ResetView *resetView = [[ResetView alloc] initWithFrame:self.view.bounds];
            [resetView.resetButton addTarget:self
                                      action:@selector(resetGame:)
                            forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:resetView];
            [self.view bringSubviewToFront:resetView];
            self.resetView = resetView;
        }
    }
}

- (void)resetGame:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kResetGame
                                                        object:self];
    [self.resetView removeFromSuperview];
    self.lives = 3;
    self.points = 0;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.points];
    self.livesLabel.text = [NSString stringWithFormat:@"Lives: %d", self.lives];
}

@end
