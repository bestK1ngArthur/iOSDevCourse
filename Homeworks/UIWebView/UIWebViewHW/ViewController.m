//
//  ViewController.m
//  UIWebViewHW
//
//  Created by Artem Belkov on 05/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.inRequest) {
        [self.webView loadRequest:self.inRequest];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
    
    self.backButton.enabled = [self.webView canGoBack];
    self.forwardButton.enabled = [self.webView canGoForward];
    
}

#pragma mark - Actions

- (IBAction)goForward:(id)sender {
    
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
    
}

- (IBAction)goBack:(id)sender {
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    
}

@end
