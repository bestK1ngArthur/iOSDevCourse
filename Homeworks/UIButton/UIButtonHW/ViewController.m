//
//  ViewController.m
//  UIButtonHW
//
//  Created by Artem Belkov on 04/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) NSInteger answerAmountAfterDecimal;

@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];

    self.amountAfterDecimal = 0;
    self.answerAmountAfterDecimal = 3;
    
    self.modeType = ModeTypeClassic;
    
    [self.currentValueLabel setAdjustsFontSizeToFitWidth:YES];
    [self.lastValueLabel setAdjustsFontSizeToFitWidth:YES];

}

- (void)showCurrentValue {
    
    NSString *text = [NSString stringWithFormat:@".%d", (int)self.amountAfterDecimal];
    text = [text stringByAppendingString:@"f"];
    text = [@"%" stringByAppendingString:text];
    
    self.currentValueLabel.text = [NSString stringWithFormat:text, self.currentValue];
    
}

- (void)showLastValue {
    
    NSString *text = [NSString stringWithFormat:@".%d", (int)self.amountAfterDecimal];
    text = [text stringByAppendingString:@"f"];
    text = [@"%" stringByAppendingString:text];
    
    self.lastValueLabel.text = [NSString stringWithFormat:text, self.lastValue];
    
}

- (void)showAnswerValue {
    
    /*
    CGFloat value = self.currentValue;
    value = value - (int)value;
    
    NSInteger amountAfterDecimal = 0;
    
    while ((value - (int)value) != 0) {
        
        amountAfterDecimal++;
        value = 10 * value;
        
        if (amountAfterDecimal == 5) {
            value = 0;
        }
        
    }
    
    self.amountAfterDecimal = amountAfterDecimal;
    
    NSLog(@"%d", (int)self.amountAfterDecimal);
    
    NSString *text = [NSString stringWithFormat:@".%d", (int)self.amountAfterDecimal];
    text = [text stringByAppendingString:@"f"];
    text = [@"%" stringByAppendingString:text];
    
    self.currentValueLabel.text = [NSString stringWithFormat:text, self.currentValue];
    */
    
    NSString *text = [NSString stringWithFormat:@".%d", (int)self.answerAmountAfterDecimal];
    text = [text stringByAppendingString:@"f"];
    text = [@"%" stringByAppendingString:text];
    
    self.currentValueLabel.text = [NSString stringWithFormat:text, self.currentValue];
    
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Orientation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortraitUpsideDown | UIInterfaceOrientationMaskPortrait;
    
}

#pragma mark - Statusbar

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

#pragma mark - Actions

- (IBAction)addNumber:(UIButton *)sender {
    
    if (self.modeType == ModeTypeClassic) {
        self.currentValue = 10 * self.currentValue + sender.tag;
    } else if (self.modeType == ModeTypePoint) {
        self.amountAfterDecimal++;
        self.currentValue = self.currentValue + (float)sender.tag / pow(10.f, self.amountAfterDecimal);
    }
    
    [self showCurrentValue];
    
}

- (IBAction)addNegativeValue:(UIButton *)sender {
    
    self.currentValue = -1 * self.currentValue;
    
    [self showCurrentValue];
    
}

- (IBAction)addPercent:(UIButton *)sender {
    
    self.currentValue = self.currentValue / 100.f;
    self.amountAfterDecimal += 2;
    
    [self showCurrentValue];
    
}

- (IBAction)pointMode:(UIButton *)sender {
    
    if ((self.modeType != ModeTypePoint) && (self.amountAfterDecimal == 0)) {
        NSString *string = [self.currentValueLabel.text stringByAppendingString:@"."];
        self.currentValueLabel.text = string;
    }
    
    self.modeType = ModeTypePoint;
    
}

- (IBAction)clearValue:(UIButton *)sender {
    
    if (self.currentValue == 0) {
        self.lastValue = 0;
    } else {
        self.currentValue = 0;
    }
    
    self.amountAfterDecimal = 0;
    self.modeType = ModeTypeClassic;
    
    self.currentValueLabel.text = @"0";
    self.lastValueLabel.text = @"";
    self.operationLabel.text = @"";
    
}

- (IBAction)calculateEquation:(UIButton *)sender {
    
    if (self.lastValue != 0.f) {
        
        switch (self.operationType) {
            case OperationTypeAddition:
                self.currentValue = self.lastValue + self.currentValue;
                break;
            case OperationTypeSubtraction:
                self.currentValue = self.lastValue - self.currentValue;
                break;
            case OperationTypeMultiplication:
                self.currentValue = self.lastValue * self.currentValue;
                break;
            case OperationTypeDivision:
                self.currentValue = self.lastValue / self.currentValue;
                break;
            default:
                NSLog(@"Error");
                break;
        }
        
    }
    
    [self showAnswerValue];
    
    self.lastValueLabel.text = @"";
    self.operationLabel.text = @"";
    
    self.lastValue = 0;
    self.currentValue = 0;
    self.amountAfterDecimal = 0;
    self.modeType = ModeTypeClassic;
    
}

- (IBAction)setAmountAfterDecimalCount:(UIButton *)sender {
    
    self.answerAmountAfterDecimal = sender.tag;
    
    for (UIButton *button in self.amountAfterDecimalCountButtons) {
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             
                             if ([button isEqual:sender]) {
                                 button.backgroundColor = [UIColor colorWithRed:   4 / 255.f
                                                                          green: 113 / 255.f
                                                                           blue: 116 / 255.f
                                                                          alpha: 1.f];
                                 [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                             } else {
                                 button.backgroundColor = [UIColor colorWithRed:  80 / 255.f
                                                                          green: 227 / 255.f
                                                                           blue: 194 / 255.f
                                                                          alpha: 1.f];
                                 [button setTitleColor:[UIColor colorWithRed:   4 / 255.f
                                                                       green: 113 / 255.f
                                                                        blue: 116 / 255.f
                                                                       alpha: 1.f] forState:UIControlStateNormal];
                             }
                             
                         }];
        
    }
    
}

- (IBAction)anyButtonAction:(UIButton *)sender {
    
    SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"KeypressStandard" ofType:@"aiff"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}

- (IBAction)addOperation:(UIButton *)sender {
    
    if (sender.tag == -1) {
        self.operationType = OperationTypeAddition;
        self.operationLabel.text = @"+";
    } else if (sender.tag == -2) {
        self.operationType = OperationTypeSubtraction;
        self.operationLabel.text = @"-";
    } else if (sender.tag == -3) {
        self.operationType = OperationTypeMultiplication;
        self.operationLabel.text = @"x";
    } else if (sender.tag == -4) {
        self.operationType = OperationTypeDivision;
        self.operationLabel.text = @"÷";
    }
    
    self.lastValue = self.currentValue;
    [self showLastValue];
    
    self.currentValueLabel.text = @"";
    
    self.currentValue = 0;
    self.amountAfterDecimal = 0;
    self.modeType = ModeTypeClassic;
    
}

@end
