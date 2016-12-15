//
//  Kangaroo.h
//  ProtocolsHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jumpers.h"

@interface Kangaroo : NSObject <Jumpers>

@property (strong, nonatomic) NSString *color;
- (void)sayInfo;

#pragma mark- Jumpers
@property (strong, nonatomic) NSString *name;

@end
