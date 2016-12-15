//
//  Runners.h
//  ProtocolsHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Runners <NSObject>

@property (strong, nonatomic) NSString *name;

@required
- (void)run;

@optional
- (void)stop;

@end