//
//  Student.h
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@class Course, University;

NS_ASSUME_NONNULL_BEGIN

@interface Student : User

+ (Student *)addRandomStudent;
+ (Student *)addStudentWithFirstName:(NSString *)firstName lastName:(NSString *)lastName score:(float)score dateOfBirth:(NSDate *)dateOfBirth;

@end

NS_ASSUME_NONNULL_END

#import "Student+CoreDataProperties.h"
