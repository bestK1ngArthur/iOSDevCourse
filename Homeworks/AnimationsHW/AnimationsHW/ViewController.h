//
//  ViewController.h
//  AnimationsHW
//
//  Created by Artem Belkov on 30/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *views;

@property (strong, nonatomic) NSMutableArray *centers;

@end

