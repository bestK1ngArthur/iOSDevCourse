//
//  CoursesViewController.m
//  CoreData.Basics.Lesson
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "CoursesViewController.h"
#import "StudentsViewController.h"
#import "Course.h"
#import "University.h"
#import "CourseTableViewCell.h"

@interface CoursesViewController ()

@end

@implementation CoursesViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Courses";
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:179/255.f green:220/255.f blue:255/255.f alpha:1.f]];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (void)configureCell:(CourseTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.nameLabel.text = course.name;
    cell.universityLabel.text = course.university.name;
    cell.studentsCountLabel.text = [NSString stringWithFormat:@"%lu", [course.students count]];
    cell.teachersCountLabel.text = [NSString stringWithFormat:@"%lu", [course.teachers count]];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];

    StudentsViewController *studentsViewController = [[StudentsViewController alloc] init];
    studentsViewController.course = course;
    
    [self.navigationController pushViewController:studentsViewController animated:YES];
    */
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    CourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CourseTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    // Sort courses with name
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    // Sort courses with university name
    NSSortDescriptor *universityNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"university.name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[nameDescriptor, universityNameDescriptor]];
    
    /*
    // Check university
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"university == %@", self.university];
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
