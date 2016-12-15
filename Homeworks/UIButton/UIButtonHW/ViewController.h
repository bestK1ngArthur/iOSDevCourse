//
//  ViewController.h
//  UIButtonHW
//
//  Created by Artem Belkov on 04/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

typedef enum {
    ModeTypePoint,
    ModeTypeClassic,
} ModeType;

typedef enum {
    OperationTypeAddition,
    OperationTypeSubtraction,
    OperationTypeMultiplication,
    OperationTypeDivision,
} OperationType;

@interface ViewController : UIViewController

#pragma mark - Labels

@property (strong, nonatomic) IBOutlet UILabel *currentValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *operationLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastValueLabel;

#pragma mark - Buttons

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *amountAfterDecimalCountButtons;


#pragma mark - Variables

@property (assign, nonatomic) CGFloat lastValue;
@property (assign, nonatomic) CGFloat currentValue;

@property (assign, nonatomic) OperationType operationType;
@property (assign, nonatomic) ModeType modeType;
@property (assign, nonatomic) NSInteger amountAfterDecimal;

#pragma mark - Actions

- (IBAction)addNumber:(UIButton *)sender;
- (IBAction)addOperation:(UIButton *)sender;

- (IBAction)addNegativeValue:(UIButton *)sender;
- (IBAction)addPercent:(UIButton *)sender;

- (IBAction)pointMode:(UIButton *)sender;
- (IBAction)clearValue:(UIButton *)sender;

- (IBAction)calculateEquation:(UIButton *)sender;

- (IBAction)setAmountAfterDecimalCount:(UIButton *)sender;


- (IBAction)anyButtonAction:(UIButton *)sender;

@end

