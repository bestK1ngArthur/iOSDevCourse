//
//  TableViewController.m
//  UIWebViewHW
//
//  Created by Artem Belkov on 05/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"

@interface TableViewController ()

@property (strong, nonatomic) NSDictionary *dictionary;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *urlString1 = @"http://vk.com/iosdevcourse";
    NSURL *url1 = [NSURL URLWithString:urlString1];
    NSURLRequest *request1 = [NSURLRequest requestWithURL:url1];
    
    NSString *urlString2 = @"http://habrahabr.ru";
    NSURL *url2 = [NSURL URLWithString:urlString2];
    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
    
    NSDictionary *links = [NSDictionary dictionaryWithObjectsAndKeys:request1, @"iOS Dev Course", request2, @"Habr", nil];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"iphone_user_guide" ofType:@"pdf"];
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    NSURLRequest *fileRequest = [NSURLRequest requestWithURL:fileUrl];
    
    NSDictionary *files = [NSDictionary dictionaryWithObject:fileRequest forKey:@"iPhone User Guide"];
    
    self.dictionary = [NSDictionary dictionaryWithObjectsAndKeys:links, @"Links", files, @"Files", nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.dictionary allKeys] count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *key = [[self.dictionary allKeys] objectAtIndex:section];
    
    return key;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSString *key = [[self.dictionary allKeys] objectAtIndex:section];
    
    NSDictionary *rowDictionary = [self.dictionary objectForKey:key];
    
    return [[rowDictionary allKeys] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
        NSString *sectionKey = [[self.dictionary allKeys] objectAtIndex:indexPath.section];
        
        NSDictionary *rowDictionary = [self.dictionary objectForKey:sectionKey];
        NSString *rowKey = [[rowDictionary allKeys] objectAtIndex:indexPath.row];
        
        cell.textLabel.text = rowKey;
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *sectionKey = [[self.dictionary allKeys] objectAtIndex:indexPath.section];
    
    NSDictionary *rowDictionary = [self.dictionary objectForKey:sectionKey];
    NSString *rowKey = [[rowDictionary allKeys] objectAtIndex:indexPath.row];
    
    NSURLRequest *request = [rowDictionary objectForKey:rowKey];
    
    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    viewController.inRequest = request;
    [self.navigationController pushViewController:viewController animated:YES];
    
}

@end
