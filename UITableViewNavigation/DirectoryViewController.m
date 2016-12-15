//
//  DirectoryViewController.m
//  UITableViewNavigationHW
//
//  Created by Artem Belkov on 23/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "DirectoryViewController.h"

@interface DirectoryViewController ()

@property (strong, nonatomic) NSArray *contents;

@property (strong, nonatomic) NSString *selectedPath;

@end

@implementation DirectoryViewController

- (void)setPath:(NSString *)path {
    
    _path = path;
    
    NSError *error = nil;
    NSMutableArray *contents = [NSMutableArray arrayWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.path
                                                                                                                  error:&error]];
    NSMutableArray *newContents = [NSMutableArray array];
    
    for (NSString *fileName in contents) {
        
        NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
    
        BOOL isDirectory = NO;
        
        [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        if ((![[fileName substringToIndex:1] isEqual:@"."]) && (isDirectory)) {
            [newContents addObject:fileName];
        }
    }
    
    for (NSString *fileName in contents) {
        
        NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
        
        BOOL isDirectory = NO;
        
        [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
        
        if ((![[fileName substringToIndex:1] isEqual:@"."]) && (!isDirectory)) {
            [newContents addObject:fileName];
        }
    }
    
    self.contents = [NSArray arrayWithArray:newContents];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    [self.tableView reloadData];
    
    self.navigationItem.title = [self.path lastPathComponent];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [self.path lastPathComponent];
    
    if (!self.path) {
        self.path = @"/Volumes/Disk/users/artembelkov";
    }
    
    self.tableView.editing = NO;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionEdit:)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAdd:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:editButton, addButton, nil];
}

#pragma mark - File Actions

- (BOOL)isDirectoryAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
    
    BOOL isDirectory = NO;
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}

- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellIndetifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndetifier];
    }
    
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    
    cell.textLabel.text = fileName;
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        
        cell.imageView.image = [UIImage imageNamed:@"Folder.png"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    } else {
        
        cell.imageView.image = [UIImage imageNamed:@"File.png"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = [self checkFileSizeWithName:fileName];
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(editingStyle == UITableViewCellEditingStyleDelete){
        
        NSString *filePath = [self.path stringByAppendingPathComponent:[self.contents objectAtIndex:indexPath.row]];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        
        NSMutableArray *newContents = [NSMutableArray arrayWithArray:self.contents];
        [newContents removeObjectAtIndex:indexPath.row];
        self.contents = newContents;
        
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [tableView endUpdates];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        
        NSString *fileName = [self.contents objectAtIndex:indexPath.row];
        NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
        
        DirectoryViewController *directoryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DirectoryViewController"];
        directoryViewController.path = filePath;
        [self.navigationController pushViewController:directoryViewController animated:YES];
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}

#pragma mark - Orientation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - Actions

- (IBAction)actionAdd:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Create directory"
                                                                   message:@"Enter directory name"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * __nonnull textField) {
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Create"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             
                             UITextField *textField = [[alert textFields] objectAtIndex:0];
                             
                             NSString *filePath = [self.path stringByAppendingPathComponent:textField.text];
                             [[NSFileManager defaultManager] createDirectoryAtPath:filePath
                                                       withIntermediateDirectories:NO
                                                                        attributes:nil
                                                                             error:nil];
                             
                             [self setPath:self.path];
                             
                             [self.tableView reloadData];
                         }];
    
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (IBAction)actionEdit:(id)sender {
    
    BOOL isEditing = self.tableView.isEditing;
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] init];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionAdd:)];
    
    if (isEditing) {
        
        editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(actionEdit:)];
        
    } else {
        
        editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(actionEdit:)];
    
    }
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:editButton, addButton, nil];
    
    [self.tableView setEditing:!isEditing animated:YES];
}

#pragma mark - Files

- (NSString *)checkFileSizeWithName:(NSString *)fileName {
    
    NSString *filePath = [self.path stringByAppendingPathComponent:fileName];

    BOOL isDirectory = NO;
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    NSDictionary *attributesOfFile = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath
                                                                                      error:nil];
    NSInteger fileSize = (int)[attributesOfFile valueForKey:@"NSFileSize"] /8;
    
    if (fileSize < 1024) {
        return [NSString stringWithFormat:@"%dB", (int)fileSize];
    }
    
    fileSize /= 1024;
    if (fileSize < 1024) {
        return [NSString stringWithFormat:@"%dKB", (int)fileSize];
    }
    
    fileSize /= 1024;
    if (fileSize < 1024) {
        return [NSString stringWithFormat:@"%dMB", (int)fileSize];
    }
    
    return @"";
}

@end
