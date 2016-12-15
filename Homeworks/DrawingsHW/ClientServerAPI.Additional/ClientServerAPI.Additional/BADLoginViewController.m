//
//  BADViewController.m
//  ClientServerAPI.Additional
//
//  Created by Artem Belkov on 03/12/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "BADLoginViewController.h"

#import "BADAccessToken.h"

@interface BADLoginViewController () <UIWebViewDelegate>

@property (copy, nonatomic) BADLoginCompletionBlock completionBlock;
@property (weak, nonatomic) UIWebView *webView;

@end

@implementation BADLoginViewController

- (instancetype) initWithCompletionBlock:(void(^)(BADAccessToken *token)) completionBlock {
    
    self = [super init];
    if (self) {
        
        self.completionBlock = completionBlock;
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:frame];

    webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:webView];
    
    self.webView = webView;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                          target:self
                                                                          action:@selector(actionCancel:)];
    [self.navigationItem setRightBarButtonItem:item animated:NO];
    
    self.navigationItem.title = @"Login";
    
    NSString *urlString = @"https://oauth.vk.com/authorize?"
                           "client_id=4872749&"
                           "scope=139286&" // + 2 + 4 + 16 + 131072 + 8192 + 262144
                           "redirect_uri=&"
                           "display=touch&"
                           "v=5.44&"
                           "response_type=token";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    webView.delegate = self;
    
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionCancel:(id)sender {
    
    if (self.completionBlock) {
        self.completionBlock(nil);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)dealloc {
    self.webView.delegate = nil;
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (([[[request URL] path] isEqualToString:@"/blank.html"]) && ([[[request URL] host] isEqualToString:@"oauth.vk.com"])) {
        
        BADAccessToken *token = [[BADAccessToken alloc] init];
        
        NSString *query = [[request URL] description];
        
        NSArray *array = [query componentsSeparatedByString:@"#"];
        
        if ([array count] > 1) {
            query = [array lastObject];
        }
        
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        
        for (NSString *pair in pairs) {
            
            NSArray *values = [pair componentsSeparatedByString:@"="];
            
            if ([values count] == 2) {
                
                NSString *key = [values firstObject];
                
                if ([key isEqualToString:@"access_token"]) {
                    
                    token.token = [values lastObject];
                    
                } else if ([key isEqualToString:@"expires_in"]) {
                    
                    NSTimeInterval interval = [[values lastObject] doubleValue];
                    token.expirationDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                    
                } else if ([key isEqualToString:@"user_id"]) {
                    
                    token.userID = [values lastObject];
                    
                }
                
            }
            
        }
        
        self.webView.delegate = nil;
        
        if (self.completionBlock) {
            self.completionBlock(token);
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        return NO;
    }
    
    NSLog(@"%@", [[request URL] host]);
    
    return YES;
}

@end
