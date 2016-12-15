//
//  AppDelegate.m
//  CoreData.Intro.HW
//
//  Created by Artem Belkov on 07/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Create students
    
    Student *student1 = [[Student alloc] init];
    student1.firstName = @"Oleg";
    student1.lastName = @"Front";
    student1.grade = 234;
    student1.gender = StudentGenderMale;
    student1.dateOfBirth = [Student randomDateOfBirth];
    
    Student *student2 = [[Student alloc] init];
    student2.firstName = @"Jane";
    student2.lastName = @"Kra";
    student2.gender = StudentGenderFemale;
    student2.grade = 13;
    student2.dateOfBirth = [Student randomDateOfBirth];
    
    Student *student3 = [[Student alloc] init];
    student3.firstName = @"Phillip";
    student3.lastName = @"Arm";
    student3.gender = StudentGenderMale;
    student3.grade = 143;
    student3.dateOfBirth = [Student randomDateOfBirth];
        
    // Set friends for students
    
    student1.friend = student2;
    student2.friend = student3;
    
    // Add observers to student3
    
    [self addObserversToStudent:student3];
    
    // In recursive method set firstNames and lastNames to 'any'
    
    Student *lastStudent = [student1 setNameAndReturnFriend];
    NSLog(@"lastStudent: %@ %@", [lastStudent valueForKey:@"firstName"], [lastStudent valueForKey:@"lastName"]);
    
    // Remove observers from student3
    
    [self removeObserversForStudent:student3];
    
    // Create student group
    
    StudentGroup *studentGroup = [[StudentGroup alloc] init];
    studentGroup.students = [NSArray arrayWithObjects:student1, student2, student3, nil];
    
    // Log info
    
    NSLog(@"names = %@", [studentGroup studentsNames]);
    
    NSLog(@"averageGrade = %f", [studentGroup averageGrade]);
    NSLog(@"sumOfGrades = %d", (int)[studentGroup sumOfGrades]);
    
    NSDictionary *years = [studentGroup firstAndLastYearsOfBirth];
    NSLog(@"firstYear = %d", (int)[[years objectForKey:@"firstYear"] integerValue]);
    NSLog(@"lastYear = %d", (int)[[years objectForKey:@"lastYear"] integerValue]);
    
    return YES;
}

#pragma mark - Observing

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    NSLog(@"\n\tobserveValueForKeyPath: %@\n\tofObject: %@\n\tchange: %@", keyPath, object , change);
    
}

- (void)addObserversToStudent:(Student *)student {
    
    [student addObserver:self
                   forKeyPath:@"firstName"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:NULL];
    
    [student addObserver:self
                   forKeyPath:@"lastName"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:NULL];
    
    [student addObserver:self
                   forKeyPath:@"gender"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:NULL];
    
    [student addObserver:self
                   forKeyPath:@"grade"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:NULL];
    
    [student addObserver:self
                   forKeyPath:@"dateOfBirth"
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:NULL];
}

- (void)removeObserversForStudent:(Student *)student {
    
    [student removeObserver:self forKeyPath:@"firstName"];
    [student removeObserver:self forKeyPath:@"lastName"];
    [student removeObserver:self forKeyPath:@"gender"];
    [student removeObserver:self forKeyPath:@"grade"];
    [student removeObserver:self forKeyPath:@"dateOfBirth"];
    
}

#pragma mark -

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
