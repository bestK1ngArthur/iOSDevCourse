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
    
    @"Beginner", @"Middle", @"Seniour"
    
};

@interface Teacher : User

+ (Teacher *)addRandomTeacher;
+ (Teacher *)addTeacherWithFirstName:(NSString *)firstName lastName:(NSString *)lastName rank:(NSString *)rank dateOfBirth:(NSDate *)dateOfBirth;

@end

NS_ASSUME_NONNULL_END

#import "Teacher+CoreDataProperties.h"
