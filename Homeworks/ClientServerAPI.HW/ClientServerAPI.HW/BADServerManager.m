//
//  BADServerManager.m
//  ClientServerAPI.Lesson
//
//  Created by Artem Belkov on 22/11/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "BADServerManager.h"
#import "BADUser.h"
#import "AFNetworking.h"

@interface BADServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestOperationManager;

@end

@implementation BADServerManager

+ (BADServerManager *) sharedManager {
    
    static BADServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BADServerManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
    
        NSURL *url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    
    }
    return self;
}

- (void) getFriendsWithOffset:(NSInteger) offset
                         count:(NSInteger) count
                     onSuccess:(void(^)(NSArray *friends)) success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"81399783", @"user_id",
                                @"name", @"order",
                                @(count), @"count",
                                @(offset), @"offset",
                                @"photo", @"fields",
                                @"nom", @"name_case", nil];
    
    [self.requestOperationManager GET:@"friends.get"
      parameters:params
         success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary *  _Nonnull responseObject) {
            
             NSLog(@"JSON: %@", responseObject);
         
             NSArray *friendsArray = [responseObject objectForKey:@"response"];
             
             NSMutableArray *objectsArray = [NSMutableArray array];
            
             for (NSDictionary *dict in friendsArray) {
        
                 BADUser *user = [[BADUser alloc] initWithServerResponse:dict];
        
                 [objectsArray addObject:user];
                 
             }
             
             if (success) {
                 success(objectsArray);
             }
             
         }
         failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             
             NSLog(@"Error: %@", error);
             
             if (failure) {
                 failure(error, operation.response.statusCode);
             }
             
         }];

}

@end
