//
//  University.m
//  CoreData.HW
//
//  Created by Artem Belkov on 19/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "University.h"

#import "DataManager.h"

@implementation University

+ (University *)addUniversityWithName:(NSString *)name {
    
    NSManagedObjectContext *managedObjectContext = [[DataManager sharedManager] managedObjectContext];
    
    University *university = [NSEntityDescription insertNewObjectForEntityForName:@"University"
                                                     inManagedObjectContext: managedObjectContext];
    
    university.name = name;
    
    return university;
}

@end
