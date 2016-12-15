//
//  AppDelegate.m
//  BitwiseOperationsHW
//
//  Created by Artem Belkov on 26/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSMutableArray *students = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        
        Student *student = [[Student alloc] init];
        student.name = [NSString stringWithFormat:@"Student%d", i];
        
        for (int j = 0; j < 7; j++) {
            
            student.subjectType = student.subjectType | (arc4random() % 2 << j);
        
        }
        [students addObject:student];
    }
    
    
    
    //Master
    
    for (Student *student in students) {
        
        if (student.subjectType & StudentSubjectTypeBiology) {
            
            int biologyCanceledMask = ~StudentSubjectTypeBiology;
            student.subjectType = student.subjectType & biologyCanceledMask;
            
            NSLog(@"Bilogy for %@ canceled", student.name);
            
        }
    }
    
  
    
    return YES;
}

- (void)printStudents: (NSMutableArray *) students {
    
    for (Student *student in students) {
        NSLog(@"%@", student);
    }
    
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
