//
//  Swimmer.h
//  ProtocolsHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Swimmers.h"
#import "Runners.h"

@interface Swimmer : NSObject <Swimmers, Runners>

@property (assign, nonatomic) float *experience;
- (void)sayInfo;

#pragma mark- Swimmers

@property (strong, nonatomic) NSString *name;

@end
