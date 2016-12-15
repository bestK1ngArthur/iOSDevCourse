//
//  Pensioner.m
//  NotificationsHW
//
//  Created by Artem Belkov on 23/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Pensioner.h"
#import "Government.h"

@implementation Pensioner

#pragma mark- Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(pensionChangedNotification:)
                                                     name:GovernmentPensionDidChangeNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(averagePriceChangedNotification:)
                                                     name:GovernmentAveragePriceDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark- Notifications

- (void)pensionChangedNotification: (NSNotification *) notification {
    
    NSNumber *value = [notification.userInfo objectForKey:GovernmentPensionUserInfoKey];
    
    float pension = [value floatValue];
    
    if (pension < self.pension) {
        NSLog(@"Pensioner %@ isn't happy!", self.name);
    } else {
        NSLog(@"Pensioner %@ is happy!", self.name);
        
    }
    
    self.pension = pension;
    
}

- (void)averagePriceChangedNotification: (NSNotification *) notification {
    
    NSLog(@"Pensioner %@ sees the average price change", self.name);
    
}


@end
