//
//  ViewController.h
//  CoreData.Intro.HW
//
//  Created by Artem Belkov on 07/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Student;

@interface ViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) Student *student;

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateOfBirthPicker;

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;
@property (weak, nonatomic) IBOutlet UITextField *gradeField;

- (IBAction)actionDateOfBirthChange:(UIDatePicker *)sender;
- (IBAction)actionGenderChange:(UISegmentedControl *)sender;
- (IBAction)resetProperties:(UIBarButtonItem *)sender;


@end

