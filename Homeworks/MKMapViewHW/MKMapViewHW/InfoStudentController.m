//
//  InfoStudentController.m
//  MKMapViewHW
//
//  Created by Artem Belkov on 02/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "InfoStudentController.h"
#import <MapKit/MapKit.h>

@interface InfoStudentController ()

@end

@implementation InfoStudentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(actionDone:)];
    
    self.firstNameLabel.text = self.student.firstName;
    self.lastNameLabel.text = self.student.lastName;
    
    if (self.student.gender == GenderMale) {
        self.genderLabel.text = @"Male";
    } else {
        self.genderLabel.text = @"Female";
    }
    
    self.dateOfBirthLabel.text = [self.student getDateOfBirthWithString];
    
    self.imageView.image = [Student image:self.student.image scaledToSize:CGSizeMake(150, 150)];
    
    self.addressCountryLabel.text = self.student.country;
    self.addressStateLabel.text = self.student.state;
    self.addressCityLabel.text = self.student.city;
    self.addressZipCodeLabel.text = self.student.zipCode;
    self.addressStreetLabel.text = self.student.street;
    self.addressNumberOfHouseLabel.text = self.student.numberOfHouse;
    
    self.navigationItem.title = [self.student getFullName];
    
}

#pragma mark - Actions

- (void)actionDone:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



@end
