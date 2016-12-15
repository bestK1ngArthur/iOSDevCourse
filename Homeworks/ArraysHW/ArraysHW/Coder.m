//
//  Coder.m
//  ArraysHW
//
//  Created by Artem Belkov on 17/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Coder.h"

@implementation Coder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.skill = @"Junior";
    }
    return self;
}

- (void)move {
    [super move];
    NSLog(@"..and coding");
}

@end
