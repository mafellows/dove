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
        self.hidden = YES;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kBLScreenWidth / 2, kBLScreenWidth / 2)];
        [self addSubview:imageView];
        
        UIView *tintview = [[UIView alloc] initWithFrame:imageView.bounds];
        tintview.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
        [imageView addSubview:tintview];
        
        UILabel *label = [[UILabel alloc] initWithFrame:tintview.bounds];
        label.numberOfLines = 2;
        label.font = [UIFont fontWithName:@"Helvetica-Light" size:18.0f];
        label.textColor = [UIColor whiteColor];
        label.text = @"Test";
        [tintview addSubview:label];
        
        
        
        tintview.hidden = self.hidden;
        self.imageView = imageView;
    }
    return self;
}

@end
