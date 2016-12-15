//
//  ViewController.h
//  UIPopoverControllerHW
//
//  Created by Artem Belkov on 26/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DateViewController.h"
#import "EducationTableViewController.h"

@interface ViewController : UITableViewController <UITextFieldDelegate, DateViewControllerDelegate, EducationTableViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *aboutBarButton;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@property (weak, nonatomic) IBOutlet UITextField *educationTextField;

@property (weak, nonatomic) IBOutlet UITableViewCell *dateOfBirthCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *educationCell;

- (IBAction)actionSave:(UIButton *)sender;

@end

