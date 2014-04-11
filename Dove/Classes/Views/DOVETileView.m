//
//  DOVETileView.m
//  Dove
//
//  Created by Michael Fellows on 4/9/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import "DOVETileView.h"

@implementation DOVETileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = frame.size.width / 2;
        self.layer.borderColor = [UIColor purpleColor].CGColor;
        self.layer.borderWidth = 1.0f;
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES; 

    }
    
    return self;
}

@end
