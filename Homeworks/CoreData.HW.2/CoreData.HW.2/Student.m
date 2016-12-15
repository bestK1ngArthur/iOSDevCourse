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

+ (Student *)addRandomStudent {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                     inManagedObjectContext: managedObjectContext];
    
    student.firstName = firstNames[arc4random_uniform(50)];
    student.lastName = lastNames[arc4random_uniform(50)];
    
    student.score = @((float)arc4random_uniform(201) / 100.f + 2.f);
    student.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24 * 365 * arc4random_uniform(31)];
    
    return student;
}

+ (Student *)addStudentWithFirstName:(NSString *)firstName lastName:(NSString *)lastName score:(float)score dateOfBirth:(NSDate *)dateOfBirth {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                     inManagedObjectContext: managedObjectContext];
    
    student.firstName = firstName;
    student.lastName = lastName;
    
    student.score = [NSNumber numberWithFloat:score];
    student.dateOfBirth = dateOfBirth;
    
    return student;
}

@end
