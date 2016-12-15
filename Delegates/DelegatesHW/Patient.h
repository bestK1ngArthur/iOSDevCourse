//
//  Patient.h
//  DelegatesHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PatientDelegate;

@interface Patient : NSObject

@property (strong, nonatomic) NSString *name;
@property (weak, nonatomic) id <PatientDelegate> delegate;

@property (assign, nonatomic) float temperature;

@property (assign, nonatomic) float bloodPulse;
@property (assign, nonatomic) float bloodPressure;

- (BOOL)howAreYou;

- (void)takePill;
- (void)makeShot;
- (void)haveRest;

@end


@protocol PatientDelegate <NSObject>

- (void)patientFeelsBad: (Patient *)patient;

@end
