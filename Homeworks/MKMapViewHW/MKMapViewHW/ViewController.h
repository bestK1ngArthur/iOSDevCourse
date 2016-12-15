//
//  ViewController.h
//  MKMapViewHW
//
//  Created by Artem Belkov on 31/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UILabel *minCircleLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleCircleLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxCircleLabel;


@end

