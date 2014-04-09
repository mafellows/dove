//
//  DOVECollectionViewCell.m
//  Dove
//
//  Created by Michael Fellows on 4/9/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import "DOVECollectionViewCell.h"

@implementation DOVECollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kBLScreenWidth / 2, kBLScreenWidth / 2)];
        [self addSubview:imageView];
        
        self.imageView = imageView;
    }
    return self;
}

@end
