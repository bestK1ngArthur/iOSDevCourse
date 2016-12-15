//
//  Student.h
//  CoreData.Intro.HW
//
//  Created by Artem Belkov on 07/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    StudentGenderMale,
    StudentGenderFemale,
} StudentGender;

@interface Student : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;

@property (strong, nonatomic) NSDate *dateOfBirth;
@property (assign, nonatomic) StudentGender gender;
@property (assign, nonatomic) NSInteger grade;

@property (weak, nonatomic) Student *friend;

+ (NSDate *)randomDateOfBirth;

- (void)resetAllStudentProperties;
- (Student *)setNameAndReturnFriend;

@end

@interface StudentGroup : NSObject

@property (strong, nonatomic) NSArray *students;

- (NSArray *)studentsNames;

- (NSDictionary *)firstAndLastYearsOfBirth;

- (float)averageGrade;
- (NSInteger)sumOfGrades;

@end