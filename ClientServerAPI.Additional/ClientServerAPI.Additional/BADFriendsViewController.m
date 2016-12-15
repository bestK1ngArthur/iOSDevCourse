//
//  ViewController.m
//  ClientServerAPI.Additional
//
//  Created by Artem Belkov on 01/12/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "BADFriendsViewController.h"

#import "BADServerManager.h"
#import "UIImageView+AFNetworking.h"

#import "BADUser.h"

@interface BADFriendsViewController ()

@property (strong, nonatomic) NSMutableArray* friendsArray;

@property (assign, nonatomic) BOOL firstTimeAppear;

@end

@implementation BADFriendsViewController

static NSInteger friendsInRequest = 20;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.friendsArray = [NSMutableArray array];
    
    [self getFriendsFromServer];
    
    self.firstTimeAppear = YES;
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (self.firstTimeAppear) {
        
        self.firstTimeAppear = NO;
        
        [[BADServerManager sharedManager] authorizeUser:^(BADUser *user) {
            
            NSLog(@"Authorised user");
            
        }];
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void) getFriendsFromServer {
    
    [[BADServerManager sharedManager]
     getFriendsWithOffset:[self.friendsArray count]
     count:friendsInRequest
     onSuccess:^(NSArray *friends) {
         
         [self.friendsArray addObjectsFromArray:friends];
         
         NSMutableArray* newPaths = [NSMutableArray array];
         for (int i = (int)[self.friendsArray count] - (int)[friends count]; i < [self.friendsArray count]; i++) {
             [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
         }
         
         [self.tableView beginUpdates];
         [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationTop];
         [self.tableView endUpdates];
         
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
     }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.friendsArray count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == [self.friendsArray count]) {
        
        cell.textLabel.text = @"end cell";
        cell.imageView.image = nil;
        
        [self getFriendsFromServer];
        
    } else {
        
        BADUser* friend = [self.friendsArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend.firstName, friend.lastName];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:friend.imageURL];
        
        __weak UITableViewCell* weakCell = cell;
        
        cell.imageView.image = nil;
        
        [cell.imageView
         setImageWithURLRequest:request
         placeholderImage:nil
         success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
             weakCell.imageView.image = image;
             [weakCell layoutSubviews];
         }
         failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
             
         }];
        
    }
    
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == [self.friendsArray count]) {
        [self getFriendsFromServer];
    }
    
}

@end
