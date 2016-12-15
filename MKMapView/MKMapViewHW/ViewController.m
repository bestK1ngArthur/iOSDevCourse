//
//  ViewController.m
//  MKMapViewHW
//
//  Created by Artem Belkov on 31/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"
#import "InfoStudentController.h"

#import <MapKit/MapKit.h>
#import "UIView+MKAnnotationView.h"

#import "Student.h"
#import "StudentPlace.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UIPopoverControllerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *userLocation;

@property (strong, nonatomic) NSArray *students;
@property (strong, nonatomic) StudentPlace *studentPlace;

@property (strong, nonatomic) CLGeocoder *geoCoder;
@property (strong, nonatomic) MKDirections *directions;

@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.userLocation = [[CLLocation alloc] initWithLatitude:55.63006 longitude:37.848987];
    
    [self generateAndShowStudentPlaceWithTitle:@"Party" subtitle:@"iOSDevCourse"];
    [self generateAndShowStudentsWithCount:5];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(actionAdd:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *zoomButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                               target:self
                                                                               action:@selector(actionZoom:)];
    self.navigationItem.leftBarButtonItem = zoomButton;
    
    self.geoCoder = [[CLGeocoder alloc] init];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self actionZoom:nil];
    
    [self updateCirclesLabels];
    
}

- (void)updateCirclesLabels {
    
    self.minCircleLabel.text = [NSString stringWithFormat:@"%d", (int)[self numberOfStudentsInRadius:minCircleRadius]];
    self.middleCircleLabel.text = [NSString stringWithFormat:@"%d", (int)[self numberOfStudentsInRadius:middleCircleRadius]];
    self.maxCircleLabel.text = [NSString stringWithFormat:@"%d", (int)[self numberOfStudentsInRadius:maxCircleRadius]];
    
}

- (void)dealloc {
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    if ([self.directions isCalculating]) {
        [self.directions cancel];
    }
    
}

#pragma mark - Students 

- (void)generateAndShowStudentsWithCount:(NSInteger)count { // Generate students
    
    self.students = [Student generateArrayOfRandomStudentsWithCount:count andUserLocation:self.userLocation];
    
    for (Student *student in self.students) {
        [self.mapView addAnnotation:student];
    }
    
}

- (void)generateAndShowStudentPlaceWithTitle:(NSString *)title subtitle:(NSString *)subtitle { // Generate party
    
    self.studentPlace = [[StudentPlace alloc] initWithTitle:title subtitle:subtitle andCoordinate:self.userLocation.coordinate];
    
    [self.mapView addAnnotation:self.studentPlace];
    [self showCirclesOnStudentPlace];
    
}

-(NSInteger)numberOfStudentsInRadius:(CGFloat)radius {
    
    NSInteger numberOfStudents = 0;
    
    CLLocation* studentPlaceLocation = [[CLLocation alloc] initWithLatitude:self.studentPlace.coordinate.latitude
                                                                  longitude:self.studentPlace.coordinate.longitude];
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        if ([annotation isKindOfClass:[Student class]]) {
            
            Student* student = (Student *)annotation;
            
            CLLocation* studentLocation = [[CLLocation alloc] initWithLatitude:student.coordinate.latitude
                                                                     longitude:student.coordinate.longitude];
            
            CLLocationDistance distance = [studentPlaceLocation distanceFromLocation:studentLocation];
            
            if (distance < radius) {
                
                numberOfStudents++;
            }
        }
    }
    
    return numberOfStudents;
}

#pragma mark - Overlays

- (void)showCirclesOnStudentPlace {
    
    for (id <MKOverlay> overlay in self.mapView.overlays) { // Remove last circles
        
        if ([overlay isKindOfClass:[MKCircle class]]) {
            
            [self.mapView removeOverlay:overlay];
            
        }
        
    }
    
    [self.studentPlace addCircleOverlaysOnMapView:self.mapView]; // Add new circles
  
    [self updateCirclesLabels];
    
}

#pragma mark - MKMapViewDelegate


- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"Annotation";
    
    MKAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!annotationView) {
        
        if ([annotation isKindOfClass:[StudentPlace class]]) { // If party
            
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.canShowCallout = YES;
            annotationView.draggable = YES;
            
            annotationView.image = [UIImage imageNamed:@"Party"];
            
            UIButton *directionsButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
            [directionsButton addTarget:self action:@selector(actionShowDirections:) forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = directionsButton;
            
            UIImage *image = [Student image:[UIImage imageNamed:@"iOSDevCourseLogo"] scaledToSize:CGSizeMake(32, 32)];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            annotationView.leftCalloutAccessoryView = imageView;
             
        } else if ([annotation isKindOfClass:[Student class]]) { // If student
            
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.canShowCallout = YES;
            
            Student <MKAnnotation> *student = annotation;
            
            annotationView.image = [Student image:student.image scaledToSize:CGSizeMake(32, 32)];
            
            UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [infoButton addTarget:self action:@selector(actionShowInfo:) forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = infoButton;
            
        }
        
        
    }
    
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    
    if (newState == MKAnnotationViewDragStateStarting) {
        
        [self.mapView removeOverlays:self.mapView.overlays];
        
        annotationView.dragState = MKAnnotationViewDragStateDragging;
        
    } else if (newState == MKAnnotationViewDragStateEnding || newState == MKAnnotationViewDragStateCanceling) {

        [self showCirclesOnStudentPlace];
        
        annotationView.dragState = MKAnnotationViewDragStateNone;
    
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MKPolyline class]]) { // Create renderer for directions
        
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 3.f;
        renderer.strokeColor = [UIColor purpleColor];
        
        return renderer;
        
    } else if ([overlay isKindOfClass:[MKCircle class]]) { // Create renderer for circles
        
        MKCircleRenderer *renderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
        
        CGFloat alpha = 0;
        
        switch ((NSInteger)[(MKCircle *)overlay radius]) {
            case minCircleRadius:
                alpha = 0.3f;
                renderer.fillColor = [[UIColor greenColor] colorWithAlphaComponent:alpha];
                break;
            case middleCircleRadius:
                alpha = 0.2f;
                renderer.fillColor = [[UIColor yellowColor] colorWithAlphaComponent:alpha];
                break;
            case maxCircleRadius:
                alpha = 0.1f;
                renderer.fillColor = [[UIColor redColor] colorWithAlphaComponent:alpha];
                break;
            default:
                break;
        }
        
        return renderer;
    }
    
    return nil;
}

#pragma mark - Actions

- (void)actionAdd:(UIBarButtonItem *)sender { // Add student
    
    [self generateAndShowStudentsWithCount:1];
    
    [self updateCirclesLabels];
    
    [self actionZoom:nil];
    
}

- (void)actionZoom:(id)sender { // Update map's zoom
    
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D location = annotation.coordinate;
        
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 5000;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, 2 * delta, 2 * delta);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
        
    }
    
    zoomRect = [self.mapView mapRectThatFits:zoomRect];
    
    [self.mapView setVisibleMapRect:zoomRect
                        edgePadding:UIEdgeInsetsMake(20, 20, 20, 20)
                           animated:YES];
    
}

- (void)actionShowDirections:(id)sender { // Calculate and show directions from student to party
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        if ([annotation isKindOfClass:[Student class]]) {
             
            MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
            
            MKPlacemark *placemarkSource = [[MKPlacemark alloc] initWithCoordinate:annotation.coordinate addressDictionary:nil];
            request.source = [[MKMapItem alloc] initWithPlacemark:placemarkSource];
            
            MKPlacemark *placemarkDestination = [[MKPlacemark alloc] initWithCoordinate:self.studentPlace.coordinate addressDictionary:nil];
            request.destination  = [[MKMapItem alloc] initWithPlacemark:placemarkDestination];
            
            request.transportType = MKDirectionsTransportTypeAutomobile;
            
            self.directions = [[MKDirections alloc] initWithRequest:request];
            [self.directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * __nullable response, NSError * __nullable error) {
                
                if (!error) {
                
                    if ((self.userLocation.coordinate.latitude != self.studentPlace.coordinate.latitude) && (self.userLocation.coordinate.longitude != self.studentPlace.coordinate.longitude)) {
                        
                        for (id <MKOverlay> overlay in self.mapView.overlays) { // Remove old directions overlays
                            if ([overlay isKindOfClass:[MKPolyline class]]) {
                                [self.mapView removeOverlay:overlay];
                            }
                        }
                        
                    }
                    
                    NSMutableArray *overlays = [NSMutableArray array]; // Create and add new directions overlays
                    
                    for (MKRoute *route in response.routes) {
                        [overlays addObject:route.polyline];
                    }
                    
                    [self.mapView addOverlays:overlays level:MKOverlayLevelAboveRoads];
                    
                    self.userLocation = [[CLLocation alloc] initWithLatitude:self.studentPlace.coordinate.latitude
                                                                   longitude:self.studentPlace.coordinate.longitude];
                }
                
            }];
            
        }
    }
}

- (void)actionShowInfo:(UIButton *)sender { // Show popover/modal with student info
    
    MKAnnotationView *annotationView = [sender superAnnotationView];
    Student *student = (Student *)annotationView.annotation;
    
    InfoStudentController *infoStudentController = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoStudentController"];
    infoStudentController.student = student;
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:infoStudentController];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:nc];
        
        [popover presentPopoverFromRect:annotationView.frame
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
        
        popover.delegate = self;
        
    } else {
        
        infoStudentController.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        [self presentViewController:nc animated:YES completion:nil];
                
    }
    
}

@end
