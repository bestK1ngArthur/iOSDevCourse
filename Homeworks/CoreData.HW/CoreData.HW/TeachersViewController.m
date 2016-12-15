//
//  TeachersViewController.m
//  CoreData.HW
//
//  Created by Artem Belkov on 20/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "TeachersViewController.h"

#import "Course.h"
#import "Teacher.h"

#import "TeacherTableViewCell.h"
#import "TeacherViewController.h"

@interface TeachersViewController ()

@end

@implementation TeachersViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:179/255.f green:220/255.f blue:255/255.f alpha:1.f]];
    [self.tableView setRowHeight:77];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (void)configureCell:(TeacherTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Teacher *teacher = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Set teacher info
    cell.fullNameLabel.text = [teacher fullName];
    cell.rankLabel.text = [[teacher.rank substringToIndex:3] uppercaseString];
    cell.photoView.image = [User image:[UIImage imageNamed:teacher.photo] scaledToSize:CGSizeMake(60, 60)];
    cell.addressLabel.text = [teacher fullAddress];
    
    // Set color for rank view
    if ([teacher.rank  isEqual: @"Legendary"]) {
        cell.rankView.image = [UIImage imageNamed:@"scoreViewPurple"];
    } else if ([teacher.rank  isEqual: @"Senior"]) {
        cell.rankView.image = [UIImage imageNamed:@"scoreViewGreen"];
    } else if ([teacher.rank  isEqual: @"Middle"]) {
        cell.rankView.image = [UIImage imageNamed:@"scoreViewYellow"];
    } else {
        cell.rankView.image = [UIImage imageNamed:@"scoreViewRed"];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    TeacherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TeacherTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Teacher *teacher = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    TeacherViewController *teacherViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TeacherViewController"];
    teacherViewController.teacher = teacher;
    
    [self.navigationController pushViewController:teacherViewController animated:YES];
    
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Teacher" inManagedObjectContext:self.managedObjectContext];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
