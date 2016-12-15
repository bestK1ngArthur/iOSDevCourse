//
//  Course+CoreDataProperties.h
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "Course.h"

NS_ASSUME_NONNULL_BEGIN

@interface Course (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *mainDescription;
@property (nullable, nonatomic, retain) NSString *level;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *students;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *teachers;
@property (nullable, nonatomic, retain) University *university;

@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(NSManagedObject *)value;
- (void)removeStudentsObject:(NSManagedObject *)value;
- (void)addStudents:(NSSet<NSManagedObject *> *)values;
- (void)removeStudents:(NSSet<NSManagedObject *> *)values;

- (void)addTeachersObject:(NSManagedObject *)value;
- (void)removeTeachersObject:(NSManagedObject *)value;
- (void)addTeachers:(NSSet<NSManagedObject *> *)values;
- (void)removeTeachers:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
