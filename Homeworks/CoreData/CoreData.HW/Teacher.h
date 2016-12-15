//
//  Teacher.h
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@class Course, University;

NS_ASSUME_NONNULL_BEGIN

static NSString *teachersRanks[] = {
    
    @"Junior", @"Middle", @"Senior", @"Legendary"
    
};

@interface Teacher : User

+ (Teacher *)randomTeacher;
+ (Teacher *)teacherWithFirstName:(NSString *)firstName lastName:(NSString *)lastName gender:(Gender)gender rank:(NSString *)rank dateOfBirth:(NSDate *)dateOfBirth country:(NSString *)country city:(NSString *)city ;

- (void)tryToAddTeachersToCourses:(NSArray *)courses;

@end

NS_ASSUME_NONNULL_END

#import "Teacher+CoreDataProperties.h"
