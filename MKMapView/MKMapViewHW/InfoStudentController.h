//
//  InfoStudentController.h
//  MKMapViewHW
//
//  Created by Artem Belkov on 02/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

@interface InfoStudentController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *addressCountryLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressZipCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressStreetLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressNumberOfHouseLabel;

@property (strong, nonatomic) Student <MKAnnotation> *student;

@end
