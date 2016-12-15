//
//  Student.h
//  MultithreadingHW
//
//  Created by Artem Belkov on 25/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^Block)();

@interface Student : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) double time;

- (void)guessAnswer:(int) answer inRange:(int) maxValue andResultsBlock:(Block) resultsBlock;


@end
