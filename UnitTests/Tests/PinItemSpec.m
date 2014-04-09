//
//  PinItemSpec.m
//  Dove
//
//  Created by Michael Fellows on 4/9/14.
//  Copyright (c) 2014 Broadway Lab, Inc. All rights reserved.
//

#import "Kiwi.h"
#import "PinItem.h"

SPEC_BEGIN(PinItemSpec)

describe(@"PinItem", ^{
    
    __block PinItem *_pinItem;
    
    beforeAll(^{
        _pinItem = [[PinItem alloc] initWithImage:[UIImage imageNamed:@"dove-beach"] caption:@"Hello World"];
    });
    
    it(@"should have a photo", ^{
        [[_pinItem.image shouldNot] beNil];
        [[_pinItem.image should] beKindOfClass:[UIImage class]];
    });
    
    it(@"should have a caption", ^{
        [[_pinItem.caption shouldNot] beNil];
        [[_pinItem.caption should] beKindOfClass:[NSString class]];
    });
});

SPEC_END
