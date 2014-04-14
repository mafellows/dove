//
//  DOVEScene.m
//  Dove
//
//  Created by Michael Fellows on 4/11/14.
//  Copyright (c) 2014 Broadway Lab Inc. All rights reserved.
//

#import "DOVEScene.h"

@interface DOVEScene () {
    int secondsCount;
}

@property (nonatomic, assign) BOOL gameOver;
@property (nonatomic, assign) NSInteger duration;

@end

@implementation DOVEScene

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        self.gameOver = NO;
        self.userData = [NSMutableDictionary dictionary];
        [self registerNotifications];
        secondsCount = 1800;
}
    
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    self.backgroundColor = [UIColor whiteColor];
    [self generateRandomNode];
}

- (void)generateRandomNode
{
    if (!self.gameOver) {
        NSArray *nodes = [self allNodes];
        NSUInteger randomNumber = arc4random() % nodes.count;
        self.imageNode = [nodes objectAtIndex:randomNumber];
        [self addChild:self.imageNode];
        
        SKAction *setTappable = [SKAction runBlock:^{
            [self.userData setObject:@1 forKey:kTappable];
        }];
        
        self.duration = [[NSUserDefaults standardUserDefaults] integerForKey:kDuration];
        
        SKAction *begin = [SKAction waitForDuration:0.1 withRange:1.0];
        SKAction *fadeIn = [SKAction fadeInWithDuration:0.2];
        SKAction *wait = [SKAction waitForDuration:self.duration];
        SKAction *fadeOut = [SKAction fadeOutWithDuration:0.2];
        
        SKAction *sequence = [SKAction sequence:@[ begin, setTappable, fadeIn, wait, fadeOut ]];
        [self.imageNode runAction:sequence completion:^{
            [self generateRandomNode];
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    BOOL tappable = [[self.userData objectForKey:kTappable] boolValue];
    
    SKNode *node = [self nodeAtPoint:touchLocation];
    if ([node.name isEqualToString:@"good"] && tappable) {
        [self incrementScore];
        [self makeUntappable];
    } else if ([node.name isEqualToString:@"bad"] && tappable) {
        [self removeLife];
        [self makeUntappable];
    }
}

- (NSArray *)allNodes
{
    NSMutableArray *nodes = [NSMutableArray array];
    
    SKSpriteNode *goodNode = [SKSpriteNode spriteNodeWithImageNamed:@"dove-friend"];
    goodNode.name = @"good";
    [nodes addObject:goodNode];
    
    SKSpriteNode *badNode = [SKSpriteNode spriteNodeWithImageNamed:@"dove-man"];
    badNode.name = @"bad";
    [nodes addObject:badNode];
    
    SKSpriteNode *nothingNode = [SKSpriteNode spriteNodeWithImageNamed:@"twitter"];
    nothingNode.name = @"nothing";
    [nodes addObject:nothingNode];
    
    return nodes;
}

#pragma mark - Helpers

- (void)incrementScore
{
    self.imageNode.color = [UIColor greenColor];
    self.imageNode.colorBlendFactor = 0.5;
    [[NSNotificationCenter defaultCenter] postNotificationName:kIncrementScore
                                                        object:self];
}

- (void)removeLife
{
    self.imageNode.color = [UIColor redColor];
    self.imageNode.colorBlendFactor = 0.5;
    [[NSNotificationCenter defaultCenter] postNotificationName:kRemoveLife
                                                        object:self];
}

- (void)makeUntappable
{
    [self.userData setObject:@0
                      forKey:kTappable];
}

- (void)registerNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kGameOver
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gameOver:)
                                                 name:kGameOver
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kResetGame
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resetGame:)
                                                 name:kResetGame
                                               object:nil];
}

#pragma mark - Selectors

- (void)gameOver:(NSNotification *)notificaiton
{
    if ([[notificaiton name] isEqualToString:kGameOver]) {
        self.gameOver = YES;
    }
}

- (void)resetGame:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:kResetGame]) {
        self.gameOver = NO;
        [self generateRandomNode];
    }
}

@end
