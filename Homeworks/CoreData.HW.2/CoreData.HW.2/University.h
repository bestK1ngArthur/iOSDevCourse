//
//  University.h
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Object.h"

NS_ASSUME_NONNULL_BEGIN

@interface University : Object

+ (University *)addUniversityWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

#import "University+CoreDataProperties.h"
