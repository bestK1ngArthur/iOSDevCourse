//
//  ViewController.m
//  UITextFieldHW
//
//  Created by Artem Belkov on 06/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"

typedef enum {
    
    TextFieldTagFirstName = 1,
    TextFieldTagLastName  = 2,
    TextFieldTagUserName  = 3,
    TextFieldTagPassword  = 4,
    TextFieldTagAge       = 5,
    TextFieldTagPhone     = 6,
    TextFieldTagEmail     = 7,
    
} TextFieldTag;

typedef enum {
    
    DirectionTypeUp,
    DirectionTypeDown,
    
} DirectionType;

typedef enum {
    
    MainViewPositionUp,
    MainViewPositionDown,
    
} MainViewPosition;

@interface ViewController ()

@property (assign, nonatomic) CGFloat mainViewScreenShifting;
@property (assign, nonatomic) MainViewPosition mainViewPosition;
@property (assign, nonatomic) NSInteger atSignCount;

@end

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainViewPosition = MainViewPositionDown;
    self.mainViewScreenShifting = 210.f;

    //[[self.textFields objectAtIndex:0] becomeFirstResponder];
    
}

- (void)moveMainViewInTheDirection:(DirectionType)direction {
    
    if ((direction == DirectionTypeUp) && (self.mainViewPosition == MainViewPositionDown)) {
        
        CGPoint newCenter = CGPointMake(CGRectGetMidX(self.view.frame),
                                CGRectGetMidY(self.view.frame) - self.mainViewScreenShifting);
        
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = newCenter;
                         }];
        
        self.mainViewPosition = MainViewPositionUp;
        
    } else if ((direction == DirectionTypeDown) && (self.mainViewPosition == MainViewPositionUp))  {
        
        
        CGPoint newCenter = CGPointMake(CGRectGetMidX(self.view.frame),
                                        CGRectGetMidY(self.view.frame) + self.mainViewScreenShifting);
        
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.view.center = newCenter;
                         }];
        
        self.mainViewPosition = MainViewPositionDown;
        
    }
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

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(nonnull UITextField *)textField {
    
    if ((textField.tag == TextFieldTagAge) || (textField.tag == TextFieldTagPhone) || (textField.tag == TextFieldTagEmail)) {
        [self moveMainViewInTheDirection:DirectionTypeUp];
    }
    
    if ((textField.tag == TextFieldTagPassword) || (textField.tag == TextFieldTagUserName)) {
        [self moveMainViewInTheDirection:DirectionTypeDown];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(nonnull UITextField *)textField {
    
    NSInteger index = [self.textFields indexOfObject:textField];
    UILabel *label = [self.labels objectAtIndex:index];
    
    label.text = textField.text;
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSInteger currentTextFieldIndex = [self.textFields indexOfObject:textField];
    NSInteger lastTextFieldIndex = [self.textFields indexOfObject:[self.textFields lastObject]];
    
    if (currentTextFieldIndex < lastTextFieldIndex) {
        
        if (textField.tag == TextFieldTagPassword) {
            [self moveMainViewInTheDirection:DirectionTypeUp];
        }
        
        UITextField *nextTextField = [self.textFields objectAtIndex:currentTextFieldIndex + 1];
        [nextTextField becomeFirstResponder];
        
    } else if (currentTextFieldIndex == lastTextFieldIndex) {
        
        [self moveMainViewInTheDirection:DirectionTypeDown];
        
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ((textField.tag == TextFieldTagFirstName) || (textField.tag == TextFieldTagLastName) || (textField.tag == TextFieldTagPassword)) {
        
        if ([textField.text length] >= 12) {
            return NO;
        }
    
    } else if (textField.tag == TextFieldTagUserName) {
        
        if (![textField.text hasPrefix:@"@"]) {
            textField.text = [NSString stringWithFormat:@"@%@", textField.text];
        }
        
        if ([textField.text length] >= 13) {
            return NO;
        }
        
    } else if (textField.tag == TextFieldTagAge) {
        
        if ([textField.text length] >= 2) {
            return NO;
        }
        
        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        NSString *newString = [components componentsJoinedByString:@""];
        textField.text = [textField.text stringByAppendingString:newString];
        
        return NO;
        
    } else if (textField.tag == TextFieldTagPhone) {
        
        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        if ([components count] > 1) {
            return NO;
        }
        
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        NSArray *validComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
        newString = [validComponents componentsJoinedByString:@""];
        
        //Phone Format
        // XXX-XXXX -> (XXX) XXX-XXXX -> +XXX (XXX) XXX-XXXX
        
        //Lengths
        static const int localNumberMaxLength = 7;
        static const int areaCodeMaxLength = 3;
        static const int countryCodeMaxLength = 3;
        
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
            return NO;
        }
        
        NSMutableString *resultString = [NSMutableString string];
        
        //Local Number
        NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
        
        if (localNumberLength > 0) {
            
            NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
            
            [resultString appendString:number];
            
            if ([resultString length] > 3) {
                [resultString insertString:@"-" atIndex:3];
            }
        }
        
        //Area Code
        if ([newString length] > localNumberLength) {
            
            NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
            
            NSRange areaRange = NSMakeRange((int)[newString length] - localNumberLength - areaCodeLength, areaCodeLength);
            
            NSString *areaCode = [newString substringWithRange:areaRange];
            areaCode = [NSString stringWithFormat:@"(%@) ", areaCode];
            
            [resultString insertString:areaCode atIndex:0];
            
        }
        
        //Country Code
        if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
            
            NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
            
            NSRange countryRange = NSMakeRange(0, countryCodeLength);
            
            NSString *countryCode = [newString substringWithRange:countryRange];
            countryCode = [NSString stringWithFormat:@"+%@ ", countryCode];
            
            [resultString insertString:countryCode atIndex:0];
            
        }
        
        textField.text = resultString;
        
        return NO;
        
    } else if (textField.tag == TextFieldTagEmail) {
        
        if ([textField.text length] >= 22) {
            return NO;
        }
        
        NSCharacterSet *validationSet = [NSCharacterSet characterSetWithCharactersInString:@"^|!#$&*()=+;:'~`,/\?% []{}"];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        
        for (NSString *component in components) {
            if ([component  isEqual: @"@"]) {
                self.atSignCount++;
            }
        }
        
        if (([components count] > 1) || (([string isEqualToString:@"@"]) && (self.atSignCount > 1))) {
            return NO;
        }
        
    }
    
    return YES;
}

@end
