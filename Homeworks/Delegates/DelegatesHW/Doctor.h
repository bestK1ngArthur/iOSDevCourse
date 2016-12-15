//
//  Doctor.h
//  DelegatesHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PatientDelegate;

@interface Doctor : NSObject <PatientDelegate>

@end
