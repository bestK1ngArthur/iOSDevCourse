//
//  AppDelegate.m
//  NotificationsHW
//
//  Created by Artem Belkov on 23/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"

#import "Government.h"

#import "Doctor.h"
#import "Pensioner.h"
#import "Businessman.h"

#import "SuperAppDelegate.h"

@interface AppDelegate ()

@property (strong, nonatomic) Government *government;

@property (strong, nonatomic) Doctor *doctor1; //That doctors don't die sooner than our application will go to sleep
@property (strong, nonatomic) Doctor *doctor2;

@property (strong, nonatomic) SuperAppDelegate *superAppDelegate;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    /*Government *government = [[Government alloc] init];
    
    Doctor *doctor1 = [[Doctor alloc] init];
    Doctor *doctor2 = [[Doctor alloc] init];
    
    doctor1.name = @"Mike";
    doctor2.name = @"Lily";
    
    doctor1.salary = government.salary;
    doctor2.salary = government.salary;
    
    self.doctor1 = doctor1;
    self.doctor2 = doctor2;
    
    Pensioner *pensioner1 = [[Pensioner alloc] init];
    Pensioner *pensioner2 = [[Pensioner alloc] init];
    
    pensioner1.name = @"Oleg";
    pensioner2.name = @"Vladimir";
    
    pensioner1.pension = government.pension;
    pensioner2.pension = government.pension;
    
    Businessman *businessman1 = [[Businessman alloc] init];
    Businessman *businessman2 = [[Businessman alloc] init];

    businessman1.name = @"Mark";
    businessman2.name = @"Katy";
    
    businessman1.taxLevel = government.taxLevel;
    businessman2.taxLevel = government.taxLevel;
    
    government.taxLevel = 5.5f;
    government.salary = 1100.f;
    government.averagePrice = 15;
    government.pension = 550;
    
    NSLog(@"Changing up salary");
    government.salary = 1200.f;
    
    NSLog(@"Changing down pension");
    government.pension = 500.f;
    
    NSLog(@"Changing up tax level");
    government.taxLevel = 6.f;*/
    
    self.superAppDelegate = [[SuperAppDelegate alloc] init];
    
    NSLog(@"applicationDidFinishLaunchingDelegate");
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"applicationWillResignActiveDelegate");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"applicationDidEnterBackgroundDelegate");

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"applicationWillEnterForegroundDelegate");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActiveDelegate");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"applicationWillTerminateDelegate");
}

@end
