//
//  StudentsViewController.m
//  CoreData.Basics.Lesson
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "StudentsViewController.h"
#import "Course.h"
#import "University.h"
#import "Student.h"
#import "StudentTableViewCell.h"
#import "StudentViewController.h"

@interface StudentsViewController ()

@property (strong, nonatomic) UIColor *greenScoreColor;
@property (strong, nonatomic) UIColor *redScoreColor;

@end

@implementation StudentsViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.redScoreColor = [UIColor colorWithRed: 148.f / 255.f
                                         green:  37.f / 255.f
                                          blue:  53.f / 255.f
                                         alpha: 1.f];
    
    self.greenScoreColor = [UIColor colorWithRed:  62.f / 255.f
                                           green: 131.f / 255.f
                                            blue: 105.f / 255.f
                                           alpha: 1.f];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:179/255.f green:220/255.f blue:255/255.f alpha:1.f]];
    [self.tableView setRowHeight:77];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (void)configureCell:(StudentTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Student *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Set student info
    cell.fullNameLabel.text = [student fullName];
    cell.scoreLabel.text = [NSString stringWithFormat:@"%1.2f", [student.score floatValue]];
    cell.photoView.image = [User image:[UIImage imageNamed:student.photo] scaledToSize:CGSizeMake(60, 60)];
    cell.addressLabel.text = [student fullAddress];
    
    // Set color for score view
    if ([student.score floatValue] == 4) {
        cell.scoreView.image = [UIImage imageNamed:@"scoreViewPurple"];
    } else if ([student.score floatValue] >= 3.4) {
        cell.scoreView.image = [UIImage imageNamed:@"scoreViewGreen"];
    } else if (([student.score floatValue] < 3.4) && ([student.score floatValue] >= 2.5)) {
        cell.scoreView.image = [UIImage imageNamed:@"scoreViewYellow"];
    } else {
        cell.scoreView.image = [UIImage imageNamed:@"scoreViewRed"];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    StudentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {

        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StudentTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Student *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    StudentViewController *studentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"StudentViewController"];
    studentViewController.student = student;
    
    [self.navigationController pushViewController:studentViewController animated:YES];
    
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    // Sort students with name
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [fetchRequest setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
    
    /*
    // Check course
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"courses contains %@", self.course];
    [fetchRequest setPredicate:predicate];
    */
     
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

@end
