//
//  Jumpers.h
//  ProtocolsHW
//
//  Created by Artem Belkov on 21/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Jumpers <NSObject>

@property (strong, nonatomic) NSString *name;

@required
- (void)jump;

@optional
- (void)fly;

@end