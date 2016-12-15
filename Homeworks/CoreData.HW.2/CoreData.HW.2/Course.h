//
//  Course.h
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Object.h"

@class University;

NS_ASSUME_NONNULL_BEGIN

@interface Course : Object

+ (Course *)addCourseWithName:(NSString *)name mainDescription:(NSString *)mainDescription level:(NSString *)level university:(University *)university;

@end

NS_ASSUME_NONNULL_END

#import "Course+CoreDataProperties.h"
