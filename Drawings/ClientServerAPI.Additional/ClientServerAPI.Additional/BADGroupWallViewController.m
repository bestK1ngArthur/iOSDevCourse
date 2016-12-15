//
//  BADGroupWallViewController.m
//  ClientServerAPI.Additional
//
//  Created by Artem Belkov on 05/02/16.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

#import "BADGroupWallViewController.h"

#import "BADServerManager.h"

#import "BADUser.h"
#import "BADPost.h"

#import "BADPostCell.h"

@interface BADGroupWallViewController ()

@property (strong, nonatomic) NSMutableArray* postsArray;

@property (assign, nonatomic) BOOL firstTimeAppear;

@end

@implementation BADGroupWallViewController

static NSInteger postsInRequest = 20;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.postsArray = [NSMutableArray array];
    
    self.firstTimeAppear = YES;
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(refreshWall) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    
    UIBarButtonItem *plus = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                          target:self
                                                                          action:@selector(postOnWall:)];
    self.navigationItem.rightBarButtonItem = plus;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (self.firstTimeAppear) {
        
        self.firstTimeAppear = NO;
        
        [[BADServerManager sharedManager] authorizeUser:^(BADUser *user) {
            
            NSLog(@"Authorised user");
            
            [self getPostsFromServer];
            
        }];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API

- (void)postOnWall:(id)sender {
    
    [[BADServerManager sharedManager] postText:@"Test"
                                   onGroupWall:@""
                                     onSuccess:^(id result) {
                                         
                                     }
                                     onFailure:^(NSError *error, NSInteger statusCode) {
                                         
                                     }];
}

- (void)refreshWall {
    
    [[BADServerManager sharedManager]
     getGetGroupWall:@"58860049"
     withOffset:0
     count:MAX(postsInRequest, [self.postsArray count])
     onSuccess:^(NSArray *posts) {
         
         [self.postsArray removeAllObjects];
         
         [self.postsArray addObjectsFromArray:posts];
         
         [self.tableView reloadData];
         
         [self.refreshControl endRefreshing];
         
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         
         NSLog(@"error = %@, code = %ld", [error localizedDescription], (long)statusCode);
         [self.refreshControl endRefreshing];

     }];
    
}

- (void)getPostsFromServer {
    
    [[BADServerManager sharedManager]
     getGetGroupWall:@"58860049"
     withOffset:[self.postsArray count]
     count:postsInRequest
     onSuccess:^(NSArray *posts) {
         
         [self.postsArray addObjectsFromArray:posts];
         
         NSMutableArray* newPaths = [NSMutableArray array];
         for (int i = (int)[self.postsArray count] - (int)[posts count]; i < [self.postsArray count]; i++) {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.postsArray count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.postsArray count]) {
    
        static NSString *identifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.textLabel.text = @"load more";
        cell.imageView.image = nil;
        
        [self getPostsFromServer];
        
        return cell;
        
    } else {
        
        static NSString *identifier = @"PostCell";
        
        BADPostCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        BADPost *post = [self.postsArray objectAtIndex:indexPath.row];
        
        cell.postTextLabel.text = post.text;

        return cell;
    }
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.postsArray count]) {
        
        return 44.f;
        
    } else {
        
        BADPost *post = [self.postsArray objectAtIndex:indexPath.row];
        
        return [BADPostCell heightForText:post.text];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == [self.postsArray count]) {
        [self getPostsFromServer];
    }
    
}

@end
