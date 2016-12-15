//
//  University.h
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface University : SimpleObject

+ (University *)universityWithName:(NSString *)name;
+ (University *)universityWithName:(NSString *)name courses:(NSArray *)courses randomTeachersWithCount:(NSInteger)teachersCount andRandomStudentsWithCount:(NSInteger)studentsCount;
@end

NS_ASSUME_NONNULL_END

#import "University+CoreDataProperties.h"
