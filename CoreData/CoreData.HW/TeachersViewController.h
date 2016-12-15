//
//  TeachersViewController.h
//  CoreData.HW
//
//  Created by Artem Belkov on 20/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "CoreDataTableViewController.h"

@class Course;

@interface TeachersViewController : CoreDataTableViewController

@property (strong, nonatomic) Course *course;

@end
