//
//  DrawingView.m
//  DrawingsHW
//
//  Created by Artem Belkov on 03/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "DrawingView.h"

typedef NSArray Star; // Star [center, point1, point2, point3, point4, point5]

typedef enum {
    StarTypeClassic,
    StarTypeRounded,
} StarType;

@implementation DrawingView

- (void)drawRect:(CGRect)rect {
    
    //NSLog(@"drawRect:%@", NSStringFromCGRect(rect));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < 10; i++) {
        
        CGPoint center = [self getRandomPointInView:self];
        CGFloat radius = arc4random() % 25 + 25;
        
        Star *star = [self drawFivePointedStar:StarTypeRounded
                                    withCenter:center
                                        radius:radius
                                     inContext:context];
        [self addCirclesToStar:star withRadius:radius / 5 inContext:context];
        
    }
}

#pragma mark - Star

- (Star *)drawFivePointedStar:(StarType)starType withCenter:(CGPoint)center radius:(CGFloat)radius inContext:(CGContextRef)context{
    
    if (starType == StarTypeRounded) {
        
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:255 / 255.f
                                                                green:230 / 255.f
                                                                 blue:141 / 255.f
                                                                alpha:1.f].CGColor);
        
        CGFloat radiusEllipse = radius + radius / 5;
        
        CGRect rectEllipse = CGRectMake(center.x - radiusEllipse, center.y - radiusEllipse, 2 * radiusEllipse, 2 * radiusEllipse);
        CGContextAddEllipseInRect(context, rectEllipse);
        
        CGContextFillPath(context);
        
    }
    
    CGFloat angle = 72.f * M_PI / 180.f;
    
    CGPoint point1 = CGPointMake(center.x, center.y - radius);
    CGPoint point2 = CGPointMake(center.x + radius * sinf(angle), center.y - radius * cosf(angle));
    CGPoint point3 = CGPointMake(center.x + radius * sinf(angle / 2), center.y + radius * cosf(angle / 2));
    CGPoint point4 = CGPointMake(center.x - radius * sinf(angle / 2), center.y + radius * cosf(angle / 2));
    CGPoint point5 = CGPointMake(center.x - radius * sinf(angle), center.y - radius * cosf(angle));
    
    //Draw lines
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    
    CGContextSetLineWidth(context, 3);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point3.x, point3.y);
    
    CGContextMoveToPoint(context, point1.x, point1.y);
    CGContextAddLineToPoint(context, point4.x, point4.y);
    
    CGContextMoveToPoint(context, point2.x, point2.y);
    CGContextAddLineToPoint(context, point4.x, point4.y);
    
    CGContextMoveToPoint(context, point2.x, point2.y);
    CGContextAddLineToPoint(context, point5.x, point5.y);
    
    CGContextMoveToPoint(context, point3.x, point3.y);
    CGContextAddLineToPoint(context, point5.x, point5.y);
    
    CGContextStrokePath(context);
    
    //Fill star
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    
    double theta = 2.0 * M_PI * (2.0 / 5.0);
    
    CGContextMoveToPoint(context, center.x, radius * -1 + center.y);
    for (NSUInteger k=1; k<6; k++)
    {
        float x = radius * sin(k * theta);
        float y = radius * cos(k * theta);
        CGContextAddLineToPoint(context, x + center.x, y * -1 + center.y);
    }

    
    CGContextFillPath(context);
    
    
    Star *star = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:center],
                                           [NSValue valueWithCGPoint:point1],
                                           [NSValue valueWithCGPoint:point2],
                                           [NSValue valueWithCGPoint:point3],
                                           [NSValue valueWithCGPoint:point4],
                                           [NSValue valueWithCGPoint:point5], nil];
    
    return star;
}

- (void)addCirclesToStar:(Star *)star withRadius:(CGFloat)radius inContext:(CGContextRef)context {
    
    //Draw circles
    
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    
    for(int i = 1; i < [star count]; i++) {
        
        CGPoint point = [[star objectAtIndex:i] CGPointValue];
        
        CGRect rect = CGRectMake(point.x - radius, point.y - radius, 2 * radius, 2 * radius);
        rect = CGRectIntegral(rect);
        
        CGContextAddEllipseInRect(context, rect);
        
    }
    
    CGContextFillPath(context);
    
    //Draw lines
    
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    
    for (int i = 1; i < [star count]; i++) {
        
        CGPoint point = [[star objectAtIndex:i] CGPointValue];
        CGPoint nextPoint;

        if (i != [star count] - 1) {
            
            nextPoint = [[star objectAtIndex:i+1] CGPointValue];
            
        } else {
            
            nextPoint = [[star objectAtIndex:1] CGPointValue];
            
        }
        
        CGContextMoveToPoint(context, point.x, point.y);
        CGContextAddLineToPoint(context, nextPoint.x, nextPoint.y);
        
    }
    
    CGContextStrokePath(context);
    
}

#pragma mark - Other

- (CGPoint)getRandomPointInView:(UIView *)view {
    
    CGRect rect = view.bounds;
    
    CGFloat x = arc4random() % (int)CGRectGetWidth(rect) + CGRectGetMinX(rect);
    CGFloat y = arc4random() % (int)CGRectGetHeight(rect) + CGRectGetMinY(rect);
    
    return CGPointMake(x, y);
    
}

@end
