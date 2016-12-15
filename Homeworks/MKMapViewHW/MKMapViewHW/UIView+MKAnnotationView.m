//
//  UIView+MKAnnotationView.m
//  MKMapViewLesson.Part1
//
//  Created by Artem Belkov on 30/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "UIView+MKAnnotationView.h"
#import <MapKit/MKAnnotationView.h>

@implementation UIView (MKAnnotationView)

- (MKAnnotationView *)superAnnotationView {

    if ([self isKindOfClass:[MKAnnotationView class]]) {
        return (MKAnnotationView *)self;
    }

    if (!self.superview) {
        return nil;
    }
    
    return [self.superview superAnnotationView];
}

@end