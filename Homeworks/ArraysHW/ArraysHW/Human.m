//
//  Human.m
//  ArraysHW
//
//  Created by Artem Belkov on 17/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Human.h"

@implementation Human

- (void)move {
    NSLog(@"%@ is moving", self.name);
}

- (NSString *)getInfo {
    
    NSString *info = [NSString stringWithFormat:@"\n%@:\n\tgender: %@\n\theight: %f\n\tweight: %f",
                      self.name,
                      self.gender,
                      self.height,
                      self.weight];
    
    return info;
    
}

@end
