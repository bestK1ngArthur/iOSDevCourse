//
//  StudentsViewController.h
//  CoreData.Basics.Lesson
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "CoreDataTableViewController.h"

@class Course;

@interface StudentsViewController : CoreDataTableViewController

@property (strong, nonatomic) Course *course;

@end
