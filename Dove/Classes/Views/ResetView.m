//
//  ResetView.m
//  Dove
//
//  Created by Michael Fellows on 4/14/14.
//  Copyright (c) 2014 Broadway Lab Inc. All rights reserved.
//

#import "ResetView.h"

@implementation ResetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat topPadding = 150.0f;
        CGFloat padding = 20.0f;
        CGFloat labelHeight = 60.0f;
        CGRect labelFrame = CGRectMake(padding, topPadding, kBLScreenWidth - 2 * padding, labelHeight);
        UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
        label.text = @"Not too shabby!\nPlay again?";
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Helvetica-Light" size:24.0f];
        [self addSubview:label];
        
        CGRect buttonFrame = CGRectMake(padding, label.frame.origin.y + labelHeight + padding, kBLScreenWidth - 2 * padding, labelHeight);
        UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        resetButton.frame = buttonFrame;
        [resetButton setTitle:@"Play Again" forState:UIControlStateNormal];
        [resetButton setBackgroundColor:[UIColor purpleColor]];
        [resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        resetButton.layer.cornerRadius = 5;
        resetButton.layer.masksToBounds = YES; 
        [self addSubview:resetButton];
        self.resetButton = resetButton;
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    }
    return self;
}

@end
