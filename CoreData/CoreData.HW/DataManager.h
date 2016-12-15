//
//  DataManager.h
//  CoreData.Basics.Lesson
//
//  Created by Artem Belkov on 15/08/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (DataManager *)sharedManager;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (void)generateAndAddUniversity;

@end
