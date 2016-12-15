//
//  BADServerManager.h
//  ClientServerAPI.Lesson
//
//  Created by Artem Belkov on 22/11/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BADServerManager : NSObject

+ (BADServerManager *) sharedManager;

- (void) getFriendsWithOffset:(NSInteger) offset
                        count:(NSInteger) count
                    onSuccess:(void(^)(NSArray *friends)) success
                    onFailure:(void(^)(NSError *error, NSInteger statusCode)) failure;

@end
