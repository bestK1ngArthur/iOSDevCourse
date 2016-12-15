//
//  Student.m
//  MultithreadingHW
//
//  Created by Artem Belkov on 25/06/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "Student.h"

@implementation Student

+ (dispatch_queue_t)createQueue {
    
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.artembelkov.MultiThreadingHW.queue", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
    
}

- (void)guessAnswer:(int)answer inRange:(int) maxValue andResultsBlock:(Block) resultsBlock {
    
    dispatch_async([Student createQueue], ^{
        
        double startTime = CACurrentMediaTime();
        
        NSLog(@"Student %@ started", self.name);
        
        int value = arc4random() % maxValue;
        int attemptsCount = 0;
        
        while (value != answer) {
            attemptsCount++;
            value = arc4random() % maxValue;
        }
        
        self.time = CACurrentMediaTime() - startTime;
        
        NSLog(@"Student %@ finished in %f with %d attempts", self.name, self.time, attemptsCount); //Pupil
        
        resultsBlock(); //Student
        
    });
    
}

@end
