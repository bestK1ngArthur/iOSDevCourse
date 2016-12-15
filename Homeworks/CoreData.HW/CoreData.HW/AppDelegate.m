//
//  AppDelegate.m
//  CoreData.HW
//
//  Created by Artem Belkov on 12/08/15.
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

    /*
    Course *course11 = [Course courseWithName:@"iOS Development"
                             mainDescription:@"Development mobile apps for iOS devices"
                                       level:@"Beginner"];
    
    Course *course12 = [Course courseWithName:@"Android Development"
                             mainDescription:@"Development mobile apps for Android devices"
                                       level:@"Beginner"];
    
    Course *course13 = [Course courseWithName:@"Windows Phone Development"
                             mainDescription:@"Development mobile apps for Windows Phone devices"
                                       level:@"Beginner"];
    
    Course *course14 = [Course courseWithName:@"Windows Development"
                             mainDescription:@"Development desktop apps for Windows devices"
                                       level:@"Beginner"];
    
    Course *course15 = [Course courseWithName:@"Mac OS Development"
                             mainDescription:@"Development desktop apps for Mac OS devices"
                                       level:@"Beginner"];

    Course *course16 = [Course courseWithName:@"Linux Development"
                             mainDescription:@"Development desktop apps for Linux devices"
                                       level:@"Beginner"];
     
    Course *course21 = [Course courseWithName:@"iOS Development"
                             mainDescription:@"Development mobile apps for iOS devices"
                                       level:@"Beginner"];
    
    Course *course22 = [Course courseWithName:@"Android Development"
                             mainDescription:@"Development mobile apps for Android devices"
                                       level:@"Beginner"];
    
    Course *course23 = [Course courseWithName:@"Windows Phone Development"
                             mainDescription:@"Development mobile apps for Windows Phone devices"
                                       level:@"Beginner"];
    
    Course *course24 = [Course courseWithName:@"Windows Development"
                             mainDescription:@"Development desktop apps for Windows devices"
                                       level:@"Beginner"];
    
    Course *course25 = [Course courseWithName:@"Mac OS Development"
                             mainDescription:@"Development desktop apps for Mac OS devices"
                                       level:@"Beginner"];
    
    Course *course26 = [Course courseWithName:@"Linux Development"
                             mainDescription:@"Development desktop apps for Linux devices"
                                       level:@"Beginner"];
    
    NSArray *courses1 = [NSArray arrayWithObjects:course11, course12, course13, course14, course15, course16, nil];
    NSArray *courses2 = [NSArray arrayWithObjects:course21, course22, course23, course24, course25, course26, nil];
    
    University *university1 = [University universityWithName:@"MIT"
                                                    courses:courses1
                                    randomTeachersWithCount:13
                                 andRandomStudentsWithCount:300];
    
    University *university2 = [University universityWithName:@"MSU"
                                                    courses:courses2
                                    randomTeachersWithCount:20
                                 andRandomStudentsWithCount:300];
    
    for (Course *course in courses1) {
        
        course.university = university1;
        
    }
    
    for (Course *course in courses2) {
        
        course.university = university2;
        
    }
    */
    
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
