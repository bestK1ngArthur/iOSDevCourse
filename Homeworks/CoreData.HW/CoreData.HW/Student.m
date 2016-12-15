//
//  Student.m
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Student.h"
#import "Course.h"
#import "University.h"

#import "DataManager.h"

@implementation Student

#pragma mark - Initialization

+ (Student *)randomStudent {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                     inManagedObjectContext: managedObjectContext];
    
    // Set random gender
    student.gender = [NSNumber numberWithInt:arc4random_uniform(2)];
    
    // Set random name
    if ([student.gender integerValue] == GenderMale) {
        student.firstName = firstMaleNames[arc4random_uniform(50)];
    } else {
        student.firstName = firstFemaleNames[arc4random_uniform(50)];
    }
    student.lastName = lastNames[arc4random_uniform(50)];
    
    // Set random score
    student.score = @((float)arc4random_uniform(201) / 100.f + 2.f);
    
    // Set random date of birth
    student.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24 * 365 * arc4random_uniform(31)];
    
    // Set random photo
    student.photo = [User randomFaceImageNameForGender:(Gender)[student.gender integerValue]];
    
    // Set random address
    NSInteger indexOfCountry = arc4random_uniform(6);
    student.country = countries[indexOfCountry];
    student.city = cities[indexOfCountry];
    
    return student;
}

+ (Student *)studentWithFirstName:(NSString *)firstName lastName:(NSString *)lastName gender:(Gender)gender score:(float)score dateOfBirth:(NSDate *)dateOfBirth country:(NSString *)country city:(NSString *)city {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                     inManagedObjectContext: managedObjectContext];
    
    // Set gender
    student.gender = [NSNumber numberWithInt:(int)gender];
    
    // Set name
    student.firstName = firstName;
    student.lastName = lastName;
    
    // Set score
    student.score = @(score);
    
    // Set date of birth
    student.dateOfBirth = dateOfBirth;
    
    // Set photo
    student.photo = [User randomFaceImageNameForGender:(Gender)[student.gender integerValue]];
    
    // Set address
    student.country = country;
    student.city = city;
    
    return student;
}

#pragma mark - Courses

- (void)tryToAddStudentToCourses:(NSArray *)courses {
    
    NSInteger rejectCoursesCount = 0;
    
    for (Course *course in courses) {
        
        if (arc4random_uniform(2) == YES) {
            
            [course addStudentsObject:self];
            
        } else {
            
            rejectCoursesCount++;
            
        }
        
    }
    
    // This is to ensure that the student has at least one course
    
    if (rejectCoursesCount == [courses count]) {
        
        NSInteger randomCourseIndex = arc4random_uniform((int)[courses count]);
        [[courses objectAtIndex:randomCourseIndex] addStudentsObject:self];
        
    }
    
}

@end
