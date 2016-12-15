//
//  Swimmer.m
//  ProtocolsHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Swimmer.h"

@implementation Swimmer

- (void)sayInfo {
    NSLog(@"Human %@ is swimmer", self.name);
}

#pragma mark- Swimmers

- (void)run {
    NSLog(@"%@ is running", self.name);
}

- (void)swim {
    NSLog(@"%@ is swimming", self.name);
}

- (void)dive {
    NSLog(@"%@ is diving", self.name);
}

@end
