//
//  EducationTableViewController.m
//  UIPopoverControllerHW
//
//  Created by Artem Belkov on 27/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "EducationTableViewController.h"

@interface EducationTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableViewCell *lastCell;
@property (strong, nonatomic) NSArray *educationTypes;

@end

@implementation EducationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    self.title = @"Choose education";
    self.lastCell = nil;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(actionSave)];
    
    self.educationTypes = [NSArray arrayWithObjects:@"Early childhood",
                                                    @"Primary",
                                                    @"Secondary",
                                                    @"Higher",
                                                    @"Vocational",
                                                    @"Special", nil];
}

- (void)actionSave {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.educationTypes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont fontWithName:@"Avenir Next" size:18];
        
    }
    
    cell.textLabel.text = [[self.educationTypes objectAtIndex:indexPath.row] stringByAppendingString:@" edication"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (self.lastCell) {
        self.lastCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [self.delegate changeEducationType:[self.educationTypes objectAtIndex:indexPath.row]];
    
    self.lastCell = cell;
    
}

@end
