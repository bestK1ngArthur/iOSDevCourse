//
//  Student.m
//  NSDateHW
//
//  Created by Artem Belkov on 27/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Student.h"

@implementation Student

- (NSString *)description {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MMM/yyyy"];
    
    return [NSString stringWithFormat:@"%@ %@ (%@)", self.name, self.lastName, [dateFormatter stringFromDate:self.dateOfBirth]];
}

@end
