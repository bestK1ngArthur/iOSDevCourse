//
//  User.m
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "User.h"

@implementation User

- (NSString *)fullName {
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    
    return fullName;
}

@end
