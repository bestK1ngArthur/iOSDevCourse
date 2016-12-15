//
//  StudentPlace.m
//  MKMapViewHW
//
//  Created by Artem Belkov on 02/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "StudentPlace.h"

@implementation StudentPlace

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle andCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
        
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = coordinate;
        
    }
    return self;
}

- (void)addCircleOverlaysOnMapView:(MKMapView *)mapView {
    
    MKCircle *circle1 = [MKCircle circleWithCenterCoordinate:self.coordinate radius:minCircleRadius];
    MKCircle *circle2 = [MKCircle circleWithCenterCoordinate:self.coordinate radius:middleCircleRadius];
    MKCircle *circle3 = [MKCircle circleWithCenterCoordinate:self.coordinate radius:maxCircleRadius];
    
    NSArray *circles = [NSArray arrayWithObjects:circle1, circle2, circle3, nil];
    
    [mapView addOverlays:circles];
    
}

@end
