//
//  SuperAppDelegate.m
//  NotificationsHW
//
//  Created by Artem Belkov on 23/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "SuperAppDelegate.h"

@implementation SuperAppDelegate

#pragma mark- Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackgroundNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidFinishLaunchingNotification:)
                                                     name:UIApplicationDidFinishLaunchingNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidBecomeActiveNotification:)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillResignActiveNotification:)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidReceiveMemoryWarningNotification:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillTerminateNotification:)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
        
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark- Notifications

- (void)applicationDidEnterBackgroundNotification:(NSNotification *) notification {
    NSLog(@"applicationDidEnterBackgroundNotification");
}

- (void)applicationWillEnterForegroundNotification:(NSNotification *) notification {
    NSLog(@"applicationWillEnterForegroundNotification");
}

- (void)applicationDidFinishLaunchingNotification:(NSNotification *) notification {
    NSLog(@"applicationDidFinishLaunchingNotification");
}

- (void)applicationDidBecomeActiveNotification:(NSNotification *) notification {
    NSLog(@"applicationDidBecomeActiveNotification");
}

- (void)applicationWillResignActiveNotification:(NSNotification *) notification {
    NSLog(@"applicationWillResignActiveNotification");
}

- (void)applicationDidReceiveMemoryWarningNotification:(NSNotification *) notification {
    NSLog(@"applicationDidReceiveMemoryWarningNotification");
}

- (void)applicationWillTerminateNotification:(NSNotification *) notification {
    NSLog(@"applicationWillTerminateNotification");
}

@end
