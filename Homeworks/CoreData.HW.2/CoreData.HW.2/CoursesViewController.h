//
//  CoursesViewController.h
//  CoreData.Basics.Lesson
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "CoreDataTableViewController.h"

@class University;

@interface CoursesViewController : CoreDataTableViewController

@property (strong, nonatomic) University *university;

@end

