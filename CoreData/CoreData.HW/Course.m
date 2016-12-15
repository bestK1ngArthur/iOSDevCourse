//
//  Course.m
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Course.h"
#import "University.h"
#import "Teacher.h"
#import "Student.h"

#import "DataManager.h"

@implementation Course

+ (Course *)courseWithName:(NSString *)name mainDescription:(NSString *)mainDescription level:(NSString *)level {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course"
                                                   inManagedObjectContext: managedObjectContext];
    
    course.name = name;
    course.mainDescription = mainDescription;
    course.level = level;
    
    return course;
}

+ (Course *)courseWithName:(NSString *)name mainDescription:(NSString *)mainDescription level:(NSString *)level university:(University *)university {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course"
                                                           inManagedObjectContext: managedObjectContext];
    
    course.name = name;
    course.mainDescription = mainDescription;
    course.level = level;
    course.university = university;
    
    return course;
}

@end
