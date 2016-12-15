//
//  Doctor.m
//  DelegatesHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Doctor.h"
#import "Patient.h"

@implementation Doctor

#pragma mark- PatientDelegate

- (void)patientFeelsBad:(Patient *)patient {
    
    NSLog(@"Patient %@ feels bad", patient.name);
    
    if ((patient.temperature >= 38 && patient.temperature < 40) || (patient.bloodPressure > 120)) {
        [patient takePill];
    } else if ((patient.temperature >= 40) || (patient.bloodPulse < 50)) {
        [patient makeShot];
    } else {
        [patient haveRest];
    }
    
}

@end
