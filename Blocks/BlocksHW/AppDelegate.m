//
//  AppDelegate.m
//  BlocksHW
//
//  Created by Artem Belkov on 25/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"

typedef void (^Block)();

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Pupil
    
    Block block = ^{
        NSLog(@"block");
    };
    
    block();
    
    void (^blockWithParam)(NSString *) = ^(NSString *string){
        NSLog(@"blockWithParam: %@", string);
    };
    
    blockWithParam(@"test");
    
    [self methodWithBlock:block];
    
    //Student
    
    Student *student1 = [[Student alloc] init];
    Student *student2 = [[Student alloc] init];
    Student *student3 = [[Student alloc] init];
    Student *student4 = [[Student alloc] init];
    Student *student5 = [[Student alloc] init];
    Student *student6 = [[Student alloc] init];
    Student *student7 = [[Student alloc] init];
    Student *student8 = [[Student alloc] init];
    Student *student9 = [[Student alloc] init];
    Student *student10 = [[Student alloc] init];
    
    student1.name = @"Mike";
    student1.lastName = @"Wazovsky";
    
    student2.name = @"Braeden";
    student2.lastName = @"Leroi";
    
    student3.name = @"Betram";
    student3.lastName = @"Darrel";
    
    student4.name = @"Wiley";
    student4.lastName = @"Eliot";
    
    student5.name = @"Daniel";
    student5.lastName = @"Leyton";
    
    student6.name = @"Sullivan";
    student6.lastName = @"Leyton";
    
    student7.name = @"Fitz";
    student7.lastName = @"Fenton";
    
    student8.name = @"Terrence";
    student8.lastName = @"Jaycob";
    
    student9.name = @"Hadyn";
    student9.lastName = @"Amos";
    
    student10.name = @"Jonathan";
    student10.lastName = @"Rudolph";
    
    NSArray *students = [NSArray arrayWithObjects:
                         student1,
                         student2,
                         student3,
                         student4,
                         student5,
                         student6,
                         student7,
                         student8,
                         student9,
                         student10,
                         nil];
    
    NSArray *sortedStudents = [students sortedArrayUsingComparator:^NSComparisonResult(id  __nonnull obj1, id  __nonnull obj2) {
        if ([[obj1 lastName] isEqualToString:[obj2 lastName]]) {
            return [[obj1 name] compare:[obj2 name]];
        } else {
            return [[obj1 lastName] compare:[obj2 lastName]];
        }
    }];
    
    for (Student *student in sortedStudents) {
        NSLog(@"%@ %@", student.lastName, student.name);
    }
    
    
    
    return YES;
}

- (void)methodWithBlock:(void (^)(void)) block {
    NSLog(@"methodWithBlock");
    block();
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
