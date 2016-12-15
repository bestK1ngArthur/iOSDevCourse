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

+ (Student *)randomStudent;
+ (Student *)studentWithFirstName:(NSString *)firstName lastName:(NSString *)lastName gender:(Gender)gender score:(float)score dateOfBirth:(NSDate *)dateOfBirth country:(NSString *)country city:(NSString *)city;

- (void)tryToAddStudentToCourses:(NSArray *)courses;

@end

NS_ASSUME_NONNULL_END

#import "Student+CoreDataProperties.h"
