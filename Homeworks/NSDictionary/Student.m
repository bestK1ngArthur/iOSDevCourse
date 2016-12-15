//
//  Student.m
//  NSDictionaryHW
//
//  Created by Artem Belkov on 19/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Student.h"

@implementation Student

- (NSString *)getFullName {
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", self.lastName, self.name];
    return fullName;
    
}

@end
