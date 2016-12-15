//
//  DirectoryViewController.h
//  UITableViewNavigationHW
//
//  Created by Artem Belkov on 23/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectoryViewController : UITableViewController

@property (strong, nonatomic) NSString *path;

- (IBAction)actionAdd:(id)sender;
- (IBAction)actionEdit:(id)sender;

@end
