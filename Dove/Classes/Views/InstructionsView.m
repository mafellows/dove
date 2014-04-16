//
//  InstructionsView.m
//  Dove
//
//  Created by Michael Fellows on 4/16/14.
//  Copyright (c) 2014 Broadway Lab Inc. All rights reserved.
//

#import "InstructionsView.h"
#import "DOVETileView.h"

@implementation InstructionsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat padding = 20.0f;
        CGFloat labelHeight = 50.0f;
        CGRect topLabelFrame = CGRectMake(padding, padding, kBLScreenWidth - 2 * padding, labelHeight);
        UILabel *topLabel = [[UILabel alloc] initWithFrame:topLabelFrame];
        topLabel.text = @"Tap the pictures of Dove to earn points.";
        topLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        topLabel.textColor = [UIColor whiteColor];
        topLabel.numberOfLines = 2;
        topLabel.lineBreakMode = NSLineBreakByWordWrapping;
        topLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:topLabel];
        
        CGFloat x;
        CGFloat y = labelHeight + padding;
        CGFloat tilePadding = 10.0f;
        CGFloat tileWidth = 100.0f;
        NSArray *images = @[ [UIImage imageNamed:@"good-dove"], [UIImage imageNamed:@"dove-good-2"], [UIImage imageNamed:@"dove-good-3"] ];
        for (int i = 0 ; i < 3; i++) {
            x = tileWidth * i;
        
            DOVETileView *tileView = [[DOVETileView alloc] initWithFrame:CGRectMake(tilePadding + x, padding + y, tileWidth, tileWidth)];
            tileView.backgroundColor = [UIColor whiteColor];
            [self addSubview:tileView];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:tileView.bounds];
            imageView.image = [images objectAtIndex:i];
            [tileView addSubview:imageView];
        }
        
        CGRect bottomLabelFrame = CGRectMake(padding, tileWidth + labelHeight + 3 * padding, kBLScreenWidth - 2 * padding, labelHeight);
        UILabel *bottomLabel = [[UILabel alloc] initWithFrame:bottomLabelFrame];
        bottomLabel.text = @"Tap other pictures to lose a life.";
        bottomLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        bottomLabel.textColor = [UIColor whiteColor];
        bottomLabel.numberOfLines = 2;
        bottomLabel.lineBreakMode = NSLineBreakByWordWrapping;
        bottomLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:bottomLabel];
        
        CGFloat badY = bottomLabelFrame.origin.y + labelHeight + padding;
        CGFloat largePadding = 40.0f;
        NSArray *badImages = @[ [UIImage imageNamed:@"bad-emmie"], [UIImage imageNamed:@"bad-joey"] ];
        for (int i = 0; i < 2; i++) {
            CGFloat badX = largePadding + largePadding * i + tileWidth * i;
            DOVETileView *tileView = [[DOVETileView alloc] initWithFrame:CGRectMake(badX, badY, tileWidth, tileWidth)];
            tileView.backgroundColor = [UIColor whiteColor];
            [self addSubview:tileView];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:tileView.bounds];
            imageView.image = [badImages objectAtIndex:i];
            [tileView addSubview:imageView];
        }
        
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame = CGRectMake(padding, bottomLabelFrame.origin.y + labelHeight + 2 * padding + tileWidth, kBLScreenWidth - 2 * padding, labelHeight);
        [doneButton setTitle:@"Get Started!" forState:UIControlStateNormal];
        [doneButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        doneButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        doneButton.backgroundColor = [UIColor whiteColor];
        doneButton.layer.cornerRadius = 10.0f;
        doneButton.layer.masksToBounds = YES;
        [self addSubview:doneButton];
        self.finishedButton = doneButton;
    }
    return self;
}

@end
