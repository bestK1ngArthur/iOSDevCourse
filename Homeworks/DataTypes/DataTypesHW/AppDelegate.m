//
//  AppDelegate.m
//  DataTypesHW
//
//  Created by Artem Belkov on 18/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "AppDelegate.h"
#import "Coder.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1
    
    Coder *coder = [[Coder alloc] init];
    
    coder.name = @"Mark";
    
    coder.gender = GenderMale;
    coder.skill = SkillSenior;
    
    //2 & 3
    
    CGRect field = CGRectMake(1, 1, 10, 10);
    CGRect centalField = CGRectMake(4, 4, 3, 3);
    
    CGPoint point1 = [self getRandomPoint];
    CGPoint point2 = [self getRandomPoint];
    CGPoint point3 = [self getRandomPoint];
    CGPoint point4 = [self getRandomPoint];
    CGPoint point5 = [self getRandomPoint];
    
   NSArray *pointsArray = [NSArray arrayWithObjects:
                           [NSValue valueWithCGPoint:point1],
                           [NSValue valueWithCGPoint:point2],
                           [NSValue valueWithCGPoint:point3],
                           [NSValue valueWithCGPoint:point4],
                           [NSValue valueWithCGPoint:point5],
                           nil];
    
    
    for (NSValue *value in pointsArray) {
        
        CGPoint point = [value CGPointValue];
        
        NSLog(@"(%1.f,%1.f)", point.x, point.y);
        
        if (CGRectContainsPoint(centalField, point)) {
            NSLog(@"+(%1.f,%1.f)", point.x, point.y);
        }
        
    }
    
    return YES;
}

-(CGPoint)getRandomPoint {
    
    CGPoint point = CGPointMake(arc4random() % 11, arc4random() % 11);
    
    return point;
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
