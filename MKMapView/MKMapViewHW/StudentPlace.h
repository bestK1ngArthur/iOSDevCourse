//
//  StudentPlace.h
//  MKMapViewHW
//
//  Created by Artem Belkov on 02/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

static const NSInteger minCircleRadius    = 300;
static const NSInteger middleCircleRadius = 600;
static const NSInteger maxCircleRadius    = 900;

@interface StudentPlace : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle andCoordinate:(CLLocationCoordinate2D)coordinate;

- (void)addCircleOverlaysOnMapView:(MKMapView *)mapView;

@end
