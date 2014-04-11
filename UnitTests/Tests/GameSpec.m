//
//  GameSpec.m
//  Dove
//
//  Created by Michael Fellows on 4/9/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import "Kiwi.h"
#import "DOVETileView.h"
#import <SpriteKit/SpriteKit.h>

SPEC_BEGIN(GameSpec)

describe(@"Game Spec", ^{
    describe(@"tile view", ^{
        DOVETileView *tileView = [[DOVETileView alloc] init];
        [[tileView shouldNot] beNil];
        [[tileView should] beKindOfClass:[SKView class]];
        
        it(@"should have a white background", ^{
            [[tileView.backgroundColor should] equal:[UIColor whiteColor]];
            
        });
    });
});

SPEC_END
