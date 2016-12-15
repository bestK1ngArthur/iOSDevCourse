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

+ (Teacher *)addRandomTeacher {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    Teacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher"
                                                     inManagedObjectContext: managedObjectContext];
    
    teacher.firstName = firstNames[arc4random_uniform(50)];
    teacher.lastName = lastNames[arc4random_uniform(50)];
    
    teacher.rank = teachersRanks[arc4random_uniform(3)];
    teacher.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24 * 365 * arc4random_uniform(31)];
    
    return teacher;
}

+ (Teacher *)addTeacherWithFirstName:(NSString *)firstName lastName:(NSString *)lastName rank:(NSString *)rank dateOfBirth:(NSDate *)dateOfBirth {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    Teacher *teacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher"
                                                     inManagedObjectContext: managedObjectContext];
    
    teacher.firstName = firstName;
    teacher.lastName = lastName;
    
    teacher.rank = rank;
    teacher.dateOfBirth = dateOfBirth;
    
    return teacher;
}

@end
