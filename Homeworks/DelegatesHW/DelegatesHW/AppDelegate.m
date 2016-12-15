//
//  AppDelegate.m
//  DelegatesHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"

#import "Patient.h"

#import "Doctor.h"
#import "BadDoctor.h"

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    Doctor *doctor = [[Doctor alloc] init];
    BadDoctor *badDoctor = [[BadDoctor alloc] init];
    
    Patient *patient1 = [[Patient alloc] init];
    Patient *patient2 = [[Patient alloc] init];
    Patient *patient3 = [[Patient alloc] init];
    Patient *patient4 = [[Patient alloc] init];
    Patient *patient5 = [[Patient alloc] init];
    
    patient1.name = @"Mark";
    patient1.temperature = 36.f;
    patient1.bloodPulse = 60.f;
    patient1.bloodPressure = 120.f;
    
    patient2.name = @"Petr";
    patient2.temperature = 38.f;
    patient2.bloodPulse = 70.f;
    patient2.bloodPressure = 110.f;
    
    patient3.name = @"Arthur";
    patient3.temperature = 34.f;
    patient3.bloodPulse = 40.f;
    patient3.bloodPressure = 50.f;
    
    patient4.name = @"Katy";
    patient4.temperature = 40.f;
    patient4.bloodPulse = 70.f;
    patient4.bloodPressure = 140.f;
    
    patient4.name = @"Jane";
    patient5.temperature = 35.f;
    patient5.bloodPulse = 50.f;
    patient5.bloodPressure = 90.f;
    
    patient1.delegate = doctor;
    patient2.delegate = doctor;
    patient3.delegate = badDoctor;
    patient4.delegate = badDoctor;
    patient5.delegate  = badDoctor;
    
    NSArray *patients = [NSArray arrayWithObjects:
                         patient1,
                         patient2,
                         patient3,
                         patient4,
                         patient5,
                         nil];
    
    for (Patient *patient in patients) {
        [patient howAreYou];
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
