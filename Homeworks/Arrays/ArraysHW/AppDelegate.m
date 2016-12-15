//
//  AppDelegate.m
//  ArraysHW
//
//  Created by Artem Belkov on 17/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"
#import "Human.h"
#import "Cyclist.h"
#import "Runner.h"
#import "Swimmer.h"
#import "Coder.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //Pupil
    Human *human = [[Human alloc] init];
    Cyclist *cyclist = [[Cyclist alloc] init];
    Runner *runner = [[Runner alloc] init];
    Swimmer *swimmer = [[Swimmer alloc] init];

    human.name = @"Mark";
    human.height = 1.9f;
    human.weight = 75.f;
    human.gender = @"Male";
    
    cyclist.name = @"Piter";
    cyclist.height = 2.f;
    cyclist.weight = 80.f;
    cyclist.gender = @"Male";
    
    runner.name = @"Jane";
    runner.height = 1.8f;
    runner.weight = 60.f;
    runner.gender = @"Female";
    
    swimmer.name = @"Katy";
    swimmer.height = 1.9f;
    swimmer.weight = 50.f;
    swimmer.gender = @"Female";
    
    NSArray *array = [NSArray arrayWithObjects:human, cyclist, runner, swimmer, nil];
    
    for (Human *human in array) {
        NSLog(@"%@", [human getInfo]);
        [human move];
    }
    
    //Student
    Coder *coder = [[Coder alloc] init];
    
    coder.name = @"Pavel";
    coder.height = 1.8f;
    coder.weight = 80.f;
    coder.gender = @"Male";
    
    NSArray *advancedArray = [NSArray arrayWithObjects:human, cyclist, runner, swimmer, coder, nil];
    
    for (int i = (int)[advancedArray count] - 1; i >= 0; i--) {
        
        Human *human = [advancedArray objectAtIndex:i];
        
        NSLog(@"%@", [human getInfo]);
        if ([human isKindOfClass:[Coder class]]) {
            Coder *coder = (Coder *)human;
            NSLog(@"%@ is %@", coder.name, coder.skill);
        }
        
        [human move];
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
