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

#define kTileDiameter 100.0f

@interface GameViewController () {
    CGFloat _padding;
}

@property (nonatomic, copy) NSArray *images;
@property (nonatomic, weak) SKScene *scene;

@end

@implementation GameViewController

- (id)init
{
    self = [super init];
    if (self) {
        _padding = 10.0f;
        self.navigationItem.title = @"Dove Dove Tap";
        self.tabBarItem.image = [UIImage imageNamed:@"game"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addCircleViews]; 
}

#pragma mark - Helper

- (void)addCircleViews
{
    CGFloat x;
    CGFloat y;
    NSUInteger index = 0;
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

#pragma mark - Selector

- (void)showAchievements:(id)sender
{
    // Show achievement view controller
}

@end
