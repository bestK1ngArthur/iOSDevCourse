//
//  DateViewController.m
//  UIPopoverControllerHW
//
//  Created by Artem Belkov on 26/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "DateViewController.h"
#import "ViewController.h"

static NSString *kUserDateOfBirth = @"userDateOfBirth";

@interface DateViewController ()

@property (strong, nonatomic) NSDate *currentDate;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadDateFromDatePicker];
    
    self.title = @"Choose date of birth";
}

- (void)dealloc {
    
    [self saveDateFromDatePicker];
    [self.delegate changeDateOgBirth:self.datePicker.date];
    
}

#pragma mark - Date

- (void)saveDateFromDatePicker {
    
    NSDate *date = self.datePicker.date;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:date forKey:kUserDateOfBirth];
    
    self.currentDate = date;
    
}

- (void)loadDateFromDatePicker {

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSDate *date = [userDefaults objectForKey:kUserDateOfBirth];
    
    if (date) {
        self.datePicker.date = date;
        self.currentDate = date;
    }
    
}

#pragma mark - Actions

- (IBAction)actionSave:(UIButton *)sender {
    
    [self.delegate changeDateOgBirth:self.datePicker.date];
    [self saveDateFromDatePicker];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)actionDateChanged:(UIDatePicker *)sender {
    
    [self.delegate changeDateOgBirth:self.datePicker.date];

}


@end
