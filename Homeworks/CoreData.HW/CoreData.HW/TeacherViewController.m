//
//  TeacherViewController.m
//  CoreData.HW
//
//  Created by Artem Belkov on 31/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "TeacherViewController.h"
#import "Course.h"
#import "Teacher.h"
#import "University.h"
#import "DataManager.h"

@interface TeacherViewController ()

@end

@implementation TeacherViewController

- (NSManagedObjectContext *)managedObjectContext {
    
    if (!_managedObjectContext) {
        
        _managedObjectContext = [[DataManager sharedManager] managedObjectContext];
        
    }
    
    return _managedObjectContext;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set title
    self.navigationItem.title = [self.teacher fullName];
    
    // Set general info
    self.universityLabel.text = self.teacher.university.name;
    self.photoView.image = [UIImage imageNamed:self.teacher.photo];
    
    // Set rank info
    self.rankLabel.text = [[self.teacher.rank substringToIndex:3] uppercaseString];
    if ([self.teacher.rank  isEqual: @"Legendary"]) {
        self.rankView.image = [UIImage imageNamed:@"scoreViewPurpleReversed"];
    } else if ([self.teacher.rank  isEqual: @"Senior"]) {
        self.rankView.image = [UIImage imageNamed:@"scoreViewGreenReversed"];
    } else if ([self.teacher.rank  isEqual: @"Middle"]) {
        self.rankView.image = [UIImage imageNamed:@"scoreViewYellowReversed"];
    } else {
        self.rankView.image = [UIImage imageNamed:@"scoreViewRedReversed"];
    }
    
    
    // Set tint color
    UIColor *blueColor = [UIColor colorWithRed: 179.f / 255.f
                                         green: 220.f / 255.f
                                          blue: 255.f / 255.f
                                         alpha: 1.f ];
    [[self.navigationController navigationBar] setTintColor:blueColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeOrientation:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
    [self updateOrientation];
    
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateOrientation {
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
        
        self.addressLabel.text = @"";
        self.fullNameLabel.text = self.teacher.firstName;
        
    } else {
        
        self.addressLabel.text = [self.teacher fullAddress];
        self.fullNameLabel.text = [self.teacher fullName];
        
    }
    
}

- (void)didChangeOrientation:(NSNotification *)notification {
    
    [self updateOrientation];
    
}

#pragma mark - Table View

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = course.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", (int)[course.teachers count]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.textColor = [UIColor colorWithRed: 179.f / 255.f
                                                   green: 220.f / 255.f
                                                    blue: 255.f / 255.f
                                                   alpha: 1.f ];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:  38.f / 255.f
                                               green:  68.f / 255.f
                                                blue: 111.f / 255.f
                                               alpha: 1.f ];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        
        Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.teacher removeCoursesObject:course];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView endUpdates];
        
    }
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
    [fetchRequest setSortDescriptors:@[nameDescriptor]];
    
    // Check student in courses
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teachers contains %@", self.teacher];
    [fetchRequest setPredicate:predicate];
    
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

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.coursesTableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.coursesTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.coursesTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.coursesTableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.coursesTableView endUpdates];
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
