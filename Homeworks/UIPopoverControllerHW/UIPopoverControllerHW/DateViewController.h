//
//  DateViewController.h
//  UIPopoverControllerHW
//
//  Created by Artem Belkov on 26/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DateViewControllerDelegate;

@interface DateViewController : UIViewController

@property (weak, nonatomic) id <DateViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)actionSave:(UIButton *)sender;
- (IBAction)actionDateChanged:(UIDatePicker *)sender;


@end

@protocol DateViewControllerDelegate <NSObject>

@required

- (void)changeDateOgBirth:(NSDate *)dateOfBirth;

@end
