//
//  DOVEScene.m
//  Dove
//
//  Created by Michael Fellows on 4/11/14.
//  Copyright (c) 2014 Broadway Lab Inc. All rights reserved.
//

#import "DOVEScene.h"

@interface DOVEScene ()

@end

@implementation DOVEScene

- (void)didMoveToView:(SKView *)view
{
    self.backgroundColor = [UIColor whiteColor];
    [self generateRandomNode];
}

- (void)generateRandomNode
{
    NSArray *nodes = [self allNodes];
    NSUInteger randomNumber = arc4random() % nodes.count;
    self.imageNode = [nodes objectAtIndex:randomNumber];
    [self addChild:self.imageNode];
    
    SKAction *fadeOut = [SKAction fadeAlphaTo:0.0f duration:2.0];
    [self.imageNode runAction:fadeOut completion:^{
        [self generateRandomNode];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    SKNode *node = [self nodeAtPoint:touchLocation];
    NSLog(@"Touched this node: %@", node.name);
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
    
    return nodes;
}

@end
