//
//  Student.m
//  CoreData.Intro.HW
//
//  Created by Artem Belkov on 07/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void)resetAllStudentProperties {
    
    [self willChangeValueForKey:@"firstName"];
    _firstName = @"";
    [self didChangeValueForKey:@"firstName"];
    
    [self willChangeValueForKey:@"lastName"];
    _lastName = @"";
    [self didChangeValueForKey:@"lastName"];
    
    [self willChangeValueForKey:@"gender"];
    _gender = 0;
    [self didChangeValueForKey:@"gender"];
    
    [self willChangeValueForKey:@"dateOfBirth"];
    _dateOfBirth = nil;
    [self didChangeValueForKey:@"dateOfBirth"];
    
    [self willChangeValueForKey:@"grade"];
    _grade = 0;
    [self didChangeValueForKey:@"grade"];

}

- (Student *)setNameAndReturnFriend {

    Student *friend = [self valueForKey:@"friend"];
    
    if (friend) {
        
        NSLog(@"%@ %@ is friend to %@ %@", friend.firstName, friend.lastName, self.firstName, self.lastName);
        
    }
    
    [self setValue:@"any" forKey:@"firstName"];
    [self setValue:@"any" forKey:@"lastName"];
    
    if (friend) {
                
        return [friend setNameAndReturnFriend];
        
    } else {
        
        return self;
        
    }
    
}

#pragma mark - Date

+ (NSDate *)randomDateOfBirth {
    
    int day = arc4random_uniform(29);
    int month = arc4random_uniform(11);
    int year = -(arc4random() % 80) - 1;
    
    NSDate *today = [NSDate new];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *offsetComponents = [NSDateComponents new];
    [offsetComponents setDay:day];
    [offsetComponents setMonth:month];
    [offsetComponents setYear:year];
    
    NSDate *randomDate = [gregorian dateByAddingComponents:offsetComponents
                                                    toDate:today options:0];
    
    return randomDate;
}

@end

#pragma mark -

@implementation StudentGroup

- (NSArray *)studentsNames {
    
    NSMutableArray *studentNames = [NSMutableArray array];
    
    for (Student *student in self.students) {
        
        NSString *fullName = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        
        [studentNames addObject:fullName];
        
    }
    
    return studentNames;
}

- (NSDictionary *)firstAndLastYearsOfBirth {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];

    NSInteger firstYear = 2016;
    NSInteger lastYear = 0;
    
    for (Student *student in self.students) {
        
        NSInteger studentYear = [[dateFormatter stringFromDate:student.dateOfBirth] integerValue];
                
        if (studentYear > lastYear) {
            lastYear = studentYear;
        } else if (studentYear < firstYear) {
            firstYear = studentYear;
        }
        
    }
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithInt:(int)firstYear], @"firstYear",
                                [NSNumber numberWithInt:(int)lastYear], @"lastYear", nil];
    
    return dictionary;
}

- (float)averageGrade {
    
    float averageGrade = 0;
    
    for (Student *student in self.students) {
        
        averageGrade += (float)student.grade;
        
    }
    
    
    averageGrade /= (float)[self.students count];
    
    return averageGrade;
}

- (NSInteger)sumOfGrades {
    
    NSInteger sumOfGrades = 0;
    
    for (Student *student in self.students) {
        
        sumOfGrades += student.grade;
        
    }
    
    return sumOfGrades;
}

@end
