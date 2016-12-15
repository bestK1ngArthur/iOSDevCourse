//
//  ViewController.m
//  GesturesHW
//
//  Created by Artem Belkov on 02/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (assign, nonatomic) CGFloat ironManViewRotation;
@property (assign, nonatomic) CGFloat ironManViewScale;

@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];

    //Tap
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    
    //DoubleTap
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapGesture];
    
    //Swipe (right)
    UISwipeGestureRecognizer *rightSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(handleRightSwipe:)];
    rightSwipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipeGesture];

    //Swipe (left)
    UISwipeGestureRecognizer *leftSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(handleLeftSwipe:)];
    leftSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipeGesture];
    
    //Pintch
    UIPinchGestureRecognizer *pintchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePintch:)];
    [self.view addGestureRecognizer:pintchGesture];
    
    UIRotationGestureRecognizer *pintchRotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                                      action:@selector(handleRotation:)];
    [self.view addGestureRecognizer:pintchRotationGesture];
    
    pintchGesture.delegate = self;         //Our object's is delegate for pintch gestures
    pintchRotationGesture.delegate = self; //
    
    
    
}

- (void)rotateView:(UIView *)view withAngle:(CGFloat)angle {
    
    CGAffineTransform currentTransform = self.ironManView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, angle);
    
    [UIView animateWithDuration:1
                     animations:^{
                         view.transform = newTransform;
                     }];
    
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Gestures

- (void)handleTap:(UITapGestureRecognizer *)tapGesture {
    
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    [UIView animateWithDuration:2 animations:^{
        
        self.ironManView.center = [tapGesture locationInView:self.view];
        
    }];
    
}

- (void)handleDoubleTap:(UISwipeGestureRecognizer *)doubleTapGesture {
    
    NSLog(@"DoubleTap: %@", NSStringFromCGPoint([doubleTapGesture locationInView:self.view]));

    [self.ironManView.layer removeAllAnimations];
    
}

- (void)handleRightSwipe:(UISwipeGestureRecognizer *)rightSwipeGesture {
    
    NSLog(@"RightSwipe");
    
    [self rotateView:self.ironManView withAngle:3.14];
    
}

- (void)handleLeftSwipe:(UISwipeGestureRecognizer *)leftSwipeGesture {
    
    NSLog(@"LeftSwipe");
    
    [self rotateView:self.ironManView withAngle:-3.14];
    
}

- (void)handlePintch:(UIPinchGestureRecognizer *)pintchGesture {
    
    NSLog(@"Pintch: %1.2f", pintchGesture.scale);
    
    if (pintchGesture.state == UIGestureRecognizerStateBegan) {
        self.ironManViewScale = 1.f;
    }
    
    CGFloat newScale = 1.f + pintchGesture.scale - self.ironManViewScale;
    
    CGAffineTransform currentTransform = self.ironManView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    
    self.ironManView.transform = newTransform;
    self.ironManViewScale = pintchGesture.scale;
    
}

- (void)handleRotation:(UIRotationGestureRecognizer *)pintchRotationGesture {
    
    NSLog(@"Rotation: %1.2f", pintchRotationGesture.rotation);
    
    if (pintchRotationGesture.state == UIGestureRecognizerStateBegan) {
        self.ironManViewRotation = 0;
    }
    
    CGFloat newRotation = pintchRotationGesture.rotation - self.ironManViewRotation;
    
    CGAffineTransform currentTransform = self.ironManView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    
    self.ironManView.transform = newTransform;
    self.ironManViewRotation = pintchRotationGesture.rotation;
    
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
    
}

@end
