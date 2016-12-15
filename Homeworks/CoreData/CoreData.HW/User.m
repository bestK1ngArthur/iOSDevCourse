//
//  User.m
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "User.h"

@implementation User

- (NSString *)fullName {
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    
    return fullName;
}

- (NSString *)fullAddress {
    
    NSString *fullAddress = [NSString stringWithFormat:@"%@, %@", self.city, self.country];
    
    return fullAddress;
}

#pragma mark - Image

+ (NSString *)randomFaceImageNameForGender:(Gender)gender {
    
    NSString *imageName;
    
    if (gender == GenderMale) {
        
        NSString *chars = @"ABCDEFGHIJKLMNO";
        
        NSInteger charIndex = (NSInteger)arc4random_uniform((int)[chars length]);
        NSInteger number = arc4random_uniform(5);
        
        imageName = [NSString stringWithFormat:@"%C0%d.png", [chars characterAtIndex: charIndex], (int)number];
        
    } else if (gender == GenderFemale) {
        
        NSString *chars = @"ABCDEFGHI";
        
        NSInteger charIndex = (NSInteger)arc4random_uniform((int)[chars length]);
        NSInteger number = arc4random_uniform(5);
        
        imageName = [NSString stringWithFormat:@"F%C0%d.png", [chars characterAtIndex: charIndex], (int)number];
        
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    if (!image) {
        imageName = [User randomFaceImageNameForGender:gender];
    }
    
    return imageName;
}

+ (UIImage *)image:(UIImage*)originalImage scaledToSize:(CGSize)size { // Change image size
    //avoid redundant drawing
    if (CGSizeEqualToSize(originalImage.size, size))
    {
        return originalImage;
    }
    
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    //draw
    [originalImage drawInRect:CGRectMake(0.0f, 0.0f, size.width, size.height)];
    
    //capture resultant image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return image
    return image;
}

@end
