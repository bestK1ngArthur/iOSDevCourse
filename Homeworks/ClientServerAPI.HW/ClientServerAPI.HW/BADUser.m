//
//  BADUser.m
//  ClientServerAPI.Lesson
//
//  Created by Artem Belkov on 22/11/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "BADUser.h"

@implementation BADUser

- (instancetype)initWithServerResponse:(NSDictionary *) responseObject {
    
    self = [super init];
    if (self) {
        
        self.firstName = [responseObject objectForKey:@"first_name"];
        self.lastName = [responseObject objectForKey:@"last_name"];
        
        NSString *urlString = [responseObject objectForKey:@"photo"];
        
        if (urlString) {
            self.imageURL = [NSURL URLWithString:urlString];
        }
        
    }
    
    return self;
}


@end
