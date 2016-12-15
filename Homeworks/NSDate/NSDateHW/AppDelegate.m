//
//  AppDelegate.m
//  NSDateHW
//
//  Created by Artem Belkov on 27/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSArray *studentNames = [NSArray arrayWithObjects:
                             @"Katy",
                             @"Rosalie",
                             @"Richard",
                             @"Christopher",
                             @"Linda",
                             @"Hans",
                             @"Charles",
                             @"Victor",
                             @"Gabriel",
                             @"Bob",
                             nil];
    
    NSArray *studentLastNames = [NSArray arrayWithObjects:
                             @"Williams",
                             @"Giannini",
                             @"Gomes",
                             @"Pepe",
                             @"Oleary",
                             @"Taylor",
                             @"Knapp",
                             @"Malave",
                             @"Horton",
                             @"Braxton",
                             nil];
    
    NSMutableArray *students = [NSMutableArray array];
    
    for (int i = 0; i < 30; i++) {
        
        Student *student = [[Student alloc] init];
        
        student.dateOfBirth = [self getRandomDate];
        student.name = [studentNames objectAtIndex:arc4random() % 10];
        student.lastName = [studentLastNames objectAtIndex:arc4random() % 10];
        
        [students addObject:student];
    }
    
    NSArray *sortedStudents = [students sortedArrayUsingComparator:^NSComparisonResult(id  __nonnull obj1, id  __nonnull obj2) {
        return [[obj2 dateOfBirth] compare:[obj1 dateOfBirth]];
    }];
    
    for (Student *student in sortedStudents) {
        
        NSLog(@"%@", student);
        
    }
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.5
                                             target:self
                                           selector:@selector(checkStudentBirthday)
                                           userInfo:nil
                                            repeats:YES];
    
    

    return YES;
}

- (void)checkStudentBirthday {
    
    
    
    
}

- (NSDate *)getRandomDate {
    
    NSDate *date = [NSDate date];
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSTimeInterval secondsPerYear = 364 * secondsPerDay;
    
    NSTimeInterval secondsPerRandomDay = secondsPerDay * (arc4random() % 364 + 1);
    NSTimeInterval secondsPerRandomYear = secondsPerYear * (arc4random() % 35 + 16);
    
    date = [date dateByAddingTimeInterval: - (secondsPerRandomDay + secondsPerRandomYear)];
    
    return date;
    
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
