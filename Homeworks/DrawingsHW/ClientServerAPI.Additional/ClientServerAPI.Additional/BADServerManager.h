//
//  ASServerManager.h
//  APITest
//
//  Created by Oleksii Skutarenko on 20.02.14.
//  Copyright (c) 2014 Alex Skutarenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BADUser;

@interface BADServerManager : NSObject

@property (strong, nonatomic, readonly) BADUser *currentUser;

+ (BADServerManager*) sharedManager;

- (void) authorizeUser:(void(^)(BADUser *user)) completion;

- (void)getUser:(NSString *)userID
      onSuccess:(void(^)(BADUser *user)) success
      onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)getFriendsWithOffset:(NSInteger) offset
                       count:(NSInteger) count
                   onSuccess:(void(^)(NSArray *friends)) success
                   onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)getGetGroupWall:(NSString *) groupID
             withOffset:(NSInteger) offset
                  count:(NSInteger) count
              onSuccess:(void(^)(NSArray *posts)) success
              onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

- (void)postText:(NSString *)text
     onGroupWall:(NSString *)groupID
       onSuccess:(void(^)(id result)) success
       onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

@end
