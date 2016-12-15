//
//  ViewController.m
//  TouchesHW
//
//  Created by Artem Belkov on 02/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    
    ChipColorBlack = 2,
    ChipColorWhite = 1,
    
} ChipColor;

@interface ViewController ()

@property (strong, nonatomic) UIColor *blackChipColor;
@property (strong, nonatomic) UIColor *whiteChipColor;

@property (assign, nonatomic) CGFloat indentFromChipInCell;

@property (weak, nonatomic) UIView *draggingCell;
@property (assign, nonatomic) CGPoint touchOffset;

@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indentFromChipInCell = 20.f;

    self.blackChipColor = [UIColor colorWithRed:4/255.f green:113/255.f blue:116/255.f alpha:1.f];
    self.whiteChipColor = [UIColor colorWithRed:74/255.f green:134/255.f blue:253/255.f alpha:1.f];
    
    [self placeChips];
    
    //NSLog(@"%@", self.fieldCells);

}

- (void)viewDidAppear:(BOOL)animated {
    
    //NSLog(@"%@", self.fieldCells);
    
}

#pragma mark - Chess

- (void)placeChips {
    
    // Up line
    for (int row = 0; row < 4; row++) {
        
        UIView *cell = [self.fieldCells objectAtIndex:row];
        
        [self placeChipOnCell:cell withColor:ChipColorBlack];
        
    }
    // Down line
    for (int row = 12; row < 16; row++) {
        
        UIView *cell = [self.fieldCells objectAtIndex:row];
        
        [self placeChipOnCell:cell withColor:ChipColorWhite];
        
    }
    
}

- (void)placeChipOnCell:(UIView *)cell withColor:(ChipColor)indexColor {
    
    CGFloat width = CGRectGetWidth(cell.bounds) - self.indentFromChipInCell;
    CGFloat height = CGRectGetHeight(cell.bounds) - self.indentFromChipInCell;
    
    UIView *chip = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    chip.center = cell.center;
    
    if (indexColor == 2) {
        chip.backgroundColor = self.blackChipColor;
    } else {
        chip.backgroundColor = self.whiteChipColor;
    }
    
    chip.layer.cornerRadius = CGRectGetHeight(chip.frame) / 2;
    
    [self.field addSubview:chip];
    
    cell.tag = cell.tag * -1;
    
}

- (UIView *)findNeighboringCellForChip:(UIView *)chip withColor:(ChipColor)chipColor {
    
    UIView *neighboringCell = [[UIView alloc] init];
    
    CGFloat lastDistance = CGRectGetHeight(self.view.bounds);
    CGFloat distance = 0.f;
    
    for (UIView *cell in self.fieldCells) {
        
        CGFloat dx = fabs(cell.center.x - chip.center.x);
        CGFloat dy = fabs(cell.center.y - chip.center.y);
        
        distance = sqrtf(dx * dx + dy * dy);
        
        if ((distance < lastDistance) && (cell.tag != chipColor)) { //&& (cell.tag != -1) && (cell.tag != -2)) {
            
            neighboringCell = cell;
            lastDistance = distance;
            
        }
    }
    
    return neighboringCell;
}

- (ChipColor)checkChipColor:(UIView *)chip {
    
    ChipColor chipColor = 0;
    
    if ([chip.backgroundColor isEqual:self.blackChipColor]) {
        chipColor = ChipColorBlack;
    } else {
        chipColor = ChipColorWhite;
    }
    
    return chipColor;
}


#pragma mark - Touches

- (void)logTouches:(NSSet *)touches withMethod:(NSString *)methodName {
    
    NSMutableString *string = [NSMutableString stringWithString:methodName];
    
    for (UITouch *touch in touches) {
        
        CGPoint point = [touch locationInView:self.view];
        [string appendFormat:@" %@", NSStringFromCGPoint(point)];
        
    }
    
    NSLog(@"%@", string);
    
}

- (void)onTouchesEnded {
    
    ChipColor chipColor = [self checkChipColor:self.draggingCell];
    
    UIView *neighboringCell = [self findNeighboringCellForChip:self.draggingCell withColor:chipColor];
    
    neighboringCell.tag = neighboringCell.tag * -1;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         self.draggingCell.transform = CGAffineTransformIdentity;
                         self.draggingCell.alpha = 1.f;
                         
                         self.draggingCell.center = neighboringCell.center;
                         
                     }];
    
    self.draggingCell = nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesBegan"];
    
    // cell.tag
    //  1 - White Cell Free
    //  2 - Black Cell Free
    // -1 - White Cell Busy
    // -2 - Black Cell Busy
    
    UITouch *touch = [touches anyObject];
        
    CGPoint pointOnMainView = [touch locationInView:self.field];
        
    UIView *view = [self.field hitTest:pointOnMainView withEvent:event];
        
    if ((![view isEqual:self.field]) && (view.tag != 1) && (view.tag != 2) && (view.tag != -1) && (view.tag != -2)) {
            
        ChipColor chipColor = [self checkChipColor:self.draggingCell];
        
        UIView *neighboringCell = [self findNeighboringCellForChip:view withColor:chipColor];
        
        neighboringCell.tag = neighboringCell.tag * -1;
        
        [self.field bringSubviewToFront:view];
            
        self.draggingCell = view;
            
        CGPoint touchPoint = [touch locationInView:self.draggingCell];
            
        self.touchOffset = CGPointMake(CGRectGetMidX(self.draggingCell.bounds) - touchPoint.x,
                                           CGRectGetMidY(self.draggingCell.bounds) - touchPoint.y);
            
        [UIView animateWithDuration:0.3
                             animations:^{
                                 
                                self.draggingCell.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                                self.draggingCell.alpha = 0.5f;
                                 
                            }];
            
    } else {
            
            self.draggingCell = nil;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    //[self logTouches:touches withMethod:@"touchesMoved"];
    
    if (self.draggingCell) {
        
        UITouch *touch = [touches anyObject];
        CGPoint pointOnMainView = [touch locationInView:self.field];
        
        CGPoint correction = CGPointMake(pointOnMainView.x + self.touchOffset.x,
                                         pointOnMainView.y + self.touchOffset.y);
        
        self.draggingCell.center = correction;
        
    }
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesEnded"];
    
    [self onTouchesEnded];
    
    //NSLog(@"%@", self.fieldCells);

}

- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    
    [self logTouches:touches withMethod:@"touchesCancelled"];
    
    [self onTouchesEnded];
    
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
