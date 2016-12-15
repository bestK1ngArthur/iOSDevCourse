//
//  DataManager.m
//  CoreData.Basics.Lesson
//
//  Created by Artem Belkov on 15/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "DataManager.h"

#import "AppDelegate.h"
#import "Student.h"
#import "University.h"
#import "Course.h"

@implementation DataManager

#pragma mark - Init

+ (DataManager *)sharedManager {
    
    static DataManager *manager = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[DataManager alloc] init];
        
    });
    
    return manager;
}

#pragma mark - Data

- (Student *)addRandomStudent {
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                     inManagedObjectContext:self.managedObjectContext];
    
    student.score = @((float)arc4random_uniform(201) / 100.f + 2.f);
    student.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:60 * 60 * 24 * 365 * arc4random_uniform(31)];
    //student.firstName = firstNames[arc4random_uniform(50)];
    student.lastName = lastNames[arc4random_uniform(50)];
    
    return student;
}

- (University *)addUniversityWithName:(NSString *)name {
    
    University *university = [NSEntityDescription insertNewObjectForEntityForName:@"University"
                                                           inManagedObjectContext:self.managedObjectContext];
    
    university.name = name;
    
    return university;
}

- (Course *)addCourseWithName:(NSString *)name {
    
    Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    course.name = name;
    
    return course;
}

- (NSArray *)allObjects {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Object"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError *requestError = nil;
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return result;
}

- (void)printArray:(NSArray *)array {
    
    for (id object in array) {
        
        if ([object isKindOfClass:[Student class]]) {
            
            Student *student = (Student *)object;
            NSLog(@"Student: %@ %@ (score: %1.2f; courses: %d)", student.firstName, student.lastName, [student.score floatValue], (int)[student.courses count]);
            
        } else if ([object isKindOfClass:[University class]]) {
            
            University *university = (University *)object;
            NSLog(@"University: %@ (students: %d; courses: %d)", university.name, (int)[university.students count], (int)[university.courses count]);
            
        } else if ([object isKindOfClass:[Course class]]) {
            
            Course *course = (Course *)object;
            NSLog(@"Course: %@ (students count: %d)", course.name, (int)[course.students count]);
            
        }
        
    }
    
}

- (void)printAllObjects {
    
    NSArray *result = [self allObjects];
    
    [self printArray:result];
    
}

- (void)removeAllObjects {
    
    NSArray *result = [self allObjects];
    
    for (id object in result) {
        
        [self.managedObjectContext deleteObject:object];
        
    }
    
    [self.managedObjectContext save:nil];
    
}

#pragma mark -

- (void)generateAndAddUniversity {
    
    // Create and add object
    /*
     NSManagedObject *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
     inManagedObjectContext:self.managedObjectContext];
     
     [student setValue:@"Artem" forKey:@"firstName"];
     [student setValue:@"Belkov" forKey:@"lastName"];
     [student setValue:[NSDate dateWithTimeIntervalSinceReferenceDate:0] forKey:@"dateOfBirth"];
     [student setValue:@4 forKey:@"score"];
     
     NSError *error = nil;
     
     if (![self.managedObjectContext save:&error]) {
     NSLog(@"%@", [error localizedDescription]);
     }
     */
    
    // Read object
    /*
     NSFetchRequest *request = [[NSFetchRequest alloc] init];
     
     NSEntityDescription *description = [NSEntityDescription entityForName:@"Student"
     inManagedObjectContext:self.managedObjectContext];
     
     [request setEntity:description];
     
     NSError *requestError = nil;
     
     NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&requestError];
     
     if (requestError) {
     NSLog(@"%@", [requestError localizedDescription]);
     }
     
     // Using KVC
     
     for (NSManagedObject *object in result) {
     
     NSLog(@"%@ %@ - %@", [object valueForKey:@"firstName"],
     [object valueForKey:@"lastName"],
     [object valueForKey:@"score"]);
     
     }
     
     // Using dynamic properties
     
     for (Student *object in result) {
     
     NSLog(@"%@ %@ - %@", object.firstName,
     object.lastName,
     object.score);
     
     }
     */
    
    // Remove all objects
    //[self removeAllObjects];
    
     NSArray *courses = @[[self addCourseWithName:@"iOS Developmnet"],
                          [self addCourseWithName:@"Android Development"],
                          [self addCourseWithName:@"Windows Phone Development"],
                          [self addCourseWithName:@"Mac OS Development"],
                          [self addCourseWithName:@"Window Development"],
                          [self addCourseWithName:@"Linux Development"]];
     
     University *university = [self addUniversityWithName:@"MTI"];
     
     [university addCourses:[NSSet setWithArray:courses]];
     
     
     for (int i = 0; i < 500; i++) {
     
     // Create student
     
     Student *student = [self addRandomStudent];
     
     // Enroll student on courses
     
     NSInteger numberOfCourses = arc4random_uniform(5) + 1;
     
     while ([student.courses count] < numberOfCourses) {
     
     Course *course = [courses objectAtIndex:arc4random_uniform(6)];
     
     if (![student.courses containsObject:course]) {
     [student addCoursesObject:course];
     }
     
     }
     
     [university addStudentsObject:student];
     
     }
     
     [self.managedObjectContext save:nil];
    
    // Sotring
    
    /*
     NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
     NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
     
     [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
     */
    /*
     NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
     
     [request setSortDescriptors:@[nameDescriptor]];
     */
    
    // Predicates
    
    /*
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"score > %f && score <= %f && courses.@count >= %d", 3.0, 3.5, 3];
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"@avg.students.score >= %f", 3.04];
     
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(students, $student, $student.car.model == %@).@count >= %d", @"BMW", 30];
     
     [request setPredicate:predicate];
     */
    
    // Limits
    
    //[request setFetchBatchSize:20]; // Local limit to load
    //[request setFetchLimit:35]; // Global limit to load
    //[request setFetchOffset:10]; // Offset to load
    
    // fetchRequestTemplateForName
    
    /*
     NSFetchRequest *request = [self.managedObjectModel fetchRequestTemplateForName:@"FetchStudent"];
     
     NSError *requestError = nil;
     NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
     */
    
    /*
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Course"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    for (Course *course in result) {
        
        NSLog(@"Course: %@", course.name);
        NSLog(@"Best students:");
        [self printArray:course.students];
        
    }
    */
     
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.artembelkov.CoreData_Basics_Lesson" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreData_HW" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreData_HW.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
         
        
        
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
