//
//  DOVEScene.h
//  Dove
//
//  Created by Michael Fellows on 4/11/14.
//  Copyright (c) 2014 Broadway Lab Inc. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DOVEScene : SKScene

@property (nonatomic, copy) NSArray *goodImages;
@property (nonatomic, copy) NSArray *badImages;
@property (nonatomic, strong) SKSpriteNode *imageNode; 

@end
