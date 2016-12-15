//
//  ViewController.m
//  AnimationsHW
//
//  Created by Artem Belkov on 30/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    NSMutableArray *centers = [NSMutableArray array];
    
    for (UIView *view in self.views) {
        
        CGPoint center = view.center;
        [centers addObject:[NSValue valueWithCGPoint:center]];
    
    }
    
    self.centers = centers;
    
}

- (void)moveViews {
    
    for (int i = 0; i < [self.views count] - 1; i++) {
    
        UIView *view = [self.views objectAtIndex:i];
        UIView *nextView = [[UIView alloc] init];
        
        NSValue *centerValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
        
        if (i == ([self.views count] - 1)) {
            nextView = [self.views objectAtIndex:0];
            centerValue = [self.centers objectAtIndex:0];
        } else {
            nextView = [self.views objectAtIndex:i+1];
            centerValue = [self.centers objectAtIndex:i+1];
        }
        
        CGPoint center = [centerValue CGPointValue];
        
        [UIView animateWithDuration:5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             
                             view.center = center;
                             view.backgroundColor = nextView.backgroundColor;
                             
                         }
                         completion:^(BOOL finished) {
                             
                             [self moveViews];
                             
                         }];
    }
   
}

- (void)moveView:(UIView *) view withOptions:(UIViewAnimationOptions) options {
    
    options = options | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse;
    
    CGFloat x = CGRectGetWidth(self.view.bounds) - view.center.x;
    CGFloat y = view.center.y;
    
    [UIView animateWithDuration:5
                          delay:0
                        options:options
                     animations:^{
                         
                         view.center = CGPointMake(x, y);
                         view.backgroundColor = [self getRandomColor];
                         
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

#pragma mark - Color

- (UIColor *)getRandomColor {
    
    CGFloat red = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat green = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat blue = (CGFloat)(arc4random() % 256) / 255.f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
    
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
