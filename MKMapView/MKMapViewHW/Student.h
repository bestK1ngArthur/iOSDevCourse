//
//  Student.h
//  MKMapViewHW
//
//  Created by Artem Belkov on 31/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum {
    GenderMale,
    GenderFemale,
} Gender;

@interface Student : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;

@property (assign, nonatomic) Gender gender;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) NSDate *dateOfBirth;
@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *zipCode;
@property (strong, nonatomic) NSString *street;
@property (strong, nonatomic) NSString *numberOfHouse;

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

+ (NSArray *)generateArrayOfRandomStudentsWithCount:(NSInteger)count andUserLocation:(CLLocation *)userLocaion;
+ (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size;

- (NSString *)getFullName;
- (NSString *)getDateOfBirthWithString;

@end
