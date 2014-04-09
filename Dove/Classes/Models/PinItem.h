//
//  PinItem.h
//  Dove
//
//  Created by Michael Fellows on 4/9/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PinItem : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *caption; 

- (id)initWithImage:(UIImage *)image caption:(NSString *)caption; 

@end
