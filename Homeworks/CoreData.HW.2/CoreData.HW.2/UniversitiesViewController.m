//
//  UniversityViewController.m
//  CoreData.Basics.Lesson
//
//  Created by Artem Belkov on 15/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "UniversitiesViewController.h"
#import "CoursesViewController.h"
#import "University.h"

@interface UniversitiesViewController ()

@end

@implementation UniversitiesViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Universities";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    University *university = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = university.name;
    cell.detailTextLabel.text = nil;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    University *university = [self.fetchedResultsController objectAtIndexPath:indexPath];

    CoursesViewController *coursesViewController = [[CoursesViewController alloc] init];
    coursesViewController.university = university;
    
    [self.navigationController pushViewController:coursesViewController animated:YES];
    
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];

    NSEntityDescription *description = [NSEntityDescription entityForName:@"University" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    // Sort university with name
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[nameDescriptor]];
    
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
