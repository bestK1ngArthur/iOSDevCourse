//
//  UIView+MKAnnotationView.h
//  MKMapViewLesson.Part1
//
//  Created by Artem Belkov on 30/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKAnnotationView;

@interface UIView (MKAnnotationView)

- (MKAnnotationView *)superAnnotationView;

@end
