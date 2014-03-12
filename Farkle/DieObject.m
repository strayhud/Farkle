//
//  DieObject.m
//  Farkle
//
//  Created by Steve Hudson on 5/19/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import "DieObject.h"

@implementation DieObject


@synthesize value = _value;
@synthesize active = _active;


- (NSInteger)randInt:(NSInteger)n {
    return ((arc4random() % (n))+1);
}

- (void)roll {
    _value = [self randInt:6];
}


- (id) init
{
    self = [super init];
    if (self) {
        [self roll];
    }
    return self;
}


@end
