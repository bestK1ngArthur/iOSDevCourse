//
//  Swimmers.h
//  ProtocolsHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Swimmers <NSObject>

@property (strong, nonatomic) NSString *name;

@required
- (void)swim;

@optional
- (void)dive;

@end