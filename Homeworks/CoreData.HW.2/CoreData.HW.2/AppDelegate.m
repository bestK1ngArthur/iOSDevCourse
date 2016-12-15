//
//  AppDelegate.m
//  CoreData.HW.2
//
//  Created by Artem Belkov on 20/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"

#import "Student.h"
#import "Teacher.h"
#import "Course.h"
#import "University.h"

#import "DataManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Add university
    
    University *university = [University addUniversityWithName:@"MTI"];
    
    // Add courses with students
    
    Course *course1 = [Course addCourseWithName:@"iOS Development"
                                mainDescription:@"Development mobile apps for iOS devices"
                                          level:@"Beginner"
                                     university:university];
    
    NSMutableArray *students1 = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        Student *student = [Student addRandomStudent];
        [students1 addObject:student];
    }
    [course1 addStudents:[NSSet setWithArray:students1]];
    
    Course *course2 = [Course addCourseWithName:@"Android Development"
                                mainDescription:@"Development mobile apps for Android devices"
                                          level:@"Beginner"
                                     university:university];
    
    NSMutableArray *students2 = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        Student *student = [Student addRandomStudent];
        [students2 addObject:student];
    }
    [course2 addStudents:[NSSet setWithArray:students2]];
    
    Course *course3 = [Course addCourseWithName:@"Windows Phone Development"
                                mainDescription:@"Development mobile apps for Windows Phone devices"
                                          level:@"Beginner"
                                     university:university];
    
    NSMutableArray *students3 = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        Student *student = [Student addRandomStudent];
        [students3 addObject:student];
    }
    [course3 addStudents:[NSSet setWithArray:students3]];
    
    Course *course4 = [Course addCourseWithName:@"Windows Development"
                                mainDescription:@"Development desktop apps for Windows devices"
                                          level:@"Beginner"
                                     university:university];
    
    NSMutableArray *students4 = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        Student *student = [Student addRandomStudent];
        [students4 addObject:student];
    }
    [course4 addStudents:[NSSet setWithArray:students4]];
    
    Course *course5 = [Course addCourseWithName:@"Mac OS Development"
                                mainDescription:@"Development desktop apps for Mac OS devices"
                                          level:@"Beginner"
                                     university:university];
    
    NSMutableArray *students5 = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        Student *student = [Student addRandomStudent];
        [students5 addObject:student];
    }
    [course5 addStudents:[NSSet setWithArray:students5]];
    
    Course *course6 = [Course addCourseWithName:@"Linux Development"
                                mainDescription:@"Development desktop apps for Linux devices"
                                          level:@"Beginner"
                                     university:university];
    
    NSMutableArray *students6 = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        Student *student = [Student addRandomStudent];
        [students6 addObject:student];
    }
    [course6 addStudents:[NSSet setWithArray:students6]];
    
    // Add teachers to courses
    
    Teacher *teacher11 = [Teacher addRandomTeacher];
    Teacher *teacher12 = [Teacher addRandomTeacher];
    Teacher *teacher13 = [Teacher addRandomTeacher];
    
    [course1 addTeachers:[NSSet setWithObjects:teacher11, teacher12, teacher13, nil]];
    
    Teacher *teacher21 = [Teacher addRandomTeacher];
    Teacher *teacher22 = [Teacher addRandomTeacher];
    Teacher *teacher23 = [Teacher addRandomTeacher];
    
    [course2 addTeachers:[NSSet setWithObjects:teacher21, teacher22, teacher23, nil]];
    
    Teacher *teacher31 = [Teacher addRandomTeacher];
    Teacher *teacher32 = [Teacher addRandomTeacher];
    Teacher *teacher33 = [Teacher addRandomTeacher];
    
    [course3 addTeachers:[NSSet setWithObjects:teacher31, teacher32, teacher33, nil]];
    
    Teacher *teacher41 = [Teacher addRandomTeacher];
    Teacher *teacher42 = [Teacher addRandomTeacher];
    Teacher *teacher43 = [Teacher addRandomTeacher];
    
    [course4 addTeachers:[NSSet setWithObjects:teacher41, teacher42, teacher43, nil]];
    
    Teacher *teacher51 = [Teacher addRandomTeacher];
    Teacher *teacher52 = [Teacher addRandomTeacher];
    Teacher *teacher53 = [Teacher addRandomTeacher];
    
    [course5 addTeachers:[NSSet setWithObjects:teacher51, teacher52, teacher53, nil]];
    
    Teacher *teacher61 = [Teacher addRandomTeacher];
    Teacher *teacher62 = [Teacher addRandomTeacher];
    Teacher *teacher63 = [Teacher addRandomTeacher];
    
    [course1 addTeachers:[NSSet setWithObjects:teacher61, teacher62, teacher63, nil]];
    
    // Add courses to university
    
    [university addCourses:[NSSet setWithObjects:course1, course2, course3, course4, course5, course6, nil]];
    
    NSError *error = nil;
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    if (![managedObjectContext save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    NSLog(@"avsdv");
    
    return YES;
}

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
    // Saves changes in the application's managed object context before the application terminates.
}


@end
