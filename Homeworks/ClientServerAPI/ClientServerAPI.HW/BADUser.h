//
//  BADUser.h
//  ClientServerAPI.Lesson
//
//  Created by Artem Belkov on 22/11/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BADUser : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSURL *imageURL;

- (instancetype)initWithServerResponse:(NSDictionary *) responseObject;

@end
