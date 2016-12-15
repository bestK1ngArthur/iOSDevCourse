//
//  ViewController.m
//  ControlsHW
//
//  Created by Artem Belkov on 05/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) CGFloat speed;
@property (assign, nonatomic) CGFloat scale;
@property (assign, nonatomic) CGFloat rotation;

@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.speed = self.speedSlider.value;
    self.scale = self.scaleSlider.value;

    [self moveView:self.animateView];

}

- (void)moveView:(UIView *)view {
    
    CGPoint center = [self getRandomPosition];
    
    CGFloat scale = self.scale * [self getRandomScale];
    CGFloat rotation = [self getRandomAngle];
    
    CGFloat duration = 3 / self.speed;
    
    CGAffineTransform transform;
    
    CGAffineTransform scaleTransform;
    CGAffineTransform rotationTransform;

    if (self.rotationSwitch.isOn) {
        
        rotationTransform = CGAffineTransformMakeRotation(rotation);
        transform = rotationTransform;
        
    } else if (self.scaleSwitch.isOn) {
        
        scaleTransform = CGAffineTransformMakeScale(scale, scale);
        transform = scaleTransform;
        
    } else if ((self.scaleSwitch.isOn) && (self.rotationSwitch.isOn)) {
        
        transform = CGAffineTransformConcat(scaleTransform, rotationTransform);
        
    }
    
    [UIView animateWithDuration: duration
                          delay: 0.f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         if (self.translationSwitch.isOn) {
                             view.center = center;
                         }
                         
                         if (self.scaleSwitch.isOn || self.rotationSwitch.isOn) {
                             view.transform = transform;
                         }
                         
                         
                     }
                     completion:^(BOOL finished) {
                         
                         __weak UIView *weakView = view;
                         [self moveView:weakView];
                         
                     }];
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Statusbar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (IBAction)valueChangedAction:(UIView *)sender {
    
    if ([sender isKindOfClass:[UISlider class]]) {
        
        UISlider *slider = (UISlider *)sender;
        
        if (slider.tag == 1) {
            self.speed = slider.value;
            self.speedSliderLabel.text = [NSString stringWithFormat:@"x%d", (int)slider.value];
        } else if (slider.tag == 2) {
            self.scale = slider.value;
            self.scaleSliderLabel.text = [NSString stringWithFormat:@"x%d", (int)slider.value];
        }
    }
}


#pragma mark - Other

- (CGPoint)getRandomPosition {
    
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 199.f);
    
    CGFloat x = arc4random() % (int)CGRectGetWidth(rect) + CGRectGetMinX(rect);
    CGFloat y = arc4random() % (int)CGRectGetHeight(rect) + CGRectGetMinY(rect);
    
    return CGPointMake(x, y);
}

- (CGFloat)getRandomScale {
    
    CGFloat scale = (float)(arc4random() % 151) / 100.f + 0.5f;
    
    return scale;
}

- (CGFloat)getRandomAngle {
    
    CGFloat angle = (double)(arc4random() % (int)(M_PI * 2 * 10000)) / 10000 - M_PI;
    
    return angle;
    
}

@end
