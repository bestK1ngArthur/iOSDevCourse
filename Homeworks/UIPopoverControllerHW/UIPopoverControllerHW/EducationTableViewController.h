//
//  EducationTableViewController.h
//  UIPopoverControllerHW
//
//  Created by Artem Belkov on 27/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EducationTableViewControllerDelegate <NSObject>

@required

- (void)changeEducationType:(NSString *)educationType;

@end

@interface EducationTableViewController : UITableViewController

@property (weak, nonatomic) id <EducationTableViewControllerDelegate> delegate;


@end
