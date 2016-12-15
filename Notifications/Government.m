//
//  Government.m
//  NotificationsHW
//
//  Created by Artem Belkov on 23/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Government.h"

NSString *const GovernmentTaxLevelDidChangeNotification = @"GovernmentTaxLevelDidChangeNotification";
NSString *const GovernmentSalaryDidChangeNotification = @"GovernmentSalaryDidChangeNotification";
NSString *const GovernmentPensionDidChangeNotification = @"GovernmentPensionDidChangeNotification";
NSString *const GovernmentAveragePriceDidChangeNotification = @"GovernmentAveragePriceDidChangeNotification";

NSString *const GovernmentTaxLevelUserInfoKey = @"GovernmentTaxLevelUserInfoKey";
NSString *const GovernmentSalaryUserInfoKey = @"GovernmentSalaryUserInfoKey";
NSString *const GovernmentPensionUserInfoKey = @"GovernmentPensionUserInfoKey";
NSString *const GovernmentAveragePriceUserInfoKey = @"GovernmentAveragePriceUserInfoKey";

@implementation Government

- (instancetype)init
{
    self = [super init];
    if (self) {
        _taxLevel = 5.f;
        _averagePrice = 1.f;
        _pension = 200.f;
        _salary = 1000.f;
    }
    return self;
}

- (void) setTaxLevel:(float)taxLevel {
    
    _taxLevel = taxLevel;
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:taxLevel]
                                                           forKey:GovernmentTaxLevelUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GovernmentTaxLevelDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
    
}


- (void) setSalary:(float)salary {
    
    _salary = salary;
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:salary]
                                                           forKey:GovernmentSalaryUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GovernmentSalaryDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
    
}

- (void) setPension:(float)pension {
    
    _pension = pension;
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:pension]
                                                           forKey:GovernmentPensionUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GovernmentPensionDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
    
}

- (void) setAveragePrice:(float)averagePrice {
    
    _averagePrice = averagePrice;
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:averagePrice]
                                                           forKey:GovernmentAveragePriceUserInfoKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GovernmentAveragePriceDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
    
}
@end
