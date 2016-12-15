//
//  ViewController.h
//  ControlsHW
//
//  Created by Artem Belkov on 05/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *animateView;

@property (strong, nonatomic) IBOutlet UISwitch *rotationSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *scaleSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *translationSwitch;

@property (strong, nonatomic) IBOutlet UISlider *speedSlider;
@property (strong, nonatomic) IBOutlet UISlider *scaleSlider;

@property (strong, nonatomic) IBOutlet UILabel *speedSliderLabel;
@property (strong, nonatomic) IBOutlet UILabel *scaleSliderLabel;

- (IBAction)valueChangedAction:(UIView *)sender;


@end

