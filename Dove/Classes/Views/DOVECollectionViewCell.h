//
//  DOVECollectionViewCell.h
//  Dove
//
//  Created by Michael Fellows on 4/9/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DOVECollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *label; 
@property (nonatomic, assign) BOOL hidden;

@end
