//
//  BadDoctor.m
//  DelegatesHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "BadDoctor.h"
#import "Patient.h"

@implementation BadDoctor

- (void)patientFeelsBad:(Patient *)patient {
    
    NSLog(@"Patient %@ feels bad", patient.name);
    
    if ((patient.temperature >= 38 && patient.temperature < 40) || (patient.bloodPressure > 120)) {
        [patient haveRest];
    } else if ((patient.temperature >= 40) || (patient.bloodPulse < 50)) {
        [patient takePill];
    } else {
        [patient makeShot];
    }
    
}

@end
