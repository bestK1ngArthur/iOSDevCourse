//
//  Teacher.m
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Teacher.h"
#import "Course.h"
#import "University.h"

#import "DataManager.h"

@implementation Teacher

#pragma mark - Initialization

+ (Teacher *)randomTeacher {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    Teacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher"
                                                     inManagedObjectContext: managedObjectContext];
    
    // Set random gender
    teacher.gender = [NSNumber numberWithInt:arc4random_uniform(2)];
    
    // Set random name
    if ([teacher.gender integerValue] == GenderMale) {
        teacher.firstName = firstMaleNames[arc4random_uniform(50)];
    } else {
        teacher.firstName = firstFemaleNames[arc4random_uniform(50)];
    }
    teacher.lastName = lastNames[arc4random_uniform(50)];
    
    // Set random rank
    teacher.rank = teachersRanks[arc4random_uniform(4)];
    
    // Set random date of birth
    teacher.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24 * 365 * arc4random_uniform(31)];
    
    // Set random photo
    teacher.photo = [User randomFaceImageNameForGender:(Gender)[teacher.gender integerValue]];
    
    // Set random address
    NSInteger indexOfCountry = arc4random_uniform(6);
    teacher.country = countries[indexOfCountry];
    teacher.city = cities[indexOfCountry];
    
    return teacher;
}

+ (Teacher *)teacherWithFirstName:(NSString *)firstName lastName:(NSString *)lastName gender:(Gender)gender rank:(NSString *)rank dateOfBirth:(NSDate *)dateOfBirth country:(NSString *)country city:(NSString *)city {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    Teacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher"
                                                     inManagedObjectContext: managedObjectContext];
    
    // Set gender
    teacher.gender = [NSNumber numberWithInt:(int)gender];
    
    // Set name
    teacher.firstName = firstName;
    teacher.lastName = lastName;
    
    // Set score
    teacher.rank = rank;
    
    // Set date of birth
    teacher.dateOfBirth = dateOfBirth;
    
    // Set photo
    teacher.photo = [User randomFaceImageNameForGender:(Gender)[teacher.gender integerValue]];
    
    // Set address
    teacher.country = country;
    teacher.city = city;

    return teacher;
}

#pragma mark - Courses

- (void)tryToAddTeachersToCourses:(NSArray *)courses {
    
    NSInteger rejectCoursesCount = 0;
    
    for (Course *course in courses) {
        
        if (arc4random_uniform(2) == YES) {
            
            [course addTeachersObject:self];
            
        } else {
            
            rejectCoursesCount++;
            
        }
        
    }
    
    // This is to ensure that the teacher has at least one course
    
    if (rejectCoursesCount == [courses count]) {
        
        NSInteger randomCourseIndex = arc4random_uniform((int)[courses count]);
        [[courses objectAtIndex:randomCourseIndex] addTeachersObject:self];
        
    }
    
}

@end
