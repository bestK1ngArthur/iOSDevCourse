//
//  Student.m
//  MKMapViewHW
//
//  Created by Artem Belkov on 31/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Student.h"

static NSString *firstMaleNames[] = {
    
    @"Spencer", @"Roger", @"Willis", @"Rodrigo", @"Quinton",
    @"Ward", @"Phillip", @"Gerry", @"Carlton", @"James",
    @"Roosevelt", @"Lewis", @"Andrew", @"Philip", @"Eldridge",
    @"Derrick", @"Randal", @"Jackson", @"Christopher", @"Dario",
    @"Les", @"Bernardo", @"Clyde", @"Ricardo", @"Stacey",
    @"Otha", @"Desmond", @"Rashad", @"Bret", @"Barton",
    @"Freddie", @"Levi", @"Jamie", @"Grover", @"Shelby",
    @"Wendell", @"Edmond", @"Brendan", @"Sanford", @"Samuel",
    @"Waylon", @"Kirk", @"Lacy", @"Van",@"Hans",
    @"William", @"Vance", @"Tommie", @"Kurtis", @"Gregorio"
    
};

static NSString *firstFemaleNames[] = {
    
    @"Shaunda", @"Mechelle", @"Mindy", @"Palmira", @"Samara",
    @"Marci", @"Nicole", @"Inge", @"Jo", @"Mabelle",
    @"Jeannine", @"Kathrin", @"Ginger", @"Yang", @"Iris",
    @"Meggan", @"Fredricka", @"Jackelyn", @"Dionna", @"Suanne",
    @"Marceline", @"Marguerita", @"Donita", @"Mallie", @"Luisa",
    @"Eun", @"Reagan", @"Tayna", @"Oliva", @"Kimberley",
    @"Iraida", @"Lizabeth", @"Yan", @"Myrtice", @"Lucienne",
    @"Gay", @"Justine", @"Ryann", @"Pearline", @"Wynell",
    @"Marine", @"Kimiko", @"Lashanda", @"Mattie", @"Leeann",
    @"Wilda", @"Eliza", @"Felipa", @"Michaela", @"Carlota"
    
};

static NSString *lastNames[] = {
    
    @"Ruf", @"Raco", @"Castiglione", @"Siegle", @"Byas",
    @"Klatt", @"Hogan", @"Vanmeter", @"Harbert", @"Petties",
    @"Laffoon", @"Finch", @"Wilford", @"Scovil", @"Gourlay",
    @"Parkin", @"Havlik", @"Foti", @"Gamez", @"Brighton",
    @"Borland", @"Petrin", @"Phillippe", @"Carlo", @"Walder",
    @"Mcnerney", @"Strasser",@"Delafuente", @"Mcenaney", @"Reny",
    @"Whittenburg", @"Gammons", @"Stamey", @"Youngblood", @"Alcala",
    @"Osborne", @"Pigeon", @"Weitz", @"Waite", @"Wester",
    @"Low", @"Besecker", @"Selander", @"Wolak", @"Maricle",
    @"Fritzler", @"Wheatley", @"Rasmussen", @"Register", @"Mullinax"
    
};

static NSInteger namesCount = 50;

@interface Student ()

@property (strong, nonatomic) CLGeocoder *geoCoder;


@end

@implementation Student

- (NSString *)description
{
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    
    NSString *gender;
    
    if (self.gender == GenderMale) {
        gender = @"male";
    } else {
        gender = @"female";
    }
    
    return [NSString stringWithFormat:@"%@ (%@)", fullName, gender];
}

- (NSString *)getFullName {
 
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    
}

- (NSString *)getDateOfBirthWithString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd.MM.YYYY"];
    
    return [dateFormatter stringFromDate:self.dateOfBirth];
}
    
#pragma mark - Get Students

+ (NSArray *)generateArrayOfRandomStudentsWithCount:(NSInteger)count andUserLocation:(CLLocation *)userLocaion {
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < count; i++) {
        
        Student *student = [[Student alloc] init];
        
        student.gender = arc4random_uniform(2);
        
        if (student.gender == GenderMale) {
            student.firstName = firstMaleNames[arc4random() % namesCount];
        } else {
            student.firstName = firstFemaleNames[arc4random() % namesCount];
        }
        student.lastName = lastNames[arc4random() % namesCount];
        
        student.location = [student randomStudentLocationWithUserLocation:userLocaion];
        student.dateOfBirth = [self randomDateOfBirth];
        //student.image = [Student image:[UIImage imageNamed:@"Male"] scaledToSize:CGSizeMake(32, 32)];
        student.image = [Student randomFaceImageForGender:student.gender];

        
        student.coordinate = student.location.coordinate;
        student.title = student.firstName;
        student.subtitle = student.lastName;
        
        student.geoCoder = [[CLGeocoder alloc] init];
        
        [student.geoCoder reverseGeocodeLocation:student.location completionHandler:^(NSArray * __nullable placemarks, NSError * __nullable error) {
            
            NSString *message = nil;
            
            if (error) {
                
                message = [error localizedDescription];
                
            } else {
            
                if ([placemarks count] > 0) {
                    
                    MKPlacemark *placemark = (MKPlacemark *)[placemarks firstObject];
                    
                    student.country = [placemark.country description];
                    student.state = [placemark.subAdministrativeArea description];
                    student.city = [placemark.locality description];
                    student.zipCode = [placemark.postalCode description];
                    student.street = [placemark.thoroughfare description];
                    student.numberOfHouse = [placemark.subThoroughfare description];
                    
                } else {
                    
                    message = @"No placemark found";
                    NSLog(@"%@", message);
                    
                }
                
            } 
            
        }];
        
        [array addObject:student];
    }
    
    /*
    for (Student *student in array) {
        NSLog(@"%@", student);
    }
    */
     
    return array;
}

#pragma mark - Location

- (CLLocation *)randomStudentLocationWithUserLocation:(CLLocation *)userLocation {
    
    CLLocationCoordinate2D coordinate;
    
    double deltaLatitude = (double)(arc4random() % 1000) / 100000;
    double deltaLongitude = (double)(arc4random() % 1000) / 100000;

    if (arc4random()%2) {
        coordinate.latitude = userLocation.coordinate.latitude + deltaLatitude;
    } else {
        coordinate.latitude = userLocation.coordinate.latitude - deltaLatitude;
    }
    
    if (arc4random()%2) {
        coordinate.longitude = userLocation.coordinate.longitude + deltaLongitude;
    } else {
        coordinate.longitude = userLocation.coordinate.longitude - deltaLongitude;
    }
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    
    return location;
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

#pragma mark - Image

+ (UIImage *)randomFaceImageForGender:(Gender)gender {
    
    UIImage *image;
    
    if (gender == GenderMale) {
        
        NSString *chars = @"ABCDEFGHIJKLMNO";
        
        NSInteger charIndex = (NSInteger)arc4random_uniform((int)[chars length]);
        NSInteger number = arc4random_uniform(5);
        
        NSString *imageName = [NSString stringWithFormat:@"%C0%d.png", [chars characterAtIndex: charIndex], number];
        
        image = [UIImage imageNamed:imageName];
        
    } else if (gender == GenderFemale) {
        
        NSString *chars = @"ABCDEFGHI";
        
        NSInteger charIndex = (NSInteger)arc4random_uniform((int)[chars length]);
        NSInteger number = arc4random_uniform(5);
        
        NSString *imageName = [NSString stringWithFormat:@"F%C0%d.png", [chars characterAtIndex: charIndex], number];
        
        image = [UIImage imageNamed:imageName];
        
    }
    
    if (!image) {
        image = [Student randomFaceImageForGender:gender];
    }
    
    return image;
}

+ (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size { // Change image size
    //avoid redundant drawing
    if (CGSizeEqualToSize(originalImage.size, size))
    {
        return originalImage;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

@end
