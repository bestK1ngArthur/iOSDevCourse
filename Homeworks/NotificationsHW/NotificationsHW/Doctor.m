//
//  Doctor.m
//  NotificationsHW
//
//  Created by Artem Belkov on 23/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Doctor.h"

#import "Government.h"
#import <UIKit/UIKit.h>

@implementation Doctor

#pragma mark- Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(salaryChangedNotification:)
                                                     name:GovernmentSalaryDidChangeNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(averagePriceChangedNotification:)
                                                     name:GovernmentAveragePriceDidChangeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackgroundNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark- Notifications

//Pupil

- (void)salaryChangedNotification: (NSNotification *) notification {
    
    NSNumber *value = [notification.userInfo objectForKey:GovernmentSalaryUserInfoKey];
    
    float salary = [value floatValue];
    
    if (salary < self.salary) {
        NSLog(@"Doctor %@ isn't happy!", self.name);
    } else {
        NSLog(@"Doctor %@ is happy!", self.name);
        
    }
    
    self.salary = salary;
    
}

- (void)averagePriceChangedNotification: (NSNotification *) notification {
    
    NSLog(@"Doctor %@ sees the average price change", self.name);
    
}

//Master

- (void)applicationDidEnterBackgroundNotification: (NSNotification *) notification {
    
    NSLog(@"Doctor %@ is going to sleep", self.name);
}

- (void)applicationWillEnterForegroundNotification: (NSNotification *) notification {
    NSLog(@"Doctor %@ woke up", self.name);
}


@end
