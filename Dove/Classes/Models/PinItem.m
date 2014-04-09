//
//  PinItem.m
//  Dove
//
//  Created by Michael Fellows on 4/9/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import "PinItem.h"

@implementation PinItem

- (id)initWithImage:(UIImage *)image caption:(NSString *)caption
{
    self = [super init];
    if (self) {
        self.image = image;
        self.caption = caption; 
    }
    
    return self;
}

@end
