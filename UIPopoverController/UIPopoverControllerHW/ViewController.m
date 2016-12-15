//
//  ViewController.m
//  UIPopoverControllerHW
//
//  Created by Artem Belkov on 26/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    GenderMale   = 0,
    GenderFemale = 1,
} Gender;

static NSString *kUserFirstName = @"userFirstName";
static NSString *kUserLastName = @"userLastName";
static NSString *kUserGender = @"userGender";
static NSString *kUserDateOfBirth = @"userDateOfBirth";
static NSString *kUserEducation = @"userEducation";

typedef enum {
    
    TextFieldTagFirstName = 1,
    TextFieldTagLastName  = 2,
    TextFieldTagDateOfBirth = 3,
    TextFieldTagEducation  = 4,
    
} TextFieldTag;

@interface ViewController ()

@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSUserDefaults *userDefaults;

@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd.MM.yyyy"];

    self.userDefaults = [NSUserDefaults standardUserDefaults];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadData];
}

#pragma mark - userDefaults

- (void)saveMainData {
    
    NSString *firstName = self.firstNameTextField.text;
    NSString *lastName = self.lastNameTextField.text;

    [self.userDefaults setObject:firstName forKey:kUserFirstName];
    [self.userDefaults setObject:lastName forKey:kUserLastName];

}

- (void)saveBasicData {
    
    Gender gender = (Gender)self.genderSegmentedControl.selectedSegmentIndex;
    NSDate *dateOfBirth = [self.dateFormatter dateFromString:self.dateOfBirthTextField.text];
    
    [self.userDefaults setInteger:(int)gender forKey:kUserGender];
    [self.userDefaults setObject:dateOfBirth forKey:kUserDateOfBirth];
    
}

- (void)saveAdditionalData {
    
    NSString *educationType = self.educationTextField.text;
    
    [self.userDefaults setObject:educationType forKey:kUserEducation];
    
}

- (void)saveData {

    [self saveMainData];
    [self saveBasicData];
    [self saveAdditionalData];
    
}

- (void)loadData {
    
    NSString *firstName = [self.userDefaults objectForKey:kUserFirstName];
    NSString *lastName = [self.userDefaults objectForKey:kUserLastName];
    Gender gender = (Gender)[self.userDefaults integerForKey:kUserGender];
    NSDate *dateOfBirth = [self.userDefaults objectForKey:kUserDateOfBirth];
    NSString *educationType = [self.userDefaults objectForKey:kUserEducation];
    
    self.firstNameTextField.text = firstName;
    self.lastNameTextField.text = lastName;
    self.genderSegmentedControl.selectedSegmentIndex = (int)gender;
    self.dateOfBirthTextField.text = [self.dateFormatter stringFromDate:dateOfBirth];
    self.educationTextField.text = educationType;
    
}

- (IBAction)actionSave:(UIButton *)sender {
    
    [self saveData];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == TextFieldTagDateOfBirth) {
    
        
        DateViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DateViewController"];
        viewController.delegate = self;
        
        UINavigationController *navViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:navViewController];
            [popover presentPopoverFromRect:self.dateOfBirthCell.frame
                                     inView:self.view
                   permittedArrowDirections:UIPopoverArrowDirectionDown
                                   animated:YES];
            
        } else {
            
            [self presentViewController:navViewController animated:YES completion:nil];
            
        }
        
        return NO;
    
    } else if (textField.tag == TextFieldTagEducation) {
        
        
        EducationTableViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EducationTableViewController"];
        viewController.delegate = self;
        
        UINavigationController *navViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:navViewController];
            [popover presentPopoverFromRect:self.educationCell.frame
                                     inView:self.view
                   permittedArrowDirections:UIPopoverArrowDirectionDown
                                   animated:YES];
            
        } else {
            
            [self presentViewController:navViewController animated:YES completion:nil];
            
        }
        
        return NO;
        
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ((textField.tag == TextFieldTagFirstName) || (textField.tag == TextFieldTagLastName)) {
        if ([textField.text length] >= 12) {
            return NO;
        }
    } else if ((textField.tag == TextFieldTagDateOfBirth) || (textField.tag == TextFieldTagEducation)) {
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == TextFieldTagFirstName) {
        [self.lastNameTextField becomeFirstResponder];
    } else if (textField.tag == TextFieldTagLastName) {
        [self saveMainData];
        [textField resignFirstResponder];
        [self.dateOfBirthTextField becomeFirstResponder];
    } else if (textField.tag == TextFieldTagDateOfBirth) {
        [self saveBasicData];
        [self.educationTextField becomeFirstResponder];
    } else if (textField.tag == TextFieldTagEducation){
        [self.educationTextField resignFirstResponder];
        [self saveAdditionalData];
    }
    
    return YES;
}

#pragma mark - DateViewControllerDelegate

- (void)changeDateOgBirth:(NSDate *)dateOfBirth {
    
    self.dateOfBirthTextField.text = [self.dateFormatter stringFromDate:dateOfBirth];
    
}

#pragma mark - EducationTableViewControllerDelegate

- (void)changeEducationType:(NSString *)educationType {
    
    self.educationTextField.text = educationType;
    [self saveAdditionalData];
    
}

@end
