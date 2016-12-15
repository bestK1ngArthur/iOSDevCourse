//
//  ViewController.h
//  UITextFieldHW
//
//  Created by Artem Belkov on 06/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;


@end

