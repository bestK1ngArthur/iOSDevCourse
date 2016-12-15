//
//  Student.m
//  BitwiseOperationsHW
//
//  Created by Artem Belkov on 26/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Student.h"

@implementation Student

- (StudentType)identifyStudentType {
    
    StudentType studentType = StudentTypeHumanitian;
    
    if ((self.subjectType & StudentSubjectTypeMath) || (self.subjectType & StudentSubjectTypeComputerScience) || (self.subjectType & StudentSubjectTypeEngineering) || (self.subjectType & StudentSubjectTypePhysics)) {
        
        studentType = StudentTypeTechnician;
        
    }
    
    return studentType;
}

- (NSString *)answerByType:(StudentSubjectType) type {
    return self.subjectType & type ? @"YES" : @"NO";
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ studies"
            "\nBiology: %@"
            "\nMath: %@"
            "\nComputer Science: %@"
            "\nEngineering: %@"
            "\nArt: %@"
            "\nPhysics: %@"
            "\nAnatomy: %@",
            self.name,
            [self answerByType:StudentSubjectTypeBiology],
            [self answerByType:StudentSubjectTypeMath],
            [self answerByType:StudentSubjectTypeComputerScience],
            [self answerByType:StudentSubjectTypeEngineering],
            [self answerByType:StudentSubjectTypeArt],
            [self answerByType:StudentSubjectTypePhysics],
            [self answerByType:StudentSubjectTypeAnatomy]];
}

@end