//
//  DieObject.h
//  Farkle
//
//  Created by Steve Hudson on 5/19/13.
//  Copyright (c) 2013 Steve Hudson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DieObject : NSObject

@property int value;
@property BOOL active;

- (void) roll;

@end
