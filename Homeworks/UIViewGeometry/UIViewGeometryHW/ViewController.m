//
//  ViewController.m
//  UIViewGeometryHW
//
//  Created by Artem Belkov on 28/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.chessField = [[UIView alloc] init];
    [self.view addSubview:self.chessField];
    
    self.chessField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                       UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    [self drawChessTableWithCellsInLine:8 inRow:8 withIndent:0];

}

#pragma mark - Chess

- (void)drawChessTableWithCellsInLine:(NSInteger) countInLine inRow:(NSInteger) countInRow withIndent:(NSInteger) indent {
    
    NSInteger width = (self.view.bounds.size.width - 2 * indent) / countInLine;
    NSInteger height = width; //(self.view.bounds.size.height - 3 * indent) / countInRow;
    
    NSInteger x = self.view.bounds.size.width / 2 - indent - (countInLine / 2 * width);
    NSInteger y = self.view.bounds.size.height / 2 - indent - (countInRow / 2 * height);
    
    self.chessField.frame = CGRectMake(x, y, countInLine * width, countInRow * height);
    
    for (int line = 0; line < countInLine; line++) {
        for (int row = 0; row < countInRow; row++) {
            
            NSInteger x = indent + line * width;
            NSInteger y = 20 + indent + row * height;
            
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            
            if ((line + row) % 2 == 0) {
                view.backgroundColor = [UIColor whiteColor];
            } else {
                view.backgroundColor = [UIColor blackColor];
            }
            
            [self.chessField addSubview:view];
        }
    }
    
}

#pragma mark - Rotation

- (BOOL)shouldAutorotate {
    
    NSLog(@"shouldAutorotate");
    
    return YES;
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
