//
//  Cheetah.m
//  ProtocolsHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Cheetah.h"

@implementation Cheetah

- (void)sayInfo {
    NSLog(@"Cheetah %@ is runner", self.name);
}

#pragma mark- Runners

- (void)run {
    NSLog(@"%@ is running", self.name);
}

@end
