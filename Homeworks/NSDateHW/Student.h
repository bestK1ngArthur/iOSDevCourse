//
//  Student.h
//  NSDateHW
//
//  Created by Artem Belkov on 27/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;

@property (strong, nonatomic) NSDate *dateOfBirth;

@end
