//
//  BADServerObject.h
//  ClientServerAPI.Additional
//
//  Created by Artem Belkov on 05/02/16.
//  Copyright © 2016 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BADServerObject : NSObject

- (id) initWithServerResponse:(NSDictionary*) responseObject;

@end
