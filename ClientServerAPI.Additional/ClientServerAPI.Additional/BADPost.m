//
//  BADPost.m
//  ClientServerAPI.Additional
//
//  Created by Artem Belkov on 05/02/16.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

#import "BADPost.h"

@implementation BADPost

- (id) initWithServerResponse:(NSDictionary*) responseObject
{
    self = [super initWithServerResponse:responseObject];
    if (self) {
        
        self.text = [responseObject objectForKey:@"text"];
        self.text = [self.text stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        
    }
    return self;
}

@end
