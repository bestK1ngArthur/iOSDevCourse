//
//  Student.h
//  BitwiseOperationsHW
//
//  Created by Artem Belkov on 26/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    StudentSubjectTypeBiology         = 1 << 0,
    StudentSubjectTypeMath            = 1 << 1,
    StudentSubjectTypeComputerScience = 1 << 2,
    StudentSubjectTypeEngineering     = 1 << 3,
    StudentSubjectTypeArt             = 1 << 4,
    StudentSubjectTypePhysics         = 1 << 5,
    StudentSubjectTypeAnatomy         = 1 << 6
    
} StudentSubjectType;

typedef enum {
    StudentTypeHumanitian,
    StudentTypeTechnician
} StudentType;

@interface Student : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) StudentSubjectType subjectType;

- (StudentType)identifyStudentType;

@end