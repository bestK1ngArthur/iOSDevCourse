//
//  Patient.m
//  DelegatesHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Patient.h"

@implementation Patient

- (BOOL)howAreYou {
    
    BOOL ok = arc4random() % 2;
    
    if (!ok) {
        [self.delegate patientFeelsBad:self];
    }
    
    return ok;
}

- (void)takePill {
    NSLog(@"%@ takes a pill", self.name);
}

- (void)makeShot {
    NSLog(@"%@ makes a shot", self.name);
}

- (void)haveRest {
    NSLog(@"%@ have a rest", self.name);
}

@end
