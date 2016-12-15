//
//  ViewController.m
//  CoreData.Intro.HW
//
//  Created by Artem Belkov on 07/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

typedef enum {
    StudentFieldTagFirstName   = 1,
    StudentFieldTagLastName    = 2,
    StudentFieldTagDateOfBirth = 3,
    StudentFieldTagGrade       = 4,
} StudentFieldTag;

@interface ViewController ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd.MM.yyyy"];
    
    Student *student = [[Student alloc] init];
    
    student.firstName = @"Mister";
    student.lastName = @"Robot";
    
    student.gender = StudentGenderMale;
    student.grade = 25246;

    self.student = student;
    
    [self addObserversToStudentProperties];
    [self showStudentInfo];
    
}

- (void)dealloc {
    
    [self.student removeObserver:self forKeyPath:@"firstName"];
    [self.student removeObserver:self forKeyPath:@"lastName"];
    [self.student removeObserver:self forKeyPath:@"gender"];
    [self.student removeObserver:self forKeyPath:@"grade"];
    [self.student removeObserver:self forKeyPath:@"dateOfBirth"];
    
}

#pragma mark - Student Data

- (void)showStudentInfo {
    
    self.firstNameField.text = self.student.firstName;
    self.lastNameField.text = self.student.lastName;
    
    self.dateOfBirthField.text = [self.dateFormatter stringFromDate:self.student.dateOfBirth];
    self.genderControl.selectedSegmentIndex = self.student.gender;
    self.gradeField.text = [NSString stringWithFormat:@"%d", (int)self.student.grade];
    
}


#pragma mark - Observing

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    
    NSLog(@"\n\tobserveValueForKeyPath: %@\n\tofObject: %@\n\tchange: %@", keyPath, object , change);
    
}

- (void)addObserversToStudentProperties {
    
    [self.student addObserver:self
                    forKeyPath:@"firstName"
                       options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                       context:NULL];
    
    [self.student addObserver:self
                    forKeyPath:@"lastName"
                       options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                       context:NULL];
    
    [self.student addObserver:self
                    forKeyPath:@"gender"
                       options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                       context:NULL];
    
    [self.student addObserver:self
                    forKeyPath:@"grade"
                       options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                       context:NULL];
    
    [self.student addObserver:self
                    forKeyPath:@"dateOfBirth"
                       options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                       context:NULL];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == StudentFieldTagDateOfBirth) {
        return NO;
    }
    
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == StudentFieldTagFirstName) {
        self.student.firstName = self.firstNameField.text;
    } else if (textField.tag == StudentFieldTagLastName) {
        self.student.lastName = self.lastNameField.text;
    } else if (textField.tag == StudentFieldTagGrade) {
        self.student.grade = [self.gradeField.text integerValue];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == StudentFieldTagFirstName) {
        [self.lastNameField becomeFirstResponder];
    } else if (textField.tag == StudentFieldTagLastName) {
        [self.lastNameField resignFirstResponder];
    } else if (textField.tag == StudentFieldTagGrade) {
        [self.gradeField resignFirstResponder];
    }
    
    return YES;
    
}

#pragma mark - Actions

- (IBAction)actionDateOfBirthChange:(UIDatePicker *)sender {
    
    self.student.dateOfBirth = sender.date;
    
    [self showStudentInfo];
    
}

- (IBAction)actionGenderChange:(UISegmentedControl *)sender {
    
    self.student.gender = (StudentGender)sender.selectedSegmentIndex;
    
    [self showStudentInfo];
    
}

- (IBAction)resetProperties:(UIBarButtonItem *)sender {
    
    [self.student resetAllStudentProperties];
    
    [self showStudentInfo];
    
}

@end
