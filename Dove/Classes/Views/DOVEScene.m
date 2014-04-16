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
@property (nonatomic, assign) BOOL paused;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, copy) NSArray *nodes;

@end

@implementation DOVEScene

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        self.gameOver = NO;
        self.paused = YES; 
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
    if (!self.gameOver || !self.paused) {
        self.nodes = [self allNodes];
        NSUInteger randomNumber = arc4random() % self.nodes.count;
        self.imageNode = [self.nodes objectAtIndex:randomNumber];
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
    
    SKSpriteNode *goodNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"good-dove"];
    goodNode1.name = @"good";
    [nodes addObject:goodNode1];
    
    SKSpriteNode *goodNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"dove-good-2"];
    goodNode2.name = @"good";
    [nodes addObject:goodNode2];
    
    SKSpriteNode *goodNode3 = [SKSpriteNode spriteNodeWithImageNamed:@"dove-good-3"];
    goodNode3.name = @"good";
    [nodes addObject:goodNode3];
    
    SKSpriteNode *badNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"bad-emmie"];
    badNode1.name = @"bad";
    [nodes addObject:badNode1];
    
    SKSpriteNode *badNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"bad-joey"];
    badNode2.name = @"bad";
    [nodes addObject:badNode2];
    
    SKSpriteNode *nothingNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"nothing"];
    nothingNode1.name = @"nothing";
    [nodes addObject:nothingNode1];
    
    SKSpriteNode *nothingNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"nothing"];
    nothingNode2.name = @"nothing";
    [nodes addObject:nothingNode2];
    
    SKSpriteNode *nothingNode3 = [SKSpriteNode spriteNodeWithImageNamed:@"nothing"];
    nothingNode3.name = @"nothing";
    [nodes addObject:nothingNode3];
    
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
