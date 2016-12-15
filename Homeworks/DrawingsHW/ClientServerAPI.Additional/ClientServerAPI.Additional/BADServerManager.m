//
//  ASServerManager.m
//  APITest
//
//  Created by Oleksii Skutarenko on 20.02.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import "BADServerManager.h"
#import "AFNetworking.h"

#import "BADLoginViewController.h"

#import "BADAccessToken.h"

#import "BADUser.h"
#import "BADPost.h"

@interface BADServerManager ()

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestOperationManager;
@property (strong, nonatomic) BADAccessToken *accessToken;

@end


@implementation BADServerManager


+ (BADServerManager*) sharedManager {
    
    static BADServerManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[BADServerManager alloc] init];
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        NSURL* url = [NSURL URLWithString:@"https://api.vk.com/method/"];
        
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    }
    return self;
}

- (void)authorizeUser:(void(^)(BADUser *user)) completion {
    
    BADLoginViewController *loginController = [[BADLoginViewController alloc]
    initWithCompletionBlock:^(BADAccessToken *token) {
    
        self.accessToken = token;
        
        if (token) {
            
            [self getUser:token.userID
                onSuccess:^(BADUser *user) {
                    completion(user);
                }
                onFailure:^(NSError *error, NSInteger statusCode) {
                    if (completion) {
                        completion(nil);
                    }
                }];
                    
        } else if (completion) {
            completion(nil);
        }
        
    }];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginController];
    UIViewController *mainController = [[[UIApplication sharedApplication] windows] firstObject].rootViewController;
    
    [mainController presentViewController:navigationController animated:YES completion:nil];
    
}

- (void)getUser:(NSString *)userID
      onSuccess:(void(^)(BADUser *user)) success
      onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     userID,            @"user_ids",
     @"photo_medium",   @"fields",
     @"nom",            @"name_case", nil];
    
    [self.requestOperationManager
     GET:@"users.get"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         
         NSArray* dictsArray = [responseObject objectForKey:@"response"];
         
         if ([dictsArray count] > 0) {
             
             BADUser* user = [[BADUser alloc] initWithServerResponse:[dictsArray firstObject]];

             if (success) {
                 success(user);
             }
             
         } else {
             
             if (failure) {
                 failure(nil, operation.response.statusCode);
             }
             
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];

}

- (void)getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray *friends)) success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    NSDictionary *params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"81399783",   @"user_id",
     @"name",       @"order",
     @(count),      @"count",
     @(offset),     @"offset",
     @"photo_medium",   @"fields",
     @"nom",        @"name_case", nil];
    
    [self.requestOperationManager
     GET:@"friends.get"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         
         NSArray* dictsArray = [responseObject objectForKey:@"response"];
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in dictsArray) {
             BADUser* user = [[BADUser alloc] initWithServerResponse:dict];
             [objectsArray addObject:user];
         }
         
         if (success) {
             success(objectsArray);
         }
         
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error, operation.response.statusCode);
        }

    }];
    
}

- (void)getGetGroupWall:(NSString *) groupID
             withOffset:(NSInteger) offset
                  count:(NSInteger) count
              onSuccess:(void(^)(NSArray *posts)) success
              onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    if (![groupID hasPrefix:@"-"]) {
        groupID = [@"-" stringByAppendingString:groupID];
    }
    
    NSDictionary *params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     groupID,   @"owner_id",
     @(count),  @"count",
     @(offset), @"offset",
     @"all",    @"filter", nil];
    
    [self.requestOperationManager
     GET:@"wall.get"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         
         NSArray* dictsArray = [responseObject objectForKey:@"response"];
         
         if ([dictsArray count] > 1) {
             dictsArray = [dictsArray subarrayWithRange:NSMakeRange(1, (int)[dictsArray count] - 1)];
         } else {
             dictsArray = nil;
         }
         
         NSMutableArray* objectsArray = [NSMutableArray array];
         
         for (NSDictionary* dict in dictsArray) {
             
             BADPost* post = [[BADPost alloc] initWithServerResponse:dict];
             [objectsArray addObject:post];
         
         }
         
         if (success) {
             success(objectsArray);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
         
     }];
    
}

- (void)postText:(NSString *)text
     onGroupWall:(NSString *)groupID
       onSuccess:(void(^)(id result)) success
       onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure {
    
    if (![groupID hasPrefix:@"-"]) {
        groupID = [@"-" stringByAppendingString:groupID];
    }
    
    NSDictionary *params =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"81399783",   @"owner_id",
     text,      @"message",
     self.accessToken, @"access_token", nil];
    
    [self.requestOperationManager
     POST:@"wall.post"
     parameters:params
     success:^(AFHTTPRequestOperation *operation, NSDictionary* responseObject) {
         
         NSLog(@"%@", responseObject);
         
         if (success) {
             success(responseObject);
         }
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         if (failure) {
             failure(error, operation.response.statusCode);
         }
         
     }];
    
}

@end
