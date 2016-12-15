//
//  Kangaroo.m
//  ProtocolsHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Kangaroo.h"

@implementation Kangaroo

- (void)sayInfo {
    NSLog(@"%@ kangaroo %@ is jumper", self.color, self.name);
}

#pragma mark- Jumpers

- (void)jump {
    NSLog(@"%@ is jumping", self.name);
}

@end
