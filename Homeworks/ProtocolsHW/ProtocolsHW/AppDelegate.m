//
//  AppDelegate.m
//  ProtocolsHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"

#import "Swimmer.h"
#import "Kangaroo.h"
#import "Cheetah.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    Swimmer *swimmer1 = [[Swimmer alloc] init];
    Swimmer *swimmer2 = [[Swimmer alloc] init];
    
    Kangaroo *kangaroo1 = [[Kangaroo alloc] init];
    Kangaroo *kangaroo2 = [[Kangaroo alloc] init];
    Kangaroo *kangaroo3 = [[Kangaroo alloc] init];
    
    Cheetah *cheetah1 = [[Cheetah alloc] init];
    
    swimmer1.name = @"Pavel";
    swimmer2.name = @"Katy";
    
    kangaroo1.name = @"Kitty";
    kangaroo2.name = @"Phil";
    kangaroo3.name = @"Vladimir";
    
    kangaroo1.color = @"Black";
    kangaroo2.color = @"Red";
    kangaroo3.color = @"White";
    
    cheetah1.name = @"Flash";
    
    NSArray *all = [NSArray arrayWithObjects:
                    swimmer1,
                    swimmer2,
                    kangaroo1,
                    kangaroo2,
                    kangaroo3,
                    cheetah1,
                    nil];
    
    for(id somebody in all) {
        
        [somebody sayInfo];
        
        if ([somebody conformsToProtocol:@protocol(Swimmers) ]) {
            [somebody swim];
            if ([somebody respondsToSelector:@selector(dive)]) {
                [somebody dive];
            }
        }
        
        if ([somebody conformsToProtocol:@protocol(Jumpers)]) {
            [somebody jump];
            if ([somebody respondsToSelector:@selector(fly)]) {
                [somebody fly];
            }
        }
        
        if ([somebody conformsToProtocol:@protocol(Runners)]) {
            [somebody run];
        }
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
