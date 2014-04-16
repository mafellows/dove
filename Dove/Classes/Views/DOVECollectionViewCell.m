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
        
        UIView *tintview = [[UIView alloc] initWithFrame:CGRectMake(0, 120, frame.size.width, frame.size.height - 120)];
        tintview.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
        [imageView addSubview:tintview];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5.0f, 0.0f, frame.size.width - 10.0f, tintview.frame.size.height)];
        label.numberOfLines = 2;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Helvetica-Light" size:12.0f];
        label.textColor = [UIColor whiteColor];
        label.text = @"Test";
        [tintview addSubview:label];
        self.imageView = imageView;
        self.label = label;
    }

    return self;
}

@end
