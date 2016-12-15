//
//  Cheetah.h
//  ProtocolsHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Runners.h"

typedef enum {
    spottedCheetahFur,
    nonSpottedCheetahFur
}CheetahFur;

@interface Cheetah : NSObject <Runners>

@property (assign, nonatomic) CheetahFur fur;
- (void)sayInfo;

#pragma mark- Runners

@property (strong, nonatomic) NSString *name;


@end
