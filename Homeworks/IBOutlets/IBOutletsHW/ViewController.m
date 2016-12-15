//
//  ViewController.m
//  IBOutletsHW
//
//  Created by Artem Belkov on 29/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];

    [self takeChessboardToCenter];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        
        for (UIView *blackCell in self.blackCells) {
            blackCell.backgroundColor = [UIColor colorWithRed:4.f/255 green:113.f/255 blue:116.f/255 alpha:1];
        }
        
    } else {
        
        for (UIView *blackCell in self.blackCells) {
            blackCell.backgroundColor = [UIColor blackColor];
        }
    }
    
    return YES;
}

#pragma mark - Chess

- (void)takeChessboardToCenter {
    
    NSInteger width = 0;
    NSInteger height = 0;
    
    if (([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft) || ([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)) {
        
        width = CGRectGetHeight(self.view.frame);
        height = width;
    
    } else {
        
        width = CGRectGetWidth(self.view.frame);
        height = width;
    }
    
    NSInteger x = 0;
    NSInteger y = (self.view.bounds.size.height - height) / 2;
    
    self.chessBoard.frame = CGRectMake(x, y, width, height);
    
}

@end
