//
//  AppDelegate.m
//  NSDictionaryHW
//
//  Created by Artem Belkov on 19/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    Student *studentA = [[Student alloc] init];
    Student *studentB = [[Student alloc] init];
    Student *studentC = [[Student alloc] init];
    Student *studentD = [[Student alloc] init];
    Student *studentE = [[Student alloc] init];
    Student *studentF = [[Student alloc] init];
    Student *studentG = [[Student alloc] init];
    Student *studentH = [[Student alloc] init];
    Student *studentK = [[Student alloc] init];
    Student *studentL = [[Student alloc] init];
    
    NSArray *students = [NSArray arrayWithObjects:
                         studentA,
                         studentB,
                         studentC,
                         studentD,
                         studentE,
                         studentF,
                         studentG,
                         studentH,
                         studentK,
                         studentL,
                         nil];
    
    NSArray *studentNames = [NSArray arrayWithObjects:
                             @"Mark",
                             @"Petr",
                             @"Kim",
                             @"John",
                             @"Josh",
                             @"Sheldon",
                             @"Leonard",
                             @"Katy",
                             @"Oliver",
                             @"Felicity",
                             nil];
    
    NSArray *studentLastNames = [NSArray arrayWithObjects:
                                 @"A",
                                 @"B",
                                 @"C",
                                 @"D",
                                 @"E",
                                 @"F",
                                 @"G",
                                 @"H",
                                 @"K",
                                 @"L",
                                 nil];
    
    NSArray *studentGreetings = [NSArray arrayWithObjects:
                                 @"Hi!",
                                 @"Hello",
                                 @"Good Evening",
                                 @"Hey",
                                 @"Hey, bro!",
                                 @"Nice day!",
                                 @"Good morning",
                                 @"hi",
                                 @"lol",
                                 @"Good day!",
                                 nil];
    
    //Pupil
    
    NSMutableDictionary *studentList = [NSMutableDictionary dictionary];
    
    for(Student *student in students) {
        
        int index = (int)[students indexOfObject:student];
        
        student.name = [studentNames objectAtIndex:index];
        student.lastName = [studentLastNames objectAtIndex:index];
        student.greeting = [studentGreetings objectAtIndex:index];
        
        [studentList setObject:student forKey:[student getFullName]];
    }
    
    NSLog(@"%@", studentList);
    
    //Student
    
    for(NSString *fullName in [studentList allKeys]) {
        
        NSLog(@"Student %@ %@: '%@'", [[studentList objectForKey:fullName] name], [[studentList objectForKey:fullName] lastName], [[studentList objectForKey:fullName] greeting]);
        
    }
    
    //Master
    
    
    NSArray *sortedFullNames = [studentList keysSortedByValueUsingComparator:^NSComparisonResult(id  __nonnull obj1, id  __nonnull obj2) {
        return [[obj1 name] compare:[obj2 name]];
    }];
    
    
    for(NSString *fullName in sortedFullNames) {
        
        Student *student = [studentList objectForKey:fullName];
        NSLog(@"%@ %@", student.name, student.lastName);

    }
    
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
}

@end
