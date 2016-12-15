//
//  Human.h
//  ArraysHW
//
//  Created by Artem Belkov on 17/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Human : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) float height;
@property (assign, nonatomic) float weight;
@property (strong, nonatomic) NSString *gender;

- (void)move;
- (NSString *)getInfo;

@end
