//
//  DOVEScene.m
//  Dove
//
//  Created by Michael Fellows on 4/11/14.
//  Copyright (c) 2014 Broadway Lab Inc. All rights reserved.
//

#import "DOVEScene.h"

@interface DOVEScene ()

@property (nonatomic, assign) BOOL gameOver;
@property (nonatomic, assign) NSInteger lives;
@property (nonatomic, assign) NSInteger points;

@end

@implementation DOVEScene

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        self.gameOver = NO;
        self.lives = 3;
        self.points = 0;
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
        SKAction *fadeOut = [SKAction fadeAlphaTo:0.0f duration:0.1];
        
        [self.imageNode runAction:fadeOut completion:^{
            sleep(1); 
            [self generateRandomNode];
        }];
    } else {
        [self resetGame];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:touchLocation];
    if ([node.name isEqualToString:@"good"]) {
        self.points += 10;
        NSLog(@"%d", self.points);
    } else if ([node.name isEqualToString:@"bad"]) {
        [self removeLife];
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

- (void)resetGame
{
    self.lives = 3;
    self.gameOver = NO;
}

- (void)removeLife
{
    self.lives -= 1;
    if (self.lives <= 0) {
        self.gameOver = YES;
        NSLog(@"Game Over. Here's your score: %d", self.points);
    }
}

@end
