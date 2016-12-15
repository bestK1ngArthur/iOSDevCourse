//
//  Businessman.m
//  NotificationsHW
//
//  Created by Artem Belkov on 23/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Businessman.h"
#import "Government.h"

@implementation Businessman

#pragma mark- Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(taxLevelChangedNotification:)
                                                     name:GovernmentTaxLevelDidChangeNotification
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

- (void)taxLevelChangedNotification: (NSNotification *) notification {
    
    NSNumber *value = [notification.userInfo objectForKey:GovernmentPensionUserInfoKey];
    
    float taxLevel = [value floatValue];
    
    if (taxLevel < self.taxLevel) {
        NSLog(@"Businessman %@ isn't happy!", self.name);
    } else {
        NSLog(@"Businessman %@ is happy!", self.name);
        
    }
    
    self.taxLevel = taxLevel;
    
}

- (void)averagePriceChangedNotification: (NSNotification *) notification {
    
    NSLog(@"Businessman %@ sees the average price change", self.name);
    
}


@end
