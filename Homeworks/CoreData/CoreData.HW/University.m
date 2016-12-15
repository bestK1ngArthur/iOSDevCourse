//
//  University.m
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "University.h"
#import "Course.h"
#import "Student.h"
#import "Teacher.h"

#import "DataManager.h"

@implementation University

+ (University *)universityWithName:(NSString *)name {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    University *university = [NSEntityDescription insertNewObjectForEntityForName:@"University"
                                                     inManagedObjectContext: managedObjectContext];
    
    university.name = name;
    
    return university;
}

+ (University *)universityWithName:(NSString *)name courses:(NSArray *)courses randomTeachersWithCount:(NSInteger)teachersCount andRandomStudentsWithCount:(NSInteger)studentsCount {
    
    University *university = [self universityWithName:name]; // Create university with name
    
    for (int i = 0; i <= studentsCount; i++) {

        Student *student = [Student randomStudent]; // Create random student

        [university addStudentsObject:student]; // Add student to university
        
        [student tryToAddStudentToCourses:courses]; // Add student to courses;
        
    }
    
    for (int i = 0; i <= teachersCount; i++) {
        
        Teacher *teacher = [Teacher randomTeacher]; // Create random teacher
        
        [university addTeachersObject:teacher]; // Add teacher to university
        
        [teacher tryToAddTeachersToCourses:courses]; // Add teacher to courses;
        
    }
    
    // May be need add university to each course..
    
    [university addCourses:[NSSet setWithArray:courses]]; // Add courses to university
    
    NSError *error = nil;
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    if (![managedObjectContext save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [[DataManager sharedManager] saveContext];
    
    return university;
}

@end
